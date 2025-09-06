// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_restaurants_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NearbyRestaurantsRequestDto _$NearbyRestaurantsRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _NearbyRestaurantsRequestDto(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NearbyRestaurantsRequestDtoToJson(
        _NearbyRestaurantsRequestDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
    };
