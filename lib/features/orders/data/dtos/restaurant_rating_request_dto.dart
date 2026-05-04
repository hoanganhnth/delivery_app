import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_rating_request_dto.freezed.dart';
part 'restaurant_rating_request_dto.g.dart';

@freezed
abstract class RestaurantRatingRequestDto with _$RestaurantRatingRequestDto {
  const factory RestaurantRatingRequestDto({
    required int orderId,
    required int rating,
    String? comment,
  }) = _RestaurantRatingRequestDto;

  factory RestaurantRatingRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantRatingRequestDtoFromJson(json);
}
