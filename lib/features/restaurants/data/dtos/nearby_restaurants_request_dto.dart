import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_restaurants_request_dto.freezed.dart';
part 'nearby_restaurants_request_dto.g.dart';

@freezed
abstract class NearbyRestaurantsRequestDto with _$NearbyRestaurantsRequestDto {
  const factory NearbyRestaurantsRequestDto({
    required double latitude,
    required double longitude,
    double? radius,
  }) = _NearbyRestaurantsRequestDto;

  factory NearbyRestaurantsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$NearbyRestaurantsRequestDtoFromJson(json);
}
