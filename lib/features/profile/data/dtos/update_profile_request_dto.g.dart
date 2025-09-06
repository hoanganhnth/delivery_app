// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateProfileRequestDto _$UpdateProfileRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _UpdateProfileRequestDto(
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestDtoToJson(
        _UpdateProfileRequestDto instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phone': instance.phone,
      'dob': instance.dob,
      'address': instance.address,
    };
