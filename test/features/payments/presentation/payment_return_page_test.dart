import 'package:delivery_app/features/payments/presentation/pages/payment_return_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('default build leaves the native payment page disabled', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: PaymentReturnPage(
            paymentUrl: Uri.parse('https://sandbox.example.test/pay'),
            expectedReturnUrl: Uri.parse('delivery://payments/vnpay-return'),
          ),
        ),
      ),
    );

    expect(find.text('Thanh toán trực tuyến chưa được bật.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
