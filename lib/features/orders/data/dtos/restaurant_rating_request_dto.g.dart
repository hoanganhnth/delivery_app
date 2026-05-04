// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_rating_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantRatingRequestDto _$RestaurantRatingRequestDtoFromJson(
  Map<String, dynamic> json,
) => _RestaurantRatingRequestDto(
  orderId: (json['orderId'] as num).toInt(),
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
);

Map<String, dynamic> _$RestaurantRatingRequestDtoToJson(
  _RestaurantRatingRequestDto instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'rating': instance.rating,
  'comment': instance.comment,
};
