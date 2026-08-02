import 'package:delivery_app/features/orders/data/datasources/refund_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test(
    'reads customer refund status through the canonical Gateway GET route',
    () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
      final adapter = DioAdapter(dio: dio);
      final service = RefundApiService(dio);

      adapter.onGet(
        '/settlement/refunds/my',
        (server) => server.reply(200, {
          'status': 1,
          'message': 'Thành công',
          'data': [
            {
              'refundId': 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
              'orderId': 101,
              'paymentMethod': 'ONLINE',
              'trigger': 'ORDER_CANCELLED',
              'status': 'MANUAL_REVIEW',
              'currency': 'VND',
              'refundAmount': 120000,
              'createdAt': '2026-08-02T10:00:00',
              'updatedAt': '2026-08-02T10:05:00',
              'processedAt': null,
            },
          ],
        }),
        queryParameters: const {'limit': 50},
      );

      final response = await service.getMyRefundCases(50);

      expect(response.status, 1);
      expect(response.data, hasLength(1));
      expect(response.data?.single.orderId, 101);
      expect(response.data?.single.status, 'MANUAL_REVIEW');
    },
  );
}
