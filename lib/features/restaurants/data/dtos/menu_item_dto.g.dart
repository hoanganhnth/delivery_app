// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuItemDto _$MenuItemDtoFromJson(Map<String, dynamic> json) => _MenuItemDto(
      id: json['id'] as num?,
      restaurantId: json['restaurantId'] as num?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String?,
      status: $enumDecode(_$MenuItemStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$MenuItemDtoToJson(_MenuItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'status': _$MenuItemStatusEnumMap[instance.status]!,
    };

const _$MenuItemStatusEnumMap = {
  MenuItemStatus.available: 'available',
  MenuItemStatus.unavailable: 'unavailable',
  MenuItemStatus.soldOut: 'soldOut',
};
