import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/core/data/dtos/response_handler.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/logger/app_logger.dart';
import '../dtos/restaurant_dto.dart';
import '../dtos/menu_item_dto.dart';
import '../dtos/get_restaurants_request_dto.dart';
import '../dtos/search_restaurants_request_dto.dart';
import '../dtos/nearby_restaurants_request_dto.dart';
import 'restaurant_remote_datasource.dart';

part 'restaurant_remote_datasource_impl.g.dart';

@RestApi()
abstract class RestaurantApiService {
  factory RestaurantApiService(Dio dio, {String baseUrl}) = _RestaurantApiService;

  @GET('/restaurants')
  Future<BaseResponseDto<List<RestaurantDto>>> getRestaurants(
    @Queries() GetRestaurantsRequestDto request,
  );

  @GET('/restaurants/{id}')
  Future<BaseResponseDto<RestaurantDto>> getRestaurantById(@Path('id') num id);

  @GET(ApiConstants.getMenuItemsByRestaurant)
  Future<BaseResponseDto<List<MenuItemDto>>> getMenuItems(@Path('restaurantId') num restaurantId);

  @GET(ApiConstants.getRestaurantNearBy)
  Future<BaseResponseDto<List<RestaurantDto>>> getNearbyRestaurants(
    @Queries() NearbyRestaurantsRequestDto request,
  );

  @GET('/restaurants/search')
  Future<BaseResponseDto<List<RestaurantDto>>> searchRestaurants(
    @Queries() SearchRestaurantsRequestDto request,
  );

  @GET('/restaurants/categories')
  Future<BaseResponseDto<List<String>>> getRestaurantCategories();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final RestaurantApiService _apiService;

  RestaurantRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<List<RestaurantDto>>> getRestaurants(
    GetRestaurantsRequestDto request,
  ) async {
    try {
      AppLogger.d('Getting restaurants with params: $request');
      final response = await _apiService.getRestaurants(request);
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} restaurants');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get restaurants', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting restaurants', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
  

  @override
  Future<BaseResponseDto<RestaurantDto>> getRestaurantById(
    num id,
  ) async {
    try {
      AppLogger.d('Getting restaurant with id: $id');
      final response = await _apiService.getRestaurantById(id);
      AppLogger.i('Successfully retrieved restaurant: ${response.data?.name}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get restaurant with id: $id', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting restaurant', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<MenuItemDto>>> getMenuItems(
    num restaurantId,
  ) async {
    try {
      AppLogger.d('Getting menu items for restaurant: $restaurantId');
      final response = await _apiService.getMenuItems(restaurantId);
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} menu items');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get menu items for restaurant: $restaurantId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting menu items', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<RestaurantDto>>> getNearbyRestaurants(
    NearbyRestaurantsRequestDto request,
  ) async {
    try {
      AppLogger.d('Getting nearby restaurants with params: $request');
      final response = await _apiService.getNearbyRestaurants(request);
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} nearby restaurants');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get nearby restaurants', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting nearby restaurants', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<RestaurantDto>>> searchRestaurants(
    SearchRestaurantsRequestDto request,
  ) async {
    try {
      AppLogger.d('Searching restaurants with query: ${request.query}');
      final response = await _apiService.searchRestaurants(request);
      AppLogger.i('Search returned ${response.data?.length ?? 0} restaurants');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to search restaurants', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error searching restaurants', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<String>>> getRestaurantCategories() async {
    try {
      AppLogger.d('Getting restaurant categories');
      final response = await _apiService.getRestaurantCategories();
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} categories');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get restaurant categories', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting categories', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
