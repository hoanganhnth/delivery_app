import '../../../../core/data/dtos/base_response_dto.dart';
import '../dtos/restaurant_dto.dart';
import '../dtos/menu_item_dto.dart';
import '../dtos/get_restaurants_request_dto.dart';
import '../dtos/search_restaurants_request_dto.dart';
import '../dtos/nearby_restaurants_request_dto.dart';

abstract class RestaurantRemoteDataSource {
  Future<BaseResponseDto<List<RestaurantDto>>> getRestaurants(
    GetRestaurantsRequestDto request,
  );

  Future<BaseResponseDto<RestaurantDto>> getRestaurantById(
    num id,
  );

  Future<BaseResponseDto<List<MenuItemDto>>> getMenuItems(
    num restaurantId,
  );

  Future<BaseResponseDto<List<RestaurantDto>>> getNearbyRestaurants(
    NearbyRestaurantsRequestDto request,
  );

  Future<BaseResponseDto<List<RestaurantDto>>> searchRestaurants(
    SearchRestaurantsRequestDto request,
  );

  Future<BaseResponseDto<List<String>>> getRestaurantCategories();
}
