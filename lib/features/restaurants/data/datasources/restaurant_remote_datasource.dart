import 'package:fpdart/fpdart.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../dtos/restaurant_dto.dart';
import '../dtos/menu_item_dto.dart';
import '../dtos/get_restaurants_request_dto.dart';
import '../dtos/search_restaurants_request_dto.dart';
import '../dtos/nearby_restaurants_request_dto.dart';

abstract class RestaurantRemoteDataSource {
  Future<Either<Exception, BaseResponseDto<List<RestaurantDto>>>> getRestaurants(
    GetRestaurantsRequestDto request,
  );

  Future<Either<Exception, BaseResponseDto<RestaurantDto>>> getRestaurantById(
    String id,
  );

  Future<Either<Exception, BaseResponseDto<List<MenuItemDto>>>> getMenuItems(
    String restaurantId,
  );

  Future<Either<Exception, BaseResponseDto<List<RestaurantDto>>>> getNearbyRestaurants(
    NearbyRestaurantsRequestDto request,
  );

  Future<Either<Exception, BaseResponseDto<List<RestaurantDto>>>> searchRestaurants(
    SearchRestaurantsRequestDto request,
  );

  Future<Either<Exception, BaseResponseDto<List<String>>>> getRestaurantCategories();
}
