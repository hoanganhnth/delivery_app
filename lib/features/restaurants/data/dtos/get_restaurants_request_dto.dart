import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_restaurants_request_dto.freezed.dart';
part 'get_restaurants_request_dto.g.dart';

@freezed
abstract class GetRestaurantsRequestDto with _$GetRestaurantsRequestDto {
  const factory GetRestaurantsRequestDto({
    double? latitude,
    double? longitude,
    String? category,
    String? searchQuery,
    int? page,
    int? limit,
  }) = _GetRestaurantsRequestDto;

  factory GetRestaurantsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetRestaurantsRequestDtoFromJson(json);
}
