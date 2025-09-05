import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_entity.freezed.dart';

@freezed
abstract class RestaurantEntity with _$RestaurantEntity {
  const factory RestaurantEntity({
    required String id,
    required String name,
    required String description,
    required String address,
    required String phone,
    required String imageUrl,
    required double rating,
    required int reviewCount,
    required double deliveryFee,
    required int deliveryTime, // in minutes
    required bool isOpen,
    required List<String> categories,
    required double latitude,
    required double longitude,
    DateTime? openTime,
    DateTime? closeTime,
  }) = _RestaurantEntity;
}
