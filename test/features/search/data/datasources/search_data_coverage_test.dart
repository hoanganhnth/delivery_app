import 'package:delivery_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:delivery_app/features/search/data/models/search_result_model.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  final restaurant = {
    'id': 'r1',
    'name': 'Pho',
    'description': 'Soup',
    'cuisine': 'VN',
    'rating': 4.5,
    'imageUrl': 'https://img/r',
  };
  final dish = {
    'id': 'd1',
    'name': 'Bun',
    'description': 'Noodles',
    'price': 50000.0,
    'restaurantId': 'r1',
    'imageUrl': 'https://img/d',
  };
  late Dio dio;
  late DioAdapter adapter;
  late SearchRemoteDataSourceImpl source;
  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    source = SearchRemoteDataSourceImpl(dio);
  });
  tearDown(() => dio.close());
  for (final isDish in [false, true]) {
    final path = isDish ? '/search/dishes' : '/search/restaurants';
    Future<dynamic> call() => isDish
        ? source.searchDishes('pho & bun', page: 2, size: 5)
        : source.searchRestaurants('pho & bun', page: 2, size: 5);
    void reply(Object? body, {int status = 200}) => adapter.onGet(
      path,
      (server) => server.reply(status, body),
      queryParameters: {'q': 'pho & bun', 'page': 2, 'size': 5},
    );
    test('maps full $path DTO and custom pagination query', () async {
      final json = isDish ? dish : restaurant;
      reply({
        'status': 1,
        'message': 'ok',
        'data': {
          'items': [json],
        },
      });
      final result = await call();
      expect(result, hasLength(1));
      expect(result.single.toJson(), json);
    });
    for (final body in [
      {
        'status': 0,
        'message': 'failed',
        'data': {'items': []},
      },
      {
        'status': 1,
        'data': {'items': []},
      },
      {'status': 1, 'message': 'ok'},
      {
        'status': 1,
        'message': 'ok',
        'data': {
          'items': ['invalid'],
        },
      },
      {
        'status': 1,
        'message': 'ok',
        'data': {
          'items': [{}],
        },
      },
    ]) {
      test('rejects malformed $path payload $body', () async {
        reply(body);
        await expectLater(call(), throwsA(anything));
      });
    }
    for (final status in [400, 503]) {
      test('preserves HTTP $status error for $path', () async {
        reply({'message': 'failure'}, status: status);
        await expectLater(
          call(),
          throwsA(
            isA<DioException>().having(
              (e) => e.response?.statusCode,
              'status',
              status,
            ),
          ),
        );
      });
    }
    test('preserves timeout for $path', () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (r, h) => h.reject(
            DioException(
              requestOptions: r,
              type: DioExceptionType.connectionTimeout,
            ),
          ),
        ),
      );
      await expectLater(
        call(),
        throwsA(
          isA<DioException>().having(
            (e) => e.type,
            'type',
            DioExceptionType.connectionTimeout,
          ),
        ),
      );
    });
  }
  test('optional fields default to null and shipper DTO round trips', () {
    expect(
      RestaurantSearchResult.fromJson({'id': '1', 'name': 'n'}).rating,
      isNull,
    );
    expect(DishSearchResult.fromJson({'id': '1', 'name': 'n'}).price, isNull);
    final shipper = {
      'id': 's1',
      'name': 'Driver',
      'vehicleType': 'bike',
      'licensePlate': 'AB',
      'rating': 5.0,
      'isOnline': true,
    };
    expect(ShipperSearchResult.fromJson(shipper).toJson(), shipper);
    expect(
      ShipperSearchResult.fromJson({'id': 's', 'name': 'n'}).isOnline,
      isNull,
    );
  });
  test('provider composes the configured Dio datasource', () async {
    final container = ProviderContainer(
      overrides: [dioProvider.overrideWithValue(dio)],
    );
    addTearDown(container.dispose);
    adapter.onGet(
      '/search/dishes',
      (s) => s.reply(200, {
        'status': 1,
        'message': 'ok',
        'data': {'items': []},
      }),
      queryParameters: {'q': 'bun', 'page': 0, 'size': 20},
    );
    expect(
      await container.read(searchRemoteDataSourceProvider).searchDishes('bun'),
      isEmpty,
    );
  });
}
