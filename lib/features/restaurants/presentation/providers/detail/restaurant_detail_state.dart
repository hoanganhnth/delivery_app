import '../../../../../core/error/failures.dart';
import '../../../domain/entities/restaurant_entity.dart';
import '../../../domain/entities/menu_item_entity.dart';

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
