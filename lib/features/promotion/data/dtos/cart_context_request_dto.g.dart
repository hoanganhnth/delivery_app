// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_context_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartContextRequestDto _$CartContextRequestDtoFromJson(
  Map<String, dynamic> json,
) => _CartContextRequestDto(
  shopId: (json['shopId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  subTotal: (json['subTotal'] as num).toDouble(),
  shippingFee: (json['shippingFee'] as num).toDouble(),
);

Map<String, dynamic> _$CartContextRequestDtoToJson(
  _CartContextRequestDto instance,
) => <String, dynamic>{
  'shopId': instance.shopId,
  'userId': instance.userId,
  'subTotal': instance.subTotal,
  'shippingFee': instance.shippingFee,
};
