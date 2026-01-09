// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_credentials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiometricCredentialsModel _$BiometricCredentialsModelFromJson(
  Map<String, dynamic> json,
) => _BiometricCredentialsModel(
  email: json['email'] as String,
  encryptedPassword: json['encryptedPassword'] as String,
  savedAt: DateTime.parse(json['savedAt'] as String),
);

Map<String, dynamic> _$BiometricCredentialsModelToJson(
  _BiometricCredentialsModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'encryptedPassword': instance.encryptedPassword,
  'savedAt': instance.savedAt.toIso8601String(),
};
