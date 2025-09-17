// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateOrderRequestDto _$CreateOrderRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreateOrderRequestDto(
  customerName: json['customerName'] as String,
  customerPhone: json['customerPhone'] as String,
  deliveryAddress: json['deliveryAddress'] as String,
  paymentMethod: json['paymentMethod'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  notes: json['notes'] as String?,
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreateOrderRequestDtoToJson(
  _CreateOrderRequestDto instance,
) => <String, dynamic>{
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'deliveryAddress': instance.deliveryAddress,
  'paymentMethod': instance.paymentMethod,
  'totalAmount': instance.totalAmount,
  'notes': instance.notes,
  'items': instance.items,
};
