// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuItemEntity _$MenuItemEntityFromJson(Map<String, dynamic> json) =>
    _MenuItemEntity(
      id: json['id'] as num?,
      restaurantId: json['restaurantId'] as num?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String?,
      status: const MenuItemStatusConverter().fromJson(
        json['status'] as String,
      ),
    );

Map<String, dynamic> _$MenuItemEntityToJson(_MenuItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'status': const MenuItemStatusConverter().toJson(instance.status),
    };
