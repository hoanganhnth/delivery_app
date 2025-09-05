import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_restaurants_request_dto.freezed.dart';
part 'search_restaurants_request_dto.g.dart';

@freezed
abstract class SearchRestaurantsRequestDto with _$SearchRestaurantsRequestDto {
  const factory SearchRestaurantsRequestDto({
    required String query,
    double? latitude,
    double? longitude,
    String? category,
    int? page,
    int? limit,
  }) = _SearchRestaurantsRequestDto;

  factory SearchRestaurantsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SearchRestaurantsRequestDtoFromJson(json);
}
