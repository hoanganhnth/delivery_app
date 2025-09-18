import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_address_entity.dart';

part 'user_address_response_dto.freezed.dart';
part 'user_address_response_dto.g.dart';

@freezed
abstract class UserAddressResponseDto with _$UserAddressResponseDto {
  const factory UserAddressResponseDto({
    int? id,
    required int userId,
    required String label,
    required String addressLine,
    required String ward,
    required String district,
    required String city,
    String? postalCode,
    double? latitude,
    double? longitude,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserAddressResponseDto;

  factory UserAddressResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressResponseDtoFromJson(json);
}

extension UserAddressResponseDtoX on UserAddressResponseDto {
  UserAddressEntity toEntity() {
    return UserAddressEntity(
      id: id,
      userId: userId,
      label: label,
      addressLine: addressLine,
      ward: ward,
      district: district,
      city: city,
      postalCode: postalCode,
      latitude: latitude,
      longitude: longitude,
      isDefault: isDefault ?? false,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserAddressEntityX on UserAddressEntity {
  UserAddressResponseDto toDto() {
    return UserAddressResponseDto(
      id: id,
      userId: userId,
      label: label,
      addressLine: addressLine,
      ward: ward,
      district: district,
      city: city,
      postalCode: postalCode,
      latitude: latitude,
      longitude: longitude,
      isDefault: isDefault,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
