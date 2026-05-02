import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculate_response_dto.freezed.dart';
part 'calculate_response_dto.g.dart';

@freezed
abstract class CalculateResponseDto with _$CalculateResponseDto {
  const factory CalculateResponseDto({
    @Default([]) List<VoucherInfoDto> availableVouchers,
    @Default([]) List<UnavailableVoucherInfoDto> unavailableVouchers,
    required double finalSubTotal,
    required double finalShippingFee,
    required double totalDiscount,
    required double totalAmount,
  }) = _CalculateResponseDto;

  factory CalculateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CalculateResponseDtoFromJson(json);
}

@freezed
abstract class VoucherInfoDto with _$VoucherInfoDto {
  const factory VoucherInfoDto({
    required int id,
    required String code,
    required String name,
    required String rewardType,
    required double discountValue,
    int? voucherGroupId,
  }) = _VoucherInfoDto;

  factory VoucherInfoDto.fromJson(Map<String, dynamic> json) =>
      _$VoucherInfoDtoFromJson(json);
}

@freezed
abstract class UnavailableVoucherInfoDto with _$UnavailableVoucherInfoDto {
  const factory UnavailableVoucherInfoDto({
    required int id,
    required String code,
    required String name,
    required String reason,
  }) = _UnavailableVoucherInfoDto;

  factory UnavailableVoucherInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UnavailableVoucherInfoDtoFromJson(json);
}
