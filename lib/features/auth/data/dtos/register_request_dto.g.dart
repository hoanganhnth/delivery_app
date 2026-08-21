// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequestDto _$RegisterRequestDtoFromJson(Map<String, dynamic> json) =>
    _RegisterRequestDto(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$RegisterRequestDtoToJson(_RegisterRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'role': instance.role,
    };

_AuthRegistrationDataDto _$AuthRegistrationDataDtoFromJson(
  Map<String, dynamic> json,
) => _AuthRegistrationDataDto(
  authId: (json['authId'] as num).toInt(),
  principalId: (json['principalId'] as num?)?.toInt(),
  email: json['email'] as String,
  role: json['role'] as String,
  provisioningToken: json['provisioningToken'] as String,
  registrationHandle: json['registrationHandle'] as String?,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  lifecycleStatus: json['lifecycleStatus'] as String?,
);

Map<String, dynamic> _$AuthRegistrationDataDtoToJson(
  _AuthRegistrationDataDto instance,
) => <String, dynamic>{
  'authId': instance.authId,
  'principalId': instance.principalId,
  'email': instance.email,
  'role': instance.role,
  'provisioningToken': instance.provisioningToken,
  'registrationHandle': instance.registrationHandle,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'lifecycleStatus': instance.lifecycleStatus,
};

_RegistrationStatusDataDto _$RegistrationStatusDataDtoFromJson(
  Map<String, dynamic> json,
) => _RegistrationStatusDataDto(
  principalId: (json['principalId'] as num).toInt(),
  status: json['status'] as String,
  nextAction: json['nextAction'] as String,
  profileLinked: json['profileLinked'] as bool?,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$RegistrationStatusDataDtoToJson(
  _RegistrationStatusDataDto instance,
) => <String, dynamic>{
  'principalId': instance.principalId,
  'status': instance.status,
  'nextAction': instance.nextAction,
  'profileLinked': instance.profileLinked,
  'expiresAt': instance.expiresAt?.toIso8601String(),
};

_UserRegistrationRequestDto _$UserRegistrationRequestDtoFromJson(
  Map<String, dynamic> json,
) => _UserRegistrationRequestDto(
  provisioningToken: json['provisioningToken'] as String,
  fullName: json['fullName'] as String?,
);

Map<String, dynamic> _$UserRegistrationRequestDtoToJson(
  _UserRegistrationRequestDto instance,
) => <String, dynamic>{
  'provisioningToken': instance.provisioningToken,
  'fullName': instance.fullName,
};

_UserRegistrationDataDto _$UserRegistrationDataDtoFromJson(
  Map<String, dynamic> json,
) => _UserRegistrationDataDto(
  id: (json['id'] as num).toInt(),
  authId: (json['authId'] as num).toInt(),
  email: json['email'] as String,
  role: json['role'] as String,
  fullName: json['fullName'] as String?,
);

Map<String, dynamic> _$UserRegistrationDataDtoToJson(
  _UserRegistrationDataDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'authId': instance.authId,
  'email': instance.email,
  'role': instance.role,
  'fullName': instance.fullName,
};
