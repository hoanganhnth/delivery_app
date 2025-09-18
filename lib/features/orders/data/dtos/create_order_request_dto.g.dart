// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItemRequest _$OrderItemRequestFromJson(Map<String, dynamic> json) =>
    _OrderItemRequest(
      menuItemId: (json['menuItemId'] as num).toInt(),
      menuItemName: json['menuItemName'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemRequestToJson(_OrderItemRequest instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'menuItemName': instance.menuItemName,
      'price': instance.price,
      'quantity': instance.quantity,
    };

_CreateOrderRequestDto _$CreateOrderRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CreateOrderRequestDto(
  restaurantId: (json['restaurantId'] as num).toInt(),
  restaurantName: json['restaurantName'] as String,
  restaurantAddress: json['restaurantAddress'] as String,
  restaurantPhone: json['restaurantPhone'] as String,
  deliveryAddress: json['deliveryAddress'] as String,
  deliveryLat: (json['deliveryLat'] as num?)?.toDouble(),
  deliveryLng: (json['deliveryLng'] as num?)?.toDouble(),
  customerName: json['customerName'] as String,
  customerPhone: json['customerPhone'] as String,
  paymentMethod: json['paymentMethod'] as String,
  notes: json['notes'] as String?,
  pickupLat: (json['pickupLat'] as num?)?.toDouble(),
  pickupLng: (json['pickupLng'] as num?)?.toDouble(),
  items: (json['items'] as List<dynamic>)
      .map((e) => OrderItemRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreateOrderRequestDtoToJson(
  _CreateOrderRequestDto instance,
) => <String, dynamic>{
  'restaurantId': instance.restaurantId,
  'restaurantName': instance.restaurantName,
  'restaurantAddress': instance.restaurantAddress,
  'restaurantPhone': instance.restaurantPhone,
  'deliveryAddress': instance.deliveryAddress,
  'deliveryLat': instance.deliveryLat,
  'deliveryLng': instance.deliveryLng,
  'customerName': instance.customerName,
  'customerPhone': instance.customerPhone,
  'paymentMethod': instance.paymentMethod,
  'notes': instance.notes,
  'pickupLat': instance.pickupLat,
  'pickupLng': instance.pickupLng,
  'items': instance.items,
};
