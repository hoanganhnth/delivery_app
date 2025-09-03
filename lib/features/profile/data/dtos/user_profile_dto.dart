import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    int? id,
    required int authId,
    required String email,
    required String role,
    String? fullName,
    String? phone,
    String? dob,
    String? avatarUrl,
    String? address,
    String? createdAtString,
    String? updatedAtString,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}

extension UserProfileDtoExtension on UserProfileDto {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      authId: authId,
      email: email,
      role: role,
      fullName: fullName,
      phone: phone,
      dob: dob != null ? DateTime.tryParse(dob!) : null,
      avatarUrl: avatarUrl,
      address: address,
      createdAt: createdAtString != null
          ? DateTime.tryParse(createdAtString!)
          : null,
      updatedAt: updatedAtString != null
          ? DateTime.tryParse(updatedAtString!)
          : null,
    );
  }

  static UserProfileDto fromEntity(UserEntity entity) {
    return UserProfileDto(
      id: entity.id,
      authId: entity.authId,
      email: entity.email,
      role: entity.role,
      fullName: entity.fullName,
      phone: entity.phone,
      dob: entity.dob
          ?.toIso8601String()
          .split('T')
          .first, // Only date part
      avatarUrl: entity.avatarUrl,
      address: entity.address,
      createdAtString: entity.createdAt?.toIso8601String(),
      updatedAtString: entity.updatedAt?.toIso8601String(),
    );
  }
}
