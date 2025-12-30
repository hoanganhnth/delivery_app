// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => _OrderDto(
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String,
  customerName: json['customerName'] as String,
  customerPhone: json['customerPhone'] as String,
  deliveryAddress: json['deliveryAddress'] as String,
  paymentMethod: json['paymentMethod'] as String,
  totalAmount: (json['totalAmount'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  estimatedDeliveryTime:
      json['estimatedDeliveryTime'] == null
          ? null
          : DateTime.parse(json['estimatedDeliveryTime'] as String),
);

Map<String, dynamic> _$OrderDtoToJson(_OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'deliveryAddress': instance.deliveryAddress,
  'paymentMethod': instance.paymentMethod,
  'totalAmount': instance.totalAmount,
  'notes': instance.notes,
  'items': instance.items,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'estimatedDeliveryTime': instance.estimatedDeliveryTime?.toIso8601String(),
};
