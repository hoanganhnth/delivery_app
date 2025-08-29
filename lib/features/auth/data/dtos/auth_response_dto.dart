import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/data/dtos/base_response_dto.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthDataDto {
  final String accessToken;

  final String refreshToken;

  final UserDto? user;

  AuthDataDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataDtoToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(accessToken: accessToken, refreshToken: refreshToken);
  }
}

// Wrapper for the complete response
typedef AuthResponseDto = BaseResponseDto<AuthDataDto>;

@JsonSerializable()
class UserDto {
  final int id;
  final String email;
  final String? name;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  UserDto({required this.id, required this.email, this.name, this.createdAt});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
