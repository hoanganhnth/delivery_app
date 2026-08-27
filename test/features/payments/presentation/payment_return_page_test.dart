import 'package:delivery_app/features/payments/presentation/pages/payment_return_page.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:delivery_app/features/payments/di/payment_providers.dart';
import 'package:delivery_app/features/payments/domain/entities/payment_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('default build leaves the native payment page disabled', (
    tester,
  ) async {
    final observer = _PaymentCoordinatorObserver();
    await tester.pumpWidget(
      ProviderScope(
        observers: [observer],
        overrides: [
          paymentReturnCoordinatorProvider.overrideWithValue(
            PaymentReturnCoordinator(
              expectedReturnUrl: Uri.parse('delivery://payments/vnpay-return'),
              statusRefresher: _NoopRefresher(),
            ),
          ),
        ],
        child: MaterialApp(
          home: PaymentReturnPage(
            paymentUrl: Uri.parse('https://sandbox.example.test/pay'),
          ),
        ),
      ),
    );

    expect(find.text('Thanh toán trực tuyến chưa được bật.'), findsOneWidget);
    expect(tester.takeException(), isNull);
    expect(observer.initialized, isTrue);
  });
}

final class _PaymentCoordinatorObserver extends ProviderObserver {
  bool initialized = false;

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    if (context.provider == paymentReturnCoordinatorProvider) {
      initialized = true;
    }
  }
}

class _NoopRefresher implements PaymentStatusRefresher {
  @override
  Future<PaymentOrder> refresh(String paymentRef) async =>
      PaymentOrder(paymentRef: paymentRef, status: PaymentStatus.pending);
}
