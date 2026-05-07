import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/restaurant_entity.dart';
import '../../../domain/entities/menu_item_entity.dart';

part 'restaurant_detail_state.freezed.dart';

@freezed
sealed class RestaurantDetailState with _$RestaurantDetailState {
  const RestaurantDetailState._();

  const factory RestaurantDetailState({
    @Default(false) bool isLoading,
    RestaurantEntity? restaurant,
    @Default([]) List<MenuItemEntity> menuItems,
    Failure? failure,
    @Default(false) bool isMenuLoading,
  }) = _RestaurantDetailState;

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get hasRestaurant => restaurant != null;
  bool get hasMenuItems => menuItems.isNotEmpty;
}
