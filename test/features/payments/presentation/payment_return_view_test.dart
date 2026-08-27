import 'package:delivery_app/features/payments/presentation/views/payment_return_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'disabled payment boundary does not build the supplied WebView child',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentReturnView(
            enabled: false,
            paymentSurface: Text('native webview'),
          ),
        ),
      );

      expect(find.text('Thanh toán trực tuyến chưa được bật.'), findsOneWidget);
      expect(find.text('native webview'), findsNothing);
    },
  );
}
