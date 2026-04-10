import '../../../../../core/error/failures.dart';
import '../../../domain/entities/restaurant_entity.dart';

class RestaurantsState {
  final bool isLoading;
  final List<RestaurantEntity> restaurants;
  final Failure? failure;
  final bool isSearchLoading;
  final bool isNearbyLoading;
  final bool isFeaturedLoading;

  const RestaurantsState({
    this.isLoading = false,
    this.restaurants = const [],
    this.failure,
    this.isSearchLoading = false,
    this.isNearbyLoading = false,
    this.isFeaturedLoading = false,
  });

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  List<RestaurantEntity> get featuredRestaurants => restaurants.take(3).toList();

  RestaurantsState copyWith({
    bool? isLoading,
    List<RestaurantEntity>? restaurants,
    Failure? failure,
    bool? isSearchLoading,
    bool? isNearbyLoading,
    bool? isFeaturedLoading,
    bool clearFailure = false,
    bool clearRestaurants = false,
  }) {
    return RestaurantsState(
      isLoading: isLoading ?? this.isLoading,
      restaurants: clearRestaurants ? const [] : (restaurants ?? this.restaurants),
      failure: clearFailure ? null : (failure ?? this.failure),
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      isNearbyLoading: isNearbyLoading ?? this.isNearbyLoading,
      isFeaturedLoading: isFeaturedLoading ?? this.isFeaturedLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RestaurantsState &&
        other.isLoading == isLoading &&
        other.restaurants == restaurants &&
        other.failure == failure &&
        other.isSearchLoading == isSearchLoading &&
        other.isNearbyLoading == isNearbyLoading &&
        other.isFeaturedLoading == isFeaturedLoading;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        restaurants.hashCode ^
        failure.hashCode ^
        isSearchLoading.hashCode ^
        isNearbyLoading.hashCode ^
        isFeaturedLoading.hashCode;
  }

  @override
  String toString() {
    return 'RestaurantsState(isLoading: $isLoading, restaurantsCount: ${restaurants.length}, hasError: $hasError, isSearchLoading: $isSearchLoading, isNearbyLoading: $isNearbyLoading, isFeaturedLoading: $isFeaturedLoading)';
  }
}

