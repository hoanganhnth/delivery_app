import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/restaurant_entity.dart';

part 'restaurant_dto.freezed.dart';
part 'restaurant_dto.g.dart';

@freezed
sealed class RestaurantDto with _$RestaurantDto {
  const factory RestaurantDto({
    required num id,
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
    String? closingHour,
    String? openingHour,
    // required List<String> categories,
    double? addressLat,
    double? addressLng,
    // DateTime? openTime,
    // DateTime? closeTime,
  }) = _RestaurantDto;

  factory RestaurantDto.fromJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    if (json.containsKey('latitude')) normalized['addressLat'] = json['latitude'];
    if (json.containsKey('longitude')) normalized['addressLng'] = json['longitude'];
    return _$RestaurantDtoFromJson(normalized);
  }
}

extension RestaurantDtoX on RestaurantDto {
  RestaurantEntity toEntity() {
    return RestaurantEntity(
      id: id,
      name: name,
      description: description,
      address: address,
      phone: phone,
      addressLat: addressLat,
      addressLng: addressLng,
      image: image,
      closingHour: closingHour,
      openingHour: openingHour,
    );
  }
}
