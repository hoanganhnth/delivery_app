// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantDto _$RestaurantDtoFromJson(Map<String, dynamic> json) =>
    _RestaurantDto(
      id: json['id'] as num,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      closingHour: json['closingHour'] as String?,
      openingHour: json['openingHour'] as String?,
      addressLat: (json['addressLat'] as num?)?.toDouble(),
      addressLng: (json['addressLng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RestaurantDtoToJson(_RestaurantDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'phone': instance.phone,
      'image': instance.image,
      'closingHour': instance.closingHour,
      'openingHour': instance.openingHour,
      'addressLat': instance.addressLat,
      'addressLng': instance.addressLng,
    };
