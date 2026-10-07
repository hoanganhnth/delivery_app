import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_restaurants_request_dto.freezed.dart';
part 'search_restaurants_request_dto.g.dart';

@freezed
sealed class SearchRestaurantsRequestDto with _$SearchRestaurantsRequestDto {
  const factory SearchRestaurantsRequestDto({
    required String keyword,
    @JsonKey(includeToJson: false)
    double? latitude,
    @JsonKey(includeToJson: false)
    double? longitude,
    @JsonKey(includeToJson: false)
    String? category,
    @JsonKey(includeToJson: false)
    int? page,
    @JsonKey(includeToJson: false)
    int? limit,
  }) = _SearchRestaurantsRequestDto;

  factory SearchRestaurantsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SearchRestaurantsRequestDtoFromJson(json);
}
