import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_request_dto.g.dart';
part 'social_login_request_dto.freezed.dart';

@freezed
sealed class SocialLoginRequestDto with _$SocialLoginRequestDto {
  const factory SocialLoginRequestDto({
    required String provider,
    required String token,
    String? role,
    String? deviceId,
    String? deviceName,
    String? deviceType,
    String? ipAddress,
  }) = _SocialLoginRequestDto;

  factory SocialLoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestDtoFromJson(json);
}
