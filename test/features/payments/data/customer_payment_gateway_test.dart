import 'package:delivery_app/features/payments/data/customer_payment_gateway.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('payment status refresh uses the Gateway reference contract', () async {
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

    final payment = await ApiCustomerPaymentGateway(dio).refresh('PAY-200');

    expect(payment.paymentRef, 'PAY-200');
    expect(payment.status.name, 'succeeded');
  });
}
