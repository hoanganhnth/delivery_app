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
  totalAmount: (json['totalPrice'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  estimatedDeliveryTime: json['estimatedDeliveryTime'] == null
      ? null
      : DateTime.parse(json['estimatedDeliveryTime'] as String),
  cancelReason: json['cancelReason'] as String?,
  restaurantId: (json['restaurantId'] as num?)?.toInt(),
  restaurantName: json['restaurantName'] as String?,
  restaurantAddress: json['restaurantAddress'] as String?,
  restaurantPhone: json['restaurantPhone'] as String?,
  restaurantLat: (json['restaurantLat'] as num?)?.toDouble(),
  restaurantLng: (json['restaurantLng'] as num?)?.toDouble(),
  pickupLat: (json['pickupLat'] as num?)?.toDouble(),
  pickupLng: (json['pickupLng'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OrderDtoToJson(_OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'deliveryAddress': instance.deliveryAddress,
  'paymentMethod': instance.paymentMethod,
  'totalPrice': instance.totalAmount,
  'notes': instance.notes,
  'items': instance.items,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'estimatedDeliveryTime': instance.estimatedDeliveryTime?.toIso8601String(),
  'cancelReason': instance.cancelReason,
  'restaurantId': instance.restaurantId,
  'restaurantName': instance.restaurantName,
  'restaurantAddress': instance.restaurantAddress,
  'restaurantPhone': instance.restaurantPhone,
  'restaurantLat': instance.restaurantLat,
  'restaurantLng': instance.restaurantLng,
  'pickupLat': instance.pickupLat,
  'pickupLng': instance.pickupLng,
};
