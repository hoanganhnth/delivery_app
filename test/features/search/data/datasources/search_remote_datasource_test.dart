import 'package:delivery_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late SearchRemoteDataSource dataSource;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    dataSource = SearchRemoteDataSourceImpl(dio);
  });

  test('searches restaurants through the Gateway API prefix once', () async {
    adapter.onGet(
      '/search/restaurants',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Thành công',
        'data': {'items': <Object>[]},
      }),
      queryParameters: {'q': 'pho', 'page': 0, 'size': 20},
    );

    expect(await dataSource.searchRestaurants('pho'), isEmpty);
  });

  test('searches dishes through the Gateway API prefix once', () async {
    adapter.onGet(
      '/search/dishes',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Thành công',
        'data': {'items': <Object>[]},
      }),
      queryParameters: {'q': 'bun', 'page': 0, 'size': 20},
    );

    expect(await dataSource.searchDishes('bun'), isEmpty);
  });

  test('rejects a raw page without the canonical envelope', () async {
    adapter.onGet(
      '/search/restaurants',
      (server) => server.reply(200, {'content': <Object>[]}),
      queryParameters: {'q': 'pho', 'page': 0, 'size': 20},
    );

    await expectLater(
      dataSource.searchRestaurants('pho'),
      throwsA(isA<FormatException>()),
    );
  });

  test('rejects a successful envelope with malformed page data', () async {
    adapter.onGet(
      '/search/dishes',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Thành công',
        'data': {'items': null},
      }),
      queryParameters: {'q': 'bun', 'page': 0, 'size': 20},
    );

    await expectLater(
      dataSource.searchDishes('bun'),
      throwsA(isA<FormatException>()),
    );
  });
}
