import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant_entity.dart';
import '../repositories/restaurant_repository.dart';

class SearchRestaurantsUseCase extends UseCase<List<RestaurantEntity>, SearchRestaurantsParams> {
  final RestaurantRepository repository;

  SearchRestaurantsUseCase(this.repository);

  @override
  Future<Either<Failure, List<RestaurantEntity>>> call(SearchRestaurantsParams params) async {
    if (params.query.trim().isEmpty) {
      return left(const ValidationFailure('Search query cannot be empty'));
    }
    
    return await repository.searchRestaurants(
      query: params.query,
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class SearchRestaurantsParams {
  final String query;
  final double? latitude;
  final double? longitude;

  SearchRestaurantsParams({
    required this.query,
    this.latitude,
    this.longitude,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchRestaurantsParams &&
        other.query == query &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => query.hashCode ^ latitude.hashCode ^ longitude.hashCode;

  @override
  String toString() => 'SearchRestaurantsParams(query: $query, latitude: $latitude, longitude: $longitude)';
}
