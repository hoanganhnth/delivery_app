import 'package:delivery_app/features/orders/data/datasources/restaurant_rating_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/restaurant_rating_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('submits restaurant rating through canonical /api/restaurants path', () async {
    final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    final adapter = DioAdapter(dio: dio);
    final service = RestaurantRatingApiService(dio);
    const request = RestaurantRatingRequestDto(
      orderId: 101,
      rating: 5,
      comment: 'Rất tốt',
    );

    adapter.onPost(
      '/restaurants/11/ratings',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {'id': 1},
      }),
      data: request,
    );

    final response = await service.submitRating(11, request);

    expect(response.status, 1);
  });
}
