import 'package:delivery_app/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart';
import 'package:delivery_app/features/restaurants/data/dtos/get_restaurants_request_dto.dart';
import 'package:delivery_app/features/restaurants/data/dtos/search_restaurants_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Map<String, dynamic> _response(Object? data) => {
  'status': 1,
  'message': 'Success',
  'data': data,
};

Map<String, dynamic> _restaurant() => {
  'id': 11,
  'name': 'Phở Test',
  'description': 'Restaurant contract fixture',
  'address': '1 Lê Lợi',
  'phone': '0900000001',
  'image': null,
  'openingHour': '08:00:00',
  'closingHour': '22:00:00',
  'addressLat': 10.7769,
  'addressLng': 106.7009,
};

Map<String, dynamic> _menuItem() => {
  'id': 21,
  'restaurantId': 11,
  'name': 'Phở bò',
  'description': 'Món test',
  'price': 50000.0,
  'image': null,
  'status': 'AVAILABLE',
};

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late RestaurantApiService service;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    service = RestaurantApiService(dio);
  });

  test('uses canonical catalog, detail and menu Gateway routes', () async {
    adapter.onGet(
      '/restaurants',
      (server) => server.reply(200, _response([_restaurant()])),
    );
    adapter.onGet(
      '/restaurants/11',
      (server) => server.reply(200, _response(_restaurant())),
    );
    adapter.onGet(
      '/menu-items/restaurant/11',
      (server) => server.reply(200, _response([_menuItem()])),
    );

    final restaurants = await service.getRestaurants(
      const GetRestaurantsRequestDto(page: 1, limit: 20),
    );
    final detail = await service.getRestaurantById(11);
    final menu = await service.getMenuItems(11);

    expect(restaurants.data, hasLength(1));
    expect(detail.data?.id, 11);
    expect(menu.data?.single.name, 'Phở bò');
  });

  test('sends the backend-required keyword for restaurant search', () async {
    adapter.onGet(
      '/restaurants/search',
      (server) => server.reply(200, _response([_restaurant()])),
      queryParameters: {'keyword': 'pho'},
    );

    final response = await service.searchRestaurants(
      const SearchRestaurantsRequestDto(keyword: 'pho'),
    );

    expect(response.data?.single.id, 11);
  });
}
