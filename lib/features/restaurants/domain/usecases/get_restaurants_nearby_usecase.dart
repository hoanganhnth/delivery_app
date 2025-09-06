import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/restaurant_entity.dart';
import '../repositories/restaurant_repository.dart';

class GetRestaurantsNearByUseCase extends UseCase<List<RestaurantEntity>, GetRestaurantsNearByParams> {
  final RestaurantRepository repository;

  GetRestaurantsNearByUseCase(this.repository);

  @override
  Future<Either<Failure, List<RestaurantEntity>>> call(GetRestaurantsNearByParams params) async {
    return await repository.getNearbyRestaurants(
      latitude: params.latitude,
      longitude: params.longitude,
      radius: params.radius ?? 5.0, // Default 5km if not specified
    );
  }
}

class GetRestaurantsNearByParams {
  final double latitude;
  final double longitude;
  final double? radius;

  const GetRestaurantsNearByParams({
    required this.latitude,
    required this.longitude,
    this.radius,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetRestaurantsNearByParams &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.radius == radius;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^ longitude.hashCode ^ radius.hashCode;
  }

  @override
  String toString() {
    return 'GetRestaurantsNearByParams(latitude: $latitude, longitude: $longitude, radius: $radius)';
  }

  GetRestaurantsNearByParams copyWith({
    double? latitude,
    double? longitude,
    double? radius,
  }) {
    return GetRestaurantsNearByParams(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
    );
  }
}
