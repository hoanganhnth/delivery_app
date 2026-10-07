import 'package:delivery_app/features/payments/data/customer_payment_gateway.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test(
    'backend unsupported boundary preserves the existing refreshFailed outcome',
    () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
      final adapter = DioAdapter(dio: dio);
      adapter.onGet(
        '/settlement/payments/ref/PAY-200',
        (server) => server.reply(409, {
          'status': 0,
          'message': 'CUSTOMER_PAYMENT_OWNERSHIP_UNSUPPORTED',
          'data': null,
        }),
      );
      final coordinator = PaymentReturnCoordinator(
        expectedReturnUrl: Uri.parse('delivery://payments/vnpay-return'),
        statusRefresher: ApiCustomerPaymentGateway(dio),
      );
      final result = await coordinator.handleDeepLink(
        Uri.parse(
          'delivery://payments/vnpay-return?vnp_TxnRef=PAY-200&vnp_ResponseCode=00',
        ),
      );
      expect(result.kind, PaymentReturnOutcomeKind.refreshFailed);
    },
  );
  test(
    'does not accept a payment projection the backend does not provide',
    () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
      final adapter = DioAdapter(dio: dio);
      adapter.onGet(
        '/settlement/payments/ref/PAY-200',
        (server) => server.reply(200, {
          'status': 1,
          'message': 'Payment status',
          'data': {'paymentRef': 'PAY-200', 'status': 'SUCCESS'},
        }),
      );

      await expectLater(
        ApiCustomerPaymentGateway(dio).refresh('PAY-200'),
        throwsUnsupportedError,
      );
    },
  );
}
