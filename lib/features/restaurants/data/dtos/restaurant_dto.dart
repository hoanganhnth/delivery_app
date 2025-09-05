import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/restaurant_entity.dart';

part 'restaurant_dto.freezed.dart';
part 'restaurant_dto.g.dart';

@freezed
abstract class RestaurantDto with _$RestaurantDto {
  const factory RestaurantDto({
    required String id,
    required String name,
    required String description,
    required String address,
    required String phone,
    required String imageUrl,
    required double rating,
    required int reviewCount,
    required double deliveryFee,
    required int deliveryTime,
    required bool isOpen,
    required List<String> categories,
    required double latitude,
    required double longitude,
    String? openTime,
    String? closeTime,
  }) = _RestaurantDto;

  factory RestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDtoFromJson(json);
}

extension RestaurantDtoX on RestaurantDto {
  RestaurantEntity toEntity() {
    return RestaurantEntity(
      id: id,
      name: name,
      description: description,
      address: address,
      phone: phone,
      imageUrl: imageUrl,
      rating: rating,
      reviewCount: reviewCount,
      deliveryFee: deliveryFee,
      deliveryTime: deliveryTime,
      isOpen: isOpen,
      categories: categories,
      latitude: latitude,
      longitude: longitude,
      openTime: openTime != null ? DateTime.tryParse(openTime!) : null,
      closeTime: closeTime != null ? DateTime.tryParse(closeTime!) : null,
    );
  }
}
