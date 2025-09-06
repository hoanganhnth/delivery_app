import '../../../../core/error/failures.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../../domain/entities/menu_item_entity.dart';

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

class RestaurantDetailState {
  final bool isLoading;
  final RestaurantEntity? restaurant;
  final List<MenuItemEntity> menuItems;
  final Failure? failure;
  final bool isMenuLoading;

  const RestaurantDetailState({
    this.isLoading = false,
    this.restaurant,
    this.menuItems = const [],
    this.failure,
    this.isMenuLoading = false,
  });

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get hasRestaurant => restaurant != null;
  bool get hasMenuItems => menuItems.isNotEmpty;

  RestaurantDetailState copyWith({
    bool? isLoading,
    RestaurantEntity? restaurant,
    List<MenuItemEntity>? menuItems,
    Failure? failure,
    bool? isMenuLoading,
    bool clearFailure = false,
    bool clearRestaurant = false,
    bool clearMenuItems = false,
  }) {
    return RestaurantDetailState(
      isLoading: isLoading ?? this.isLoading,
      restaurant: clearRestaurant ? null : (restaurant ?? this.restaurant),
      menuItems: clearMenuItems ? const [] : (menuItems ?? this.menuItems),
      failure: clearFailure ? null : (failure ?? this.failure),
      isMenuLoading: isMenuLoading ?? this.isMenuLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RestaurantDetailState &&
        other.isLoading == isLoading &&
        other.restaurant == restaurant &&
        other.menuItems == menuItems &&
        other.failure == failure &&
        other.isMenuLoading == isMenuLoading;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        restaurant.hashCode ^
        menuItems.hashCode ^
        failure.hashCode ^
        isMenuLoading.hashCode;
  }

  @override
  String toString() {
    return 'RestaurantDetailState(isLoading: $isLoading, hasRestaurant: $hasRestaurant, menuItemsCount: ${menuItems.length}, hasError: $hasError, isMenuLoading: $isMenuLoading)';
  }
}
