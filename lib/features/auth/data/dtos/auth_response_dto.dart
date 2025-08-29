import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/data/dtos/base_response_dto.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

@freezed
abstract class AuthDataDto with _$AuthDataDto {
  const factory AuthDataDto({
    required String accessToken,
    required String refreshToken,
    UserDto? user,
  }) = _AuthDataDto;

  factory AuthDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDataDtoFromJson(json);
}

extension AuthDataDtoExtension on AuthDataDto {
  AuthEntity toEntity() {
    return AuthEntity(accessToken: accessToken, refreshToken: refreshToken);
  }
}

// Wrapper for the complete response
typedef AuthResponseDto = BaseResponseDto<AuthDataDto>;

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    required String email,
    String? name,
    DateTime? createdAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
