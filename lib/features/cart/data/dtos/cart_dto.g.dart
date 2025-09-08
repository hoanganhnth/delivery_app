// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartDto _$CartDtoFromJson(Map<String, dynamic> json) => _CartDto(
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  currentRestaurantId: json['currentRestaurantId'] as num?,
  currentRestaurantName: json['currentRestaurantName'] as String?,
);

Map<String, dynamic> _$CartDtoToJson(_CartDto instance) => <String, dynamic>{
  'items': instance.items,
  'currentRestaurantId': instance.currentRestaurantId,
  'currentRestaurantName': instance.currentRestaurantName,
};
