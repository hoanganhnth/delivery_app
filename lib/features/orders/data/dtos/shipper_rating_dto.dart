import 'package:freezed_annotation/freezed_annotation.dart';

part 'shipper_rating_dto.freezed.dart';
part 'shipper_rating_dto.g.dart';

@freezed
abstract class ShipperRatingDto with _$ShipperRatingDto {
  const factory ShipperRatingDto({
    required int id,
    required int shipperId,
    required int customerId,
    required int orderId,
    required int rating,
    String? comment,
    required DateTime createdAt,
  }) = _ShipperRatingDto;

  factory ShipperRatingDto.fromJson(Map<String, dynamic> json) =>
      _$ShipperRatingDtoFromJson(json);
}
