import 'package:json_annotation/json_annotation.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  final String email;
  final String password;
  final String? deviceId;
  final String? deviceName;
  final String? deviceType;
  final String? ipAddress;

  LoginRequestDto({
    required this.email,
    required this.password,
    this.deviceId,
    this.deviceName,
    this.deviceType,
    this.ipAddress,
  });

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);
}
