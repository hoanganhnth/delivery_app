// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLoginRequestDto _$SocialLoginRequestDtoFromJson(
  Map<String, dynamic> json,
) => _SocialLoginRequestDto(
  provider: json['provider'] as String,
  token: json['token'] as String,
  role: json['role'] as String?,
  deviceId: json['deviceId'] as String?,
  deviceName: json['deviceName'] as String?,
  deviceType: json['deviceType'] as String?,
  ipAddress: json['ipAddress'] as String?,
);

Map<String, dynamic> _$SocialLoginRequestDtoToJson(
  _SocialLoginRequestDto instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'token': instance.token,
  'role': instance.role,
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
  'ipAddress': instance.ipAddress,
};
