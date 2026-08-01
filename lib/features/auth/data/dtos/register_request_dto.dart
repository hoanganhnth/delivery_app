import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_dto.freezed.dart';
part 'register_request_dto.g.dart';

@freezed
sealed class RegisterRequestDto with _$RegisterRequestDto {
  const factory RegisterRequestDto({
    required String email,
    required String password,
    String? name,
    String? role,
  }) = _RegisterRequestDto;

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);
}

@freezed
sealed class AuthRegistrationDataDto with _$AuthRegistrationDataDto {
  const factory AuthRegistrationDataDto({
    required int authId,
    required String email,
    required String role,
    required String provisioningToken,
  }) = _AuthRegistrationDataDto;

  factory AuthRegistrationDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuthRegistrationDataDtoFromJson(json);
}

@freezed
sealed class UserRegistrationRequestDto with _$UserRegistrationRequestDto {
  const factory UserRegistrationRequestDto({
    required String provisioningToken,
    String? fullName,
  }) = _UserRegistrationRequestDto;

  factory UserRegistrationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestDtoFromJson(json);
}

@freezed
sealed class UserRegistrationDataDto with _$UserRegistrationDataDto {
  const factory UserRegistrationDataDto({
    required int id,
    required int authId,
    required String email,
    required String role,
    String? fullName,
  }) = _UserRegistrationDataDto;

  factory UserRegistrationDataDto.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationDataDtoFromJson(json);
}
