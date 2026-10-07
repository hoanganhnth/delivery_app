import 'package:delivery_app/core/config/api_endpoint_controller.dart';
import 'package:delivery_app/core/debug/debug_log_store.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:delivery_app/core/network/dio/token_storage.dart';
import 'package:delivery_app/core/network/dio/interceptors/logging_interceptor.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/core/network/resources/page_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class _Tokens extends Fake implements TokenStorage {
  @override
  Future<String?> getAccessToken() async => 'access';
}

void main() {
  test(
    'round trips generic response and page fields, including error envelope',
    () {
      final json = {
        'items': [7, 8],
        'page': 2,
        'size': 2,
        'totalItems': 8,
        'totalPages': 4,
        'hasNext': true,
      };
      final page = PageDto<int>.fromJson(json, (v) => v as int);
      expect(page.toJson((v) => v), json);
      final envelope = {
        'status': 0,
        'message': 'denied',
        'data': json,
        'error': {'code': 'FORBIDDEN'},
      };
      final response = BaseResponseDto<PageDto<int>>.fromJson(
        envelope,
        (v) =>
            PageDto<int>.fromJson(v as Map<String, dynamic>, (i) => i as int),
      );
      expect(response.isError, true);
      expect(response.isSuccess, false);
      expect(response.toJson((v) => v.toJson((i) => i)), envelope);
      final empty = BaseResponseDto<int>.fromJson({
        'status': 1,
        'message': 'ok',
        'data': null,
        'error': null,
      }, (v) => v as int);
      expect(empty.isSuccess, true);
      expect(empty.toJson((i) => i)['data'], isNull);
    },
  );
  test('network providers compose and dispose configured clients', () async {
    final endpoint = ApiEndpointController.memory(
      defaultGatewayOrigin: 'http://gateway.test',
    );
    final container = ProviderContainer(
      overrides: [apiEndpointControllerProvider.overrideWithValue(endpoint)],
    );
    final plain = container.read(dioProvider);
    final authenticated = container.read(authenticatedDioProvider);
    expect(plain.options.baseUrl, 'http://gateway.test/api');
    expect(authenticated.options.connectTimeout, const Duration(seconds: 15));
    await endpoint.setGatewayOrigin('https://other.test');
    expect(plain.options.baseUrl, 'https://other.test/api');
    expect(authenticated.options.baseUrl, 'https://other.test/api');
    container.dispose();
    endpoint.dispose();
  });
  test('authenticated factory attaches bearer token and app version', () async {
    final endpoint = ApiEndpointController.memory(
      defaultGatewayOrigin: 'http://gateway.test',
    );
    final client = createAuthenticatedDio(
      tokenStorage: _Tokens(),
      endpointController: endpoint,
    );
    addTearDown(() {
      client.close();
      endpoint.dispose();
    });
    final adapter = DioAdapter(dio: client);
    adapter.onGet(
      '/notifications/unread-count',
      (s) => s.reply(200, {'status': 1, 'message': 'ok', 'data': 0}),
    );
    final response = await client.get<dynamic>('/notifications/unread-count');
    expect(response.requestOptions.headers['Authorization'], 'Bearer access');
    expect(response.requestOptions.headers['App-Version'], '1.0.0');
  });
  test('logging preserves timeout errors and omits query secrets', () async {
    final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    addTearDown(dio.close);
    DebugLogStore.instance.clear();
    dio.interceptors.add(LoggingInterceptor());
    final adapter = DioAdapter(dio: dio);
    adapter.onGet(
      '/notifications/unread-count',
      (server) => server.throws(
        408,
        DioException(
          requestOptions: RequestOptions(path: '/notifications/unread-count'),
          type: DioExceptionType.receiveTimeout,
        ),
      ),
      queryParameters: {'token': 'private-value'},
    );
    await expectLater(
      dio.get<dynamic>(
        '/notifications/unread-count',
        queryParameters: {'token': 'private-value'},
      ),
      throwsA(
        isA<DioException>().having(
          (e) => e.type,
          'type',
          DioExceptionType.receiveTimeout,
        ),
      ),
    );
    final entries = DebugLogStore.instance.entries;
    expect(entries.any((e) => e.phase == DebugApiPhase.error), true);
    expect(entries.every((e) => !e.message.contains('private-value')), true);
  });
}
