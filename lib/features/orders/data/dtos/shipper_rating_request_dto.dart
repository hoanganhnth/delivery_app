import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipper_rating_request_dto.freezed.dart';
part 'shipper_rating_request_dto.g.dart';

@freezed
class ShipperRatingRequestDto with _$ShipperRatingRequestDto {
  const factory ShipperRatingRequestDto({
    required int orderId,
    required int rating,
    String? comment,
  }) = _ShipperRatingRequestDto;

  factory ShipperRatingRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ShipperRatingRequestDtoFromJson(json);
}
