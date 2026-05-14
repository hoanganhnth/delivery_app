// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_sale_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlashSaleItemDto _$FlashSaleItemDtoFromJson(Map<String, dynamic> json) =>
    _FlashSaleItemDto(
      id: (json['id'] as num).toInt(),
      campaign: FlashSaleCampaignDto.fromJson(
        json['campaign'] as Map<String, dynamic>,
      ),
      restaurantId: (json['restaurantId'] as num).toInt(),
      menuItemId: (json['menuItemId'] as num).toInt(),
      menuItemName: json['menuItemName'] as String,
      originalPrice: (json['originalPrice'] as num).toDouble(),
      flashSalePrice: (json['flashSalePrice'] as num).toDouble(),
      stockQuantity: (json['stockQuantity'] as num).toInt(),
      soldQuantity: (json['soldQuantity'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$FlashSaleItemDtoToJson(_FlashSaleItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign': instance.campaign,
      'restaurantId': instance.restaurantId,
      'menuItemId': instance.menuItemId,
      'menuItemName': instance.menuItemName,
      'originalPrice': instance.originalPrice,
      'flashSalePrice': instance.flashSalePrice,
      'stockQuantity': instance.stockQuantity,
      'soldQuantity': instance.soldQuantity,
      'status': instance.status,
    };
