import 'package:delivery_app/core/config/api_endpoint_controller.dart';
import 'package:delivery_app/core/debug/debug_log_store.dart';
import 'package:delivery_app/core/network/dio/dio_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test(
    'updates existing Dio clients when the Gateway origin changes',
    () async {
      final endpoint = ApiEndpointController.memory(
        defaultGatewayOrigin: 'http://localhost:8079',
      );
      final client = DioClient(endpointController: endpoint);
      addTearDown(client.dispose);

      expect(client.dio.options.baseUrl, 'http://localhost:8079/api');

      await endpoint.setGatewayOrigin('https://gateway.example');

      expect(client.dio.options.baseUrl, 'https://gateway.example/api');
    },
  );

  test('records sanitized API request and response diagnostics', () async {
    final endpoint = ApiEndpointController.memory(
      defaultGatewayOrigin: 'http://localhost:8079',
    );
    final client = DioClient(endpointController: endpoint);
    final adapter = DioAdapter(dio: client.dio);
    addTearDown(client.dispose);
    DebugLogStore.instance.clear();

    adapter.onPost(
      '/debug',
      (server) => server.reply(200, {
        'status': 1,
        'data': {'ok': true},
      }),
      data: {'password': 'do-not-render'},
    );

    await client.dio.post<dynamic>(
      '/debug',
      data: {'password': 'do-not-render'},
    );

    final entries = DebugLogStore.instance.entries;
    expect(
      entries.any((entry) => entry.phase == DebugApiPhase.request),
      isTrue,
    );
    expect(
      entries.any(
        (entry) =>
            entry.phase == DebugApiPhase.response && entry.statusCode == 200,
      ),
      isTrue,
    );
    expect(
      entries.every((entry) => !entry.message.contains('do-not-render')),
      isTrue,
    );
    expect(entries.every((entry) => entry.requestBody == null), isTrue);
    expect(entries.every((entry) => entry.responseBody == null), isTrue);
  });
}
