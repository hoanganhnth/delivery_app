// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_login_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLoginRequestDto _$SocialLoginRequestDtoFromJson(
  Map<String, dynamic> json,
) => SocialLoginRequestDto(
  provider: json['provider'] as String,
  token: json['token'] as String,
  role: json['role'] as String?,
  deviceId: json['deviceId'] as String?,
  deviceName: json['deviceName'] as String?,
  deviceType: json['deviceType'] as String?,
  ipAddress: json['ipAddress'] as String?,
);

Map<String, dynamic> _$SocialLoginRequestDtoToJson(
  SocialLoginRequestDto instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'token': instance.token,
  'role': instance.role,
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
  'ipAddress': instance.ipAddress,
};
