// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShipperDto _$ShipperDtoFromJson(Map<String, dynamic> json) => _ShipperDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  phone: json['phone'] as String,
  vehicleType: json['vehicleType'] as String,
  licenseNumber: json['licenseNumber'] as String,
  avatar: json['avatar'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  totalTrips: (json['totalTrips'] as num?)?.toInt(),
  isOnline: json['isOnline'] as bool?,
  lastSeenAt: json['lastSeenAt'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$ShipperDtoToJson(_ShipperDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'vehicleType': instance.vehicleType,
      'licenseNumber': instance.licenseNumber,
      'avatar': instance.avatar,
      'rating': instance.rating,
      'totalTrips': instance.totalTrips,
      'isOnline': instance.isOnline,
      'lastSeenAt': instance.lastSeenAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
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
