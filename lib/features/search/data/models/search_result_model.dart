import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_model.freezed.dart';
part 'search_result_model.g.dart';

@freezed
sealed class RestaurantSearchResult with _$RestaurantSearchResult {
  const factory RestaurantSearchResult({
    required String id,
    required String name,
    String? description,
    String? cuisine,
    double? rating,
    String? imageUrl,
  }) = _RestaurantSearchResult;

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) =>
      _$RestaurantSearchResultFromJson(json);
}

@freezed
sealed class DishSearchResult with _$DishSearchResult {
  const factory DishSearchResult({
    required String id,
    required String name,
    String? description,
    double? price,
    String? restaurantId,
    String? imageUrl,
  }) = _DishSearchResult;

  factory DishSearchResult.fromJson(Map<String, dynamic> json) =>
      _$DishSearchResultFromJson(json);
}

@freezed
sealed class ShipperSearchResult with _$ShipperSearchResult {
  const factory ShipperSearchResult({
    required String id,
    required String name,
    String? vehicleType,
    String? licensePlate,
    double? rating,
    bool? isOnline,
  }) = _ShipperSearchResult;

  factory ShipperSearchResult.fromJson(Map<String, dynamic> json) =>
      _$ShipperSearchResultFromJson(json);
}
