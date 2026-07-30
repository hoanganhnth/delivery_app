import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/orders/data/datasources/restaurant_rating_api_service.dart';
import 'package:delivery_app/features/orders/data/dtos/restaurant_rating_request_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class RestaurantRatingSubmissionPort {
  Future<void> submit({
    required int restaurantId,
    required RestaurantRatingRequestDto request,
  });
}

class ApiRestaurantRatingSubmissionAdapter
    implements RestaurantRatingSubmissionPort {
  ApiRestaurantRatingSubmissionAdapter(this._apiService);

  final RestaurantRatingApiService _apiService;

  @override
  Future<void> submit({
    required int restaurantId,
    required RestaurantRatingRequestDto request,
  }) async {
    final response = await _apiService.submitRating(restaurantId, request);
    if (response.status != 1) {
      throw StateError(response.message);
    }
  }
}

final restaurantRatingSubmissionProvider =
    Provider<RestaurantRatingSubmissionPort>((ref) {
      final dio = ref.watch(authenticatedDioProvider);
      return ApiRestaurantRatingSubmissionAdapter(
        RestaurantRatingApiService(dio),
      );
    });
