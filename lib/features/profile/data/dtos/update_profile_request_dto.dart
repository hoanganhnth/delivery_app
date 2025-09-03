import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'update_profile_request_dto.freezed.dart';
part 'update_profile_request_dto.g.dart';

@freezed
abstract class UpdateProfileRequestDto with _$UpdateProfileRequestDto {
  const factory UpdateProfileRequestDto({
 String? fullName,
    String? phone,
     String? dob,
    String? address,
  }) = _UpdateProfileRequestDto;

  factory UpdateProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestDtoFromJson(json);
}

extension UpdateProfileRequestDtoExtension on UpdateProfileRequestDto {
  static UpdateProfileRequestDto fromEntity(UserEntity entity) {
    return UpdateProfileRequestDto(
      fullName: entity.fullName,
      phone: entity.phone,
      dob: entity.dob?.toIso8601String().split('T').first, // Only date part
      address: entity.address,
    );
  }
}
