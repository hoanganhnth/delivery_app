import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/error/exceptions.dart';
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

  @GET('/api/restaurants')
  Future<BaseResponseDto<List<RestaurantDto>>> getRestaurants(
    @Queries() GetRestaurantsRequestDto request,
  );

  @GET('/api/restaurants/{id}')
  Future<BaseResponseDto<RestaurantDto>> getRestaurantById(@Path('id') String id);

  @GET(ApiConstants.getMenuItemsByRestaurant)
  Future<BaseResponseDto<List<MenuItemDto>>> getMenuItems(@Path('restaurantId') String restaurantId);

  @GET(ApiConstants.getRestaurantNearBy)
  Future<BaseResponseDto<List<RestaurantDto>>> getNearbyRestaurants(
    @Queries() NearbyRestaurantsRequestDto request,
  );

  @GET('/api/restaurants/search')
  Future<BaseResponseDto<List<RestaurantDto>>> searchRestaurants(
    @Queries() SearchRestaurantsRequestDto request,
  );

  @GET('/api/restaurants/categories')
  Future<BaseResponseDto<List<String>>> getRestaurantCategories();
}

class RestaurantRemoteDataSourceImpl implements RestaurantRemoteDataSource {
  final RestaurantApiService _apiService;

  RestaurantRemoteDataSourceImpl(this._apiService);

  @override
  Future<Either<Exception, BaseResponseDto<List<RestaurantDto>>>> getRestaurants(
    GetRestaurantsRequestDto request,
  ) async {
    try {
      AppLogger.d('Getting restaurants with params: $request');
      
      final response = await _apiService.getRestaurants(request);
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} restaurants');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('Failed to get restaurants', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error getting restaurants', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<RestaurantDto>>> getRestaurantById(
    String id,
  ) async {
    try {
      AppLogger.d('Getting restaurant with id: $id');
      final response = await _apiService.getRestaurantById(id);
      AppLogger.i('Successfully retrieved restaurant: ${response.data?.name}');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('Failed to get restaurant with id: $id', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error getting restaurant', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<List<MenuItemDto>>>> getMenuItems(
    String restaurantId,
  ) async {
    try {
      AppLogger.d('Getting menu items for restaurant: $restaurantId');
      final response = await _apiService.getMenuItems(restaurantId);
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} menu items');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('Failed to get menu items for restaurant: $restaurantId', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error getting menu items', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<List<RestaurantDto>>>> getNearbyRestaurants(
    NearbyRestaurantsRequestDto request,
  ) async {
    try {
      AppLogger.d('Getting nearby restaurants with params: $request');
      
      final response = await _apiService.getNearbyRestaurants(request);
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} nearby restaurants');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('Failed to get nearby restaurants', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error getting nearby restaurants', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<List<RestaurantDto>>>> searchRestaurants(
    SearchRestaurantsRequestDto request,
  ) async {
    try {
      AppLogger.d('Searching restaurants with query: ${request.query}');
      
      final response = await _apiService.searchRestaurants(request);
      AppLogger.i('Search returned ${response.data?.length ?? 0} restaurants');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('Failed to search restaurants', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error searching restaurants', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<List<String>>>> getRestaurantCategories() async {
    try {
      AppLogger.d('Getting restaurant categories');
      final response = await _apiService.getRestaurantCategories();
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} categories');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('Failed to get restaurant categories', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error getting categories', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return ServerException('Bad request: ${e.response?.data?['message'] ?? 'Invalid request'}');
      case 401:
        return UnauthorizedException('Unauthorized: ${e.response?.data?['message'] ?? 'Invalid credentials'}');
      case 403:
        return UnauthorizedException('Forbidden: ${e.response?.data?['message'] ?? 'Access denied'}');
      case 404:
        return ServerException('Not found: ${e.response?.data?['message'] ?? 'Resource not found'}');
      case 422:
        return ServerException('Validation error: ${e.response?.data?['message'] ?? 'Invalid data'}');
      case 500:
        return ServerException('Internal server error: ${e.response?.data?['message'] ?? 'Server error'}');
      default:
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          return ServerException('Connection timeout: Please check your internet connection');
        }
        if (e.type == DioExceptionType.connectionError) {
          return ServerException('Connection error: Unable to connect to server');
        }
        return ServerException('Network error: ${e.message ?? 'Unknown error'}');
    }
  }
}
