import 'package:delivery_app/core/services/push/firebase_push_adapters.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('token adapter uses canonical authenticated self routes', () async {
    final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    final adapter = DioAdapter(dio: dio);
    final service = DioPushTokenBackendAdapter(dio);

    adapter.onPost(
      '/firebase/register-token',
      (server) => server.reply(200, {
        'status': 1,
        'data': null,
        'message': 'registered',
      }),
      data: {'token': 'device-token'},
    );
    adapter.onPost(
      '/firebase/unregister-token',
      (server) => server.reply(200, {
        'status': 1,
        'data': null,
        'message': 'unregistered',
      }),
      data: {'token': 'device-token'},
    );

    await service.registerToken('device-token');
    await service.unregisterToken('device-token');
  });
}
