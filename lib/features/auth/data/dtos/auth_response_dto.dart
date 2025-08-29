import 'package:json_annotation/json_annotation.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthDataDto {
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  final UserDto user;

  AuthDataDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataDtoToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: user.id,
      email: user.email,
      accessToken: accessToken,
      refreshToken: refreshToken,
      name: user.name,
      createdAt: user.createdAt,
    );
  }
}

// Wrapper for the complete response
typedef AuthResponseDto = BaseResponseDto<AuthDataDto>;

@JsonSerializable()
class UserDto {
  final String id;
  final String email;
  final String? name;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  UserDto({
    required this.id,
    required this.email,
    this.name,
    this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
