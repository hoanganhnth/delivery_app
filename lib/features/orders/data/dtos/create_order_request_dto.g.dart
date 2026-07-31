// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItemRequest _$OrderItemRequestFromJson(Map<String, dynamic> json) =>
    _OrderItemRequest(
      menuItemId: (json['menuItemId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      notes: json['notes'] as String?,
      flashSaleItemId: (json['flashSaleItemId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderItemRequestToJson(_OrderItemRequest instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'quantity': instance.quantity,
      'notes': instance.notes,
      'flashSaleItemId': instance.flashSaleItemId,
    };

_CreateOrderRequestDto _$CreateOrderRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreateOrderRequestDto(
  restaurantId: (json['restaurantId'] as num).toInt(),
  deliveryAddress: json['deliveryAddress'] as String,
  deliveryLat: (json['deliveryLat'] as num).toDouble(),
  deliveryLng: (json['deliveryLng'] as num).toDouble(),
  customerName: json['customerName'] as String,
  customerPhone: json['customerPhone'] as String,
  paymentMethod: json['paymentMethod'] as String,
  notes: json['notes'] as String?,
  voucherIds: (json['voucherIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreateOrderRequestDtoToJson(
  _CreateOrderRequestDto instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'deliveryAddress': instance.deliveryAddress,
  'deliveryLat': instance.deliveryLat,
  'deliveryLng': instance.deliveryLng,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'paymentMethod': instance.paymentMethod,
  'notes': instance.notes,
  'voucherIds': instance.voucherIds,
  'items': instance.items,
};
