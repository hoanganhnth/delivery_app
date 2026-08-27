import 'dart:async';

import 'package:delivery_app/core/services/deep_link/i_deep_link_service.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:go_router/go_router.dart';

/// Feature-owned bridge from the domain-agnostic deep-link service to payment
/// return handling. It is inert when the build capability is disabled.
class PaymentDeepLinkHandler {
  const PaymentDeepLinkHandler({
    required this.enabled,
    required this.coordinator,
    this.onUnhandledLink,
  });

  final bool enabled;
  final PaymentReturnCoordinator coordinator;
  final void Function(Uri uri)? onUnhandledLink;

  void handle(Uri uri) {
    if (coordinator.isExpectedReturnUri(uri)) {
      if (enabled) {
        unawaited(coordinator.handleDeepLink(uri));
      }
      return;
    }
    onUnhandledLink?.call(uri);
  }
}

/// Production composition helper. The core service remains unaware of
/// payment routes; the router composition supplies the feature callback.
Future<void> initializePaymentDeepLinks({
  required IDeepLinkService deepLinkService,
  required GoRouter router,
  required PaymentDeepLinkHandler handler,
}) => deepLinkService.initialize(router, onLinkReceived: handler.handle);
