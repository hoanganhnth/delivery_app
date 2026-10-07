import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_restaurants_request_dto.freezed.dart';
part 'get_restaurants_request_dto.g.dart';

@freezed
sealed class GetRestaurantsRequestDto with _$GetRestaurantsRequestDto {
  const factory GetRestaurantsRequestDto({
    @JsonKey(includeToJson: false)
    double? latitude,
    @JsonKey(includeToJson: false)
    double? longitude,
    @JsonKey(includeToJson: false)
    String? category,
    @JsonKey(includeToJson: false)
    String? searchQuery,
    @JsonKey(includeToJson: false)
    int? page,
    @JsonKey(includeToJson: false)
    int? limit,
  }) = _GetRestaurantsRequestDto;

  factory GetRestaurantsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetRestaurantsRequestDtoFromJson(json);
}
