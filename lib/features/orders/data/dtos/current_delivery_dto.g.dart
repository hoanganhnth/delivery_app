// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_delivery_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentDeliveryDto _$CurrentDeliveryDtoFromJson(Map<String, dynamic> json) =>
    _CurrentDeliveryDto(
      orderId: (json['orderId'] as num).toInt(),
      shipperId: (json['shipperId'] as num?)?.toInt(),
      status: json['status'] as String,
      pickupLat: (json['pickupLat'] as num).toDouble(),
      pickupLng: (json['pickupLng'] as num).toDouble(),
      deliveryLat: (json['deliveryLat'] as num).toDouble(),
      deliveryLng: (json['deliveryLng'] as num).toDouble(),
      pickupAddress: json['pickupAddress'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      estimatedTime: json['estimatedTime'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CurrentDeliveryDtoToJson(_CurrentDeliveryDto instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'shipperId': instance.shipperId,
      'status': instance.status,
      'pickupLat': instance.pickupLat,
      'pickupLng': instance.pickupLng,
      'deliveryLat': instance.deliveryLat,
      'deliveryLng': instance.deliveryLng,
      'pickupAddress': instance.pickupAddress,
      'deliveryAddress': instance.deliveryAddress,
      'estimatedTime': instance.estimatedTime,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
