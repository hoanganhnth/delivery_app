// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserAddressRequestDto _$UserAddressRequestDtoFromJson(
  Map<String, dynamic> json,
) => _UserAddressRequestDto(
  label: json['label'] as String,
  addressLine: json['addressLine'] as String,
  ward: json['ward'] as String,
  district: json['district'] as String,
  city: json['city'] as String,
  postalCode: json['postalCode'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isDefault: json['isDefault'] as bool?,
);

Map<String, dynamic> _$UserAddressRequestDtoToJson(
  _UserAddressRequestDto instance,
) => <String, dynamic>{
  'label': instance.label,
  'addressLine': instance.addressLine,
  'ward': instance.ward,
  'district': instance.district,
  'city': instance.city,
  'postalCode': instance.postalCode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'isDefault': instance.isDefault,
};
