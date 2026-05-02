// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_rating_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShipperRatingRequestDto _$ShipperRatingRequestDtoFromJson(
  Map<String, dynamic> json,
) => _ShipperRatingRequestDto(
  orderId: (json['orderId'] as num).toInt(),
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
);

Map<String, dynamic> _$ShipperRatingRequestDtoToJson(
  _ShipperRatingRequestDto instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'rating': instance.rating,
  'comment': instance.comment,
};
