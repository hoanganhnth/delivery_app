import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart';
import 'package:delivery_app/features/restaurants/data/dtos/get_restaurants_request_dto.dart';
import 'package:delivery_app/features/restaurants/data/dtos/search_restaurants_request_dto.dart';
import 'package:delivery_app/features/restaurants/data/dtos/restaurant_dto.dart';
import 'package:delivery_app/features/restaurants/data/dtos/menu_item_dto.dart';
import 'package:delivery_app/features/restaurants/data/repositories_impl/restaurant_repository_impl.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../support/data_http_harness.dart';

const restaurant = <String, dynamic>{
  'id': 11,
  'name': 'Phở',
  'description': 'Soup',
  'address': '1 Lê Lợi',
  'phone': '0900000001',
  'image': 'restaurant.png',
  'openingHour': '08:00:00',
  'closingHour': '22:00:00',
  'latitude': 10.7,
  'longitude': 106.7,
};
const menu = <String, dynamic>{
  'id': 21,
  'restaurantId': 11,
  'name': 'Phở bò',
  'description': 'Beef',
  'price': 50000,
  'image': 'menu.png',
  'status': 'AVAILABLE',
};

void main() {
  final paths = [
    '/restaurants',
    '/restaurants/11',
    '/menu-items/restaurant/11/available',
    '/restaurants/search',
  ];
  for (var operation = 0; operation < paths.length; operation++) {
    for (final scenario in [
      'success',
      'rejected',
      'null',
      '401',
      '500',
      'timeout',
      'malformed',
    ]) {
      test(
        '${paths[operation]} maps $scenario and records the exact query',
        () async {
          final http = DataHttpHarness();
          final repository = RestaurantRepositoryImpl(
            remoteDataSource: RestaurantRemoteDataSourceImpl(
              RestaurantApiService(http.dio),
            ),
          );
          final payload = operation == 1
              ? restaurant
              : [operation == 2 ? menu : restaurant];
          http.timeout = scenario == 'timeout';
          http.reply(
            'GET',
            paths[operation],
            scenario == 'malformed'
                ? dataEnvelope(
                    operation == 1
                        ? {'id': 'bad'}
                        : [
                            {'id': 'bad'},
                          ],
                  )
                : scenario == '401' || scenario == '500'
                ? {'message': 'Denied'}
                : dataEnvelope(
                    scenario == 'null' ? null : payload,
                    status: scenario == 'rejected' ? 0 : 1,
                  ),
            code: int.tryParse(scenario) ?? 200,
          );
          final result = switch (operation) {
            0 => await repository.getRestaurants(
              latitude: 10.7,
              longitude: 106.7,
              category: 'pho',
              searchQuery: 'pho',
              page: 2,
              limit: 10,
            ),
            1 => await repository.getRestaurantById(11),
            2 => await repository.getMenuItems(11),
            _ => await repository.searchRestaurants(
              query: 'pho',
              latitude: 10.7,
              longitude: 106.7,
              category: 'pho',
              page: 2,
              limit: 10,
            ),
          };
          final request = http.requests.single;
          expect(request.method, 'GET');
          expect(request.path, paths[operation]);
          expect(
            request.queryParameters,
            operation == 3 ? {'keyword': 'pho'} : isEmpty,
          );
          expect(request.data, isNull);
          if (scenario == 'success') {
            result.fold((f) => fail(f.message), (value) {
              if (operation == 2) {
                final item = (value as List<MenuItemEntity>).single;
                expect(item.id, 21);
                expect(item.restaurantId, 11);
                expect(item.name, 'Phở bò');
                expect(item.description, 'Beef');
                expect(item.price, 50000);
                expect(item.image, 'menu.png');
                expect(item.status, MenuItemStatus.available);
              } else {
                final item = operation == 1
                    ? value as RestaurantEntity
                    : (value as List<RestaurantEntity>).single;
                expect(item.id, 11);
                expect(item.name, 'Phở');
                expect(item.description, 'Soup');
                expect(item.address, '1 Lê Lợi');
                expect(item.phone, '0900000001');
                expect(item.image, 'restaurant.png');
                expect(item.addressLat, 10.7);
                expect(item.addressLng, 106.7);
                expect(item.openingHour, '08:00:00');
                expect(item.closingHour, '22:00:00');
              }
            });
          } else {
            result.fold((failure) {
              expect(
                failure,
                scenario == 'timeout'
                    ? isA<NetworkFailure>()
                    : scenario == '401'
                    ? isA<UnauthorizedFailure>()
                    : scenario == 'malformed'
                    ? isA<UnexpectedFailure>()
                    : isA<ServerFailure>(),
              );
              if (scenario == 'timeout') {
                expect(failure.message, 'Connection timeout');
              }
              if (scenario == '401' || scenario == '500') {
                expect(failure.message, 'Denied');
              }
              if (scenario == 'null' || scenario == 'rejected') {
                expect(
                  failure.message,
                  scenario == 'null' ? 'Success' : 'Rejected',
                );
              }
            }, (_) => fail('Expected failure'));
          }
        },
      );
    }
  }
  test('DTOs deserialize filters and serialize all response fields', () {
    final catalog = GetRestaurantsRequestDto.fromJson({
      'latitude': 10.7,
      'longitude': 106.7,
      'category': 'pho',
      'searchQuery': 'beef',
      'page': 2,
      'limit': 10,
    });
    expect(catalog.latitude, 10.7);
    expect(catalog.longitude, 106.7);
    expect(catalog.category, 'pho');
    expect(catalog.searchQuery, 'beef');
    expect(catalog.page, 2);
    expect(catalog.limit, 10);
    expect(catalog.toJson(), isEmpty);
    final search = SearchRestaurantsRequestDto.fromJson({
      'keyword': 'beef',
      'latitude': 10.7,
      'longitude': 106.7,
      'category': 'pho',
      'page': 2,
      'limit': 10,
    });
    expect(search.keyword, 'beef');
    expect(search.latitude, 10.7);
    expect(search.longitude, 106.7);
    expect(search.category, 'pho');
    expect(search.page, 2);
    expect(search.limit, 10);
    expect(search.toJson(), {'keyword': 'beef'});
    final dto = RestaurantDto.fromJson(restaurant);
    expect(RestaurantDto.fromJson(dto.toJson()), dto);
    final item = MenuItemDto.fromJson(menu);
    expect(MenuItemDto.fromJson(item.toJson()), item);
  });
}
