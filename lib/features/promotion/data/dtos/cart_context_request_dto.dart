import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_context_request_dto.freezed.dart';
part 'cart_context_request_dto.g.dart';

@freezed
abstract class CartContextRequestDto with _$CartContextRequestDto {
  const factory CartContextRequestDto({
    required int shopId,
    required int userId,
    required double subTotal,
    required double shippingFee,
  }) = _CartContextRequestDto;

  factory CartContextRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CartContextRequestDtoFromJson(json);
}
