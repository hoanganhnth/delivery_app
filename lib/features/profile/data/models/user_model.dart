import 'package:hive_flutter/hive_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/adapter/hive_registry.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
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
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// Manual Hive Adapter
class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = HiveTypeIds.userModel;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int?,
      authId: fields[1] as int,
      email: fields[2] as String,
      role: fields[3] as String,
      fullName: fields[4] as String?,
      phone: fields[5] as String?,
      dob: fields[6] as String?,
      avatarUrl: fields[7] as String?,
      address: fields[8] as String?,
      createdAtString: fields[9] as String?,
      updatedAtString: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.authId)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.fullName)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.avatarUrl)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.createdAtString)
      ..writeByte(10)
      ..write(obj.updatedAtString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

extension UserModelExtension on UserModel {
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
      createdAt: createdAtString != null ? DateTime.tryParse(createdAtString!) : null,
      updatedAt: updatedAtString != null ? DateTime.tryParse(updatedAtString!) : null,
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      authId: entity.authId,
      email: entity.email,
      role: entity.role,
      fullName: entity.fullName,
      phone: entity.phone,
      dob: entity.dob?.toIso8601String(),
      avatarUrl: entity.avatarUrl,
      address: entity.address,
      createdAtString: entity.createdAt?.toIso8601String(),
      updatedAtString: entity.updatedAt?.toIso8601String(),
    );
  }
}
