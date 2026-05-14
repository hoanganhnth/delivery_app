// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlashSaleCampaign _$FlashSaleCampaignFromJson(Map<String, dynamic> json) =>
    _FlashSaleCampaign(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      isRecurring: json['isRecurring'] as bool,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$FlashSaleCampaignToJson(_FlashSaleCampaign instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isRecurring': instance.isRecurring,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

_FlashSaleItem _$FlashSaleItemFromJson(Map<String, dynamic> json) =>
    _FlashSaleItem(
      id: (json['id'] as num).toInt(),
      campaign: FlashSaleCampaign.fromJson(
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

Map<String, dynamic> _$FlashSaleItemToJson(_FlashSaleItem instance) =>
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
