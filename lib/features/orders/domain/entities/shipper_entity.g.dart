// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShipperEntity _$ShipperEntityFromJson(Map<String, dynamic> json) =>
    _ShipperEntity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      vehicleType: json['vehicleType'] as String,
      vehicleNumber: json['vehicleNumber'] as String,
      avatar: json['avatar'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      totalTrips: (json['totalTrips'] as num?)?.toInt(),
      isOnline: json['isOnline'] as bool?,
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ShipperEntityToJson(_ShipperEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'vehicleType': instance.vehicleType,
      'vehicleNumber': instance.vehicleNumber,
      'avatar': instance.avatar,
      'rating': instance.rating,
      'totalTrips': instance.totalTrips,
      'isOnline': instance.isOnline,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
