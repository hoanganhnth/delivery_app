import 'dart:async';

import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/core/routing/providers/router_provider.dart';
import 'package:delivery_app/core/routing/providers/router_config.dart';
import 'package:delivery_app/core/routing/models/app_router_config.dart';
import 'package:delivery_app/core/services/deep_link/_riverpod/deep_link_provider.dart';
import 'package:delivery_app/core/services/deep_link/i_deep_link_service.dart';
import 'package:delivery_app/features/auth/application/session/auth_notifier.dart';
import 'package:delivery_app/features/auth/application/session/auth_state.dart';
import 'package:delivery_app/features/payments/application/payment_deep_link_handler.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:delivery_app/features/payments/domain/entities/payment_order.dart';
import 'package:delivery_app/features/payments/di/payment_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

void main() {
  test(
    'production deep-link initializer forwards payment callbacks to coordinator',
    () async {
      final deepLinks = _FakeDeepLinkService();
      final refreshStarted = Completer<void>();
      final refresher = _CompletingRefresher(refreshStarted);
      final coordinator = PaymentReturnCoordinator(
        expectedReturnUrl: Uri.parse('delivery://payments/vnpay-return'),
        statusRefresher: refresher,
      );
      final router = GoRouter(
        routes: [GoRoute(path: '/', builder: (_, _) => const SizedBox())],
      );

      await initializePaymentDeepLinks(
        deepLinkService: deepLinks,
        router: router,
        handler: PaymentDeepLinkHandler(
          enabled: true,
          coordinator: coordinator,
        ),
      );
      deepLinks.emit(
        Uri.parse(
          'delivery://payments/vnpay-return?vnp_TxnRef=PAY-301&vnp_ResponseCode=00',
        ),
      );

      await refreshStarted.future;
      expect(refresher.references, ['PAY-301']);
    },
  );

  test('non-payment deep links retain the router fallback', () {
    final fallbackUris = <Uri>[];
    final handler = PaymentDeepLinkHandler(
      enabled: true,
      coordinator: PaymentReturnCoordinator(
        expectedReturnUrl: Uri.parse('delivery://payments/vnpay-return'),
        statusRefresher: _CompletingRefresher(Completer<void>()),
      ),
      onUnhandledLink: fallbackUris.add,
    );

    handler.handle(Uri.parse('delivery://orders/42'));

    expect(fallbackUris, [Uri.parse('delivery://orders/42')]);
  });

  test('production router composition registers the payment handler', () async {
    final deepLinks = _FakeDeepLinkService();
    final refresher = _CompletingRefresher(Completer<void>());
    final container = ProviderContainer(
      overrides: [
        authProvider.overrideWithValue(const AuthState.unauthenticated()),
        routerConfigProvider.overrideWithValue(
          const AppRouterConfig(enableRedirects: false),
        ),
        deepLinkServiceProvider.overrideWithValue(deepLinks),
        customerPaymentStatusRefresherProvider.overrideWithValue(refresher),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(routerProvider);
    addTearDown(router.dispose);

    expect(deepLinks.initializedRouter, same(router));
    expect(deepLinks.hasHandler, isTrue);

    deepLinks.emit(
      Uri.parse(
        'delivery://payments/vnpay-return?vnp_TxnRef=PAY-303&vnp_ResponseCode=00',
      ),
    );
    await Future<void>.delayed(Duration.zero);

    if (RuntimeConfig.vnpayPaymentEnabled) {
      await refresher.started.future;
      expect(refresher.references, ['PAY-303']);
    } else {
      // The production default is disabled, so a callback cannot refresh or
      // claim payment success merely because the app received a deep link.
      expect(refresher.references, isEmpty);
    }
  });

  test(
    'payment deep-link handler is inert while the capability is disabled',
    () async {
      final refresher = _CompletingRefresher(Completer<void>());
      final handler = PaymentDeepLinkHandler(
        enabled: false,
        coordinator: PaymentReturnCoordinator(
          expectedReturnUrl: Uri.parse('delivery://payments/vnpay-return'),
          statusRefresher: refresher,
        ),
        onUnhandledLink: (_) {},
      );

      handler.handle(
        Uri.parse(
          'delivery://payments/vnpay-return?vnp_TxnRef=PAY-302&vnp_ResponseCode=00',
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(refresher.references, isEmpty);
    },
  );
}

class _FakeDeepLinkService implements IDeepLinkService {
  DeepLinkHandler? _handler;
  GoRouter? initializedRouter;

  @override
  Future<void> initialize(
    GoRouter router, {
    DeepLinkHandler? onLinkReceived,
  }) async {
    initializedRouter = router;
    _handler = onLinkReceived;
  }

  bool get hasHandler => _handler != null;

  void emit(Uri uri) => _handler?.call(uri);

  @override
  String? getPendingRoute() => null;

  @override
  String generateDeepLink({
    required String baseUrl,
    required String path,
    Map<String, String>? params,
  }) => Uri.parse(
    baseUrl,
  ).replace(path: path, queryParameters: params).toString();
}

class _CompletingRefresher implements PaymentStatusRefresher {
  _CompletingRefresher(this.started);

  final Completer<void> started;
  final List<String> references = <String>[];

  @override
  Future<PaymentOrder> refresh(String paymentRef) async {
    references.add(paymentRef);
    if (!started.isCompleted) started.complete();
    return PaymentOrder(
      paymentRef: paymentRef,
      status: PaymentStatus.succeeded,
    );
  }
}
