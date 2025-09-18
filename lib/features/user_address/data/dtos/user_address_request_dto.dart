import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address_request_dto.freezed.dart';
part 'user_address_request_dto.g.dart';

@freezed
abstract class UserAddressRequestDto with _$UserAddressRequestDto {
  const factory UserAddressRequestDto({
    required String label,
    required String addressLine,
    required String ward,
    required String district,
    required String city,
    String? postalCode,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) = _UserAddressRequestDto;

  factory UserAddressRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserAddressRequestDtoFromJson(json);
}
