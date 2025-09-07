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

      final result = await _remoteDataSource.getRestaurants(request);

      return result.fold(
        (exception) => left(ServerFailure(exception.toString())),
        (response) {
          if (response.isSuccess && response.data != null) {
            final entities = (response.data)!
                .map((data) => data.toEntity())
                .toList();
            return right(entities);
          } else {
            return left(ServerFailure(response.message));
          }
        },
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(num id) async {
    try {
      final result = await _remoteDataSource.getRestaurantById(id);

      return result.fold(
        (exception) => left(ServerFailure(exception.toString())),
        (response) {
          if (response.isSuccess && response.data != null) {
            return right(response.data!.toEntity());
          } else {
            return left(ServerFailure(response.message));
          }
        },
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuItemEntity>>> getMenuItems(
    num restaurantId,
  ) async {
    try {
      final result = await _remoteDataSource.getMenuItems(restaurantId);

      return result.fold(
        (exception) => left(ServerFailure(exception.toString())),
        (response) {
          if (response.isSuccess && response.data != null) {
            final entities = (response.data)!
                .map((data) => data.toEntity())
                .toList();
            return right(entities);
          } else {
            return left(ServerFailure(response.message));
          }
        },
      );
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

      final result = await _remoteDataSource.getNearbyRestaurants(request);

      return result.fold(
        (exception) => left(ServerFailure(exception.toString())),
        (response) {
          if (response.isSuccess && response.data != null) {
            final entities = (response.data as List)
                .map(
                  (data) => RestaurantDto.fromJson(
                    data as Map<String, dynamic>,
                  ).toEntity(),
                )
                .toList();
            return right(entities);
          } else {
            return left(ServerFailure(response.message));
          }
        },
      );
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

      final result = await _remoteDataSource.searchRestaurants(request);

      return result.fold(
        (exception) => left(ServerFailure(exception.toString())),
        (response) {
          if (response.isSuccess && response.data != null) {
            final entities = (response.data as List)
                .map(
                  (data) => RestaurantDto.fromJson(
                    data as Map<String, dynamic>,
                  ).toEntity(),
                )
                .toList();
            return right(entities);
          } else {
            return left(ServerFailure(response.message));
          }
        },
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRestaurantCategories() async {
    try {
      final result = await _remoteDataSource.getRestaurantCategories();

      return result.fold(
        (exception) => left(ServerFailure(exception.toString())),
        (response) {
          if (response.isSuccess && response.data != null) {
            final categories = (response.data as List)
                .map((category) => category.toString())
                .toList();
            return right(categories);
          } else {
            return left(ServerFailure(response.message));
          }
        },
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
