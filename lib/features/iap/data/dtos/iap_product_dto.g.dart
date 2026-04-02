// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iap_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IapProductDto _$IapProductDtoFromJson(Map<String, dynamic> json) =>
    _IapProductDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      currencyCode: json['currencyCode'] as String,
      rawPrice: (json['rawPrice'] as num).toDouble(),
      productType: json['productType'] as String,
    );

Map<String, dynamic> _$IapProductDtoToJson(_IapProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'currencyCode': instance.currencyCode,
      'rawPrice': instance.rawPrice,
      'productType': instance.productType,
    };
