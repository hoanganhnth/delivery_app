// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculate_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalculateResponseDto _$CalculateResponseDtoFromJson(
  Map<String, dynamic> json,
) => _CalculateResponseDto(
  availableVouchers:
      (json['availableVouchers'] as List<dynamic>?)
          ?.map((e) => VoucherInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  unavailableVouchers:
      (json['unavailableVouchers'] as List<dynamic>?)
          ?.map(
            (e) =>
                UnavailableVoucherInfoDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  finalSubTotal: (json['finalSubTotal'] as num).toDouble(),
  finalShippingFee: (json['finalShippingFee'] as num).toDouble(),
  totalDiscount: (json['totalDiscount'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
);

Map<String, dynamic> _$CalculateResponseDtoToJson(
  _CalculateResponseDto instance,
) => <String, dynamic>{
  'availableVouchers': instance.availableVouchers,
  'unavailableVouchers': instance.unavailableVouchers,
  'finalSubTotal': instance.finalSubTotal,
  'finalShippingFee': instance.finalShippingFee,
  'totalDiscount': instance.totalDiscount,
  'totalAmount': instance.totalAmount,
};

_VoucherInfoDto _$VoucherInfoDtoFromJson(Map<String, dynamic> json) =>
    _VoucherInfoDto(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      rewardType: json['rewardType'] as String,
      discountValue: (json['discountValue'] as num).toDouble(),
      voucherGroupId: (json['voucherGroupId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VoucherInfoDtoToJson(_VoucherInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'rewardType': instance.rewardType,
      'discountValue': instance.discountValue,
      'voucherGroupId': instance.voucherGroupId,
    };

_UnavailableVoucherInfoDto _$UnavailableVoucherInfoDtoFromJson(
  Map<String, dynamic> json,
) => _UnavailableVoucherInfoDto(
  id: (json['id'] as num).toInt(),
  code: json['code'] as String,
  name: json['name'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$UnavailableVoucherInfoDtoToJson(
  _UnavailableVoucherInfoDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'reason': instance.reason,
};
