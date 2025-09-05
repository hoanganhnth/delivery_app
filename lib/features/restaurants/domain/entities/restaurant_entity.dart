import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_entity.freezed.dart';

@freezed
abstract class RestaurantEntity with _$RestaurantEntity {
  const factory RestaurantEntity({
    required String id,
    required String name,
     String? description,
    required String address,
     String? phone,
     String? image,
    // required double rating,
    // required int reviewCount,
    // required double deliveryFee,
    // required int deliveryTime, // in minutes
    // required bool isOpen,
    DateTime? closingHour,
    DateTime? openingHour,
    // required List<String> categories,
    double? addressLat,
    double? addressLng,
    // DateTime? openTime,
    // DateTime? closeTime,
  }) = _RestaurantEntity;
}
