// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      id: (json['id'] as num?)?.toInt(),
      authId: (json['authId'] as num).toInt(),
      email: json['email'] as String,
      role: json['role'] as String,
      fullName: json['fullName'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      address: json['address'] as String?,
      createdAtString: json['createdAtString'] as String?,
      updatedAtString: json['updatedAtString'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authId': instance.authId,
      'email': instance.email,
      'role': instance.role,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'dob': instance.dob,
      'avatarUrl': instance.avatarUrl,
      'address': instance.address,
      'createdAtString': instance.createdAtString,
      'updatedAtString': instance.updatedAtString,
    };
