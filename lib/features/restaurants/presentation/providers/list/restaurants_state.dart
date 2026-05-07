import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/restaurant_entity.dart';

part 'restaurants_state.freezed.dart';

@freezed
sealed class RestaurantsState with _$RestaurantsState {
  const RestaurantsState._();

  const factory RestaurantsState({
    @Default(false) bool isLoading,
    @Default([]) List<RestaurantEntity> restaurants,
    Failure? failure,
    @Default(false) bool isSearchLoading,
    @Default(false) bool isNearbyLoading,
    @Default(false) bool isFeaturedLoading,
  }) = _RestaurantsState;

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  List<RestaurantEntity> get featuredRestaurants => restaurants.take(3).toList();
}
