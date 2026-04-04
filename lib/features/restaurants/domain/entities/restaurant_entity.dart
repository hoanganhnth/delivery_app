import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_entity.freezed.dart';

@freezed
abstract class RestaurantEntity with _$RestaurantEntity {
  const factory RestaurantEntity({
    required num id,
    required String name,
    String? description,
    required String address,
    String? phone,
    String? image,
    double? rating,
    int? reviewCount,
    double? deliveryFee,
    int? deliveryTime, // in minutes
    bool? isOpen,
    String? closingHour,
    String? openingHour,
    String? category,
    double? addressLat,
    double? addressLng,
    double? distance, // in kilometers
  }) = _RestaurantEntity;
}
