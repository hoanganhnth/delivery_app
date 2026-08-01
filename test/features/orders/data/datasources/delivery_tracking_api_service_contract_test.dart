import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test(
    'reads current delivery through the canonical order lookup route',
    () async {
      final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
      final adapter = DioAdapter(dio: dio);
      final service = DeliveryTrackingApiService(dio);

      adapter.onGet(
        '/deliveries/order/101',
        (server) => server.reply(200, {
          'status': 1,
          'message': 'Success',
          'data': null,
        }),
      );

      final response = await service.getCurrentDelivery(101);

      expect(response.status, 1);
      expect(response.data, isNull);
    },
  );
}
