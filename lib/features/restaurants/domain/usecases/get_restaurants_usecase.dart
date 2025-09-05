import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant_entity.dart';
import '../repositories/restaurant_repository.dart';

class GetRestaurantsUseCase extends UseCase<List<RestaurantEntity>, GetRestaurantsParams> {
  final RestaurantRepository repository;

  GetRestaurantsUseCase(this.repository);

  @override
  Future<Either<Failure, List<RestaurantEntity>>> call(GetRestaurantsParams params) async {
    return await repository.getRestaurants(
      latitude: params.latitude,
      longitude: params.longitude,
      category: params.category,
      searchQuery: params.searchQuery,
      page: params.page,
      limit: params.limit,
    );
  }
}

class GetRestaurantsParams {
  final double? latitude;
  final double? longitude;
  final String? category;
  final String? searchQuery;
  final int page;
  final int limit;

  GetRestaurantsParams({
    this.latitude,
    this.longitude,
    this.category,
    this.searchQuery,
    this.page = 1,
    this.limit = 20,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetRestaurantsParams &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.category == category &&
        other.searchQuery == searchQuery &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        category.hashCode ^
        searchQuery.hashCode ^
        page.hashCode ^
        limit.hashCode;
  }

  @override
  String toString() {
    return 'GetRestaurantsParams(latitude: $latitude, longitude: $longitude, category: $category, searchQuery: $searchQuery, page: $page, limit: $limit)';
  }
}
