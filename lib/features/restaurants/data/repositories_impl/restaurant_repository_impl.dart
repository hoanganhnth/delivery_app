import 'package:delivery_app/core/error/error_mapper.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/restaurant_remote_datasource.dart';
import '../dtos/restaurant_dto.dart';
import '../dtos/menu_item_dto.dart';
import '../dtos/get_restaurants_request_dto.dart';
import '../dtos/search_restaurants_request_dto.dart';
import '../dtos/nearby_restaurants_request_dto.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantRemoteDataSource _remoteDataSource;

  const RestaurantRepositoryImpl({
    required RestaurantRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    String? searchQuery,
    int? page,
    int? limit,
  }) async {
    try {
      final request = GetRestaurantsRequestDto(
        latitude: latitude,
        longitude: longitude,
        category: category,
        searchQuery: searchQuery,
        page: page,
        limit: limit,
      );

      final response = await _remoteDataSource.getRestaurants(request);

      if (response.isSuccess && response.data != null) {
        final entities = (response.data)!
            .map((data) => data.toEntity())
            .toList();
        return right(entities);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(num id) async {
    try {
      final response = await _remoteDataSource.getRestaurantById(id);

      if (response.isSuccess && response.data != null) {
        return right(response.data!.toEntity());
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuItemEntity>>> getMenuItems(
    num restaurantId,
  ) async {
    try {
      final response = await _remoteDataSource.getMenuItems(restaurantId);

      if (response.isSuccess && response.data != null) {
        final entities = (response.data)!
            .map((data) => data.toEntity())
            .toList();
        return right(entities);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getNearbyRestaurants({
    required double latitude,
    required double longitude,
    double? radius,
  }) async {
    try {
      final request = NearbyRestaurantsRequestDto(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );

      final response = await _remoteDataSource.getNearbyRestaurants(request);

      if (response.isSuccess && response.data != null) {
        final entities = (response.data)!
            .map((data) => data.toEntity())
            .toList();
        return right(entities);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurants({
    required String query,
    double? latitude,
    double? longitude,
    String? category,
    int? page,
    int? limit,
  }) async {
    try {
      final request = SearchRestaurantsRequestDto(
        query: query,
        latitude: latitude,
        longitude: longitude,
        category: category,
        page: page,
        limit: limit,
      );

      final response = await _remoteDataSource.searchRestaurants(request);

      if (response.isSuccess && response.data != null) {
        final entities = (response.data)!
            .map((data) => data.toEntity())
            .toList();
        return right(entities);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRestaurantCategories() async {
    try {
      final response = await _remoteDataSource.getRestaurantCategories();

      if (response.isSuccess && response.data != null) {
        final categories = (response.data)!
            .map((category) => category.toString())
            .toList();
        return right(categories);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
