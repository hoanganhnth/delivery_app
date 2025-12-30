// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserAddressResponseDto _$UserAddressResponseDtoFromJson(
  Map<String, dynamic> json,
) => _UserAddressResponseDto(
  id: (json['id'] as num?)?.toInt(),
  userId: (json['userId'] as num).toInt(),
  label: json['label'] as String,
  recipientName: json['recipientName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  addressLine: json['addressLine'] as String,
  ward: json['ward'] as String,
  district: json['district'] as String,
  city: json['city'] as String,
  postalCode: json['postalCode'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isDefault: json['isDefault'] as bool?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserAddressResponseDtoToJson(
  _UserAddressResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'label': instance.label,
  'recipientName': instance.recipientName,
  'phoneNumber': instance.phoneNumber,
  'addressLine': instance.addressLine,
  'ward': instance.ward,
  'district': instance.district,
  'city': instance.city,
  'postalCode': instance.postalCode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'isDefault': instance.isDefault,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
