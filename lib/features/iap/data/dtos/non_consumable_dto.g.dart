// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'non_consumable_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NonConsumableDto _$NonConsumableDtoFromJson(Map<String, dynamic> json) =>
    _NonConsumableDto(
      productId: json['productId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      currencyCode: json['currencyCode'] as String,
      rawPrice: (json['rawPrice'] as num).toDouble(),
      featureType: json['featureType'] as String,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
    );

Map<String, dynamic> _$NonConsumableDtoToJson(_NonConsumableDto instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'currencyCode': instance.currencyCode,
      'rawPrice': instance.rawPrice,
      'featureType': instance.featureType,
      'isUnlocked': instance.isUnlocked,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
    };

_UnlockedFeaturesDto _$UnlockedFeaturesDtoFromJson(Map<String, dynamic> json) =>
    _UnlockedFeaturesDto(
      featureIds: (json['featureIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$UnlockedFeaturesDtoToJson(
  _UnlockedFeaturesDto instance,
) => <String, dynamic>{
  'featureIds': instance.featureIds,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
};
