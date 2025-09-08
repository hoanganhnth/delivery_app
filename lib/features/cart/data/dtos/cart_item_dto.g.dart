// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) => _CartItemDto(
  menuItemId: json['menuItemId'] as num,
  menuItemName: json['menuItemName'] as String,
  price: (json['price'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  restaurantId: json['restaurantId'] as num,
  restaurantName: json['restaurantName'] as String,
  imageUrl: json['imageUrl'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$CartItemDtoToJson(_CartItemDto instance) =>
    <String, dynamic>{
      'menuItemId': instance.menuItemId,
      'menuItemName': instance.menuItemName,
      'price': instance.price,
      'quantity': instance.quantity,
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
      'imageUrl': instance.imageUrl,
      'notes': instance.notes,
    };
