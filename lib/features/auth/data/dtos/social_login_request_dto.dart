import 'package:json_annotation/json_annotation.dart';

part 'social_login_request_dto.g.dart';

@JsonSerializable()
class SocialLoginRequestDto {
  final String provider;
  final String token;
  final String? role;
  final String? deviceId;
  final String? deviceName;
  final String? deviceType;
  final String? ipAddress;

  const SocialLoginRequestDto({
    required this.provider,
    required this.token,
    this.role,
    this.deviceId,
    this.deviceName,
    this.deviceType,
    this.ipAddress,
  });

  factory SocialLoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLoginRequestDtoToJson(this);
}
