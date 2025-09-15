// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShipperDto _$ShipperDtoFromJson(Map<String, dynamic> json) => _ShipperDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  phone: json['phone'] as String,
  vehicleType: json['vehicle_type'] as String,
  vehicleNumber: json['vehicle_number'] as String,
  avatar: json['avatar'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  totalTrips: (json['total_trips'] as num?)?.toInt(),
  isOnline: json['is_online'] as bool?,
  lastSeenAt: json['last_seen_at'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$ShipperDtoToJson(_ShipperDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'vehicle_type': instance.vehicleType,
      'vehicle_number': instance.vehicleNumber,
      'avatar': instance.avatar,
      'rating': instance.rating,
      'total_trips': instance.totalTrips,
      'is_online': instance.isOnline,
      'last_seen_at': instance.lastSeenAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_GetShippersInAreaRequestDto _$GetShippersInAreaRequestDtoFromJson(
  Map<String, dynamic> json,
) => _GetShippersInAreaRequestDto(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  radius: (json['radius'] as num?)?.toDouble() ?? 10.0,
);

Map<String, dynamic> _$GetShippersInAreaRequestDtoToJson(
  _GetShippersInAreaRequestDto instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'radius': instance.radius,
};
