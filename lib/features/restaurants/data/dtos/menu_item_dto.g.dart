// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuItemDto _$MenuItemDtoFromJson(Map<String, dynamic> json) => _MenuItemDto(
  id: json['id'] as String,
  restaurantId: json['restaurantId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
  category: json['category'] as String,
  isAvailable: json['isAvailable'] as bool,
  allergens: (json['allergens'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  preparationTime: (json['preparationTime'] as num).toInt(),
  discount: (json['discount'] as num?)?.toDouble(),
  calories: (json['calories'] as num?)?.toInt(),
  nutrition: json['nutrition'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$MenuItemDtoToJson(_MenuItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'isAvailable': instance.isAvailable,
      'allergens': instance.allergens,
      'preparationTime': instance.preparationTime,
      'discount': instance.discount,
      'calories': instance.calories,
      'nutrition': instance.nutrition,
    };
