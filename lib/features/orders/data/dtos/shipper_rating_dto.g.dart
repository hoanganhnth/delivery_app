// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_rating_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShipperRatingDto _$ShipperRatingDtoFromJson(Map<String, dynamic> json) =>
    _ShipperRatingDto(
      id: (json['id'] as num).toInt(),
      shipperId: (json['shipperId'] as num).toInt(),
      customerId: (json['customerId'] as num).toInt(),
      orderId: (json['orderId'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ShipperRatingDtoToJson(_ShipperRatingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shipperId': instance.shipperId,
      'customerId': instance.customerId,
      'orderId': instance.orderId,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };
