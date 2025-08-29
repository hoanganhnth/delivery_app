import '../../domain/entities/user_entity.dart';

class AuthModel extends UserEntity {
  AuthModel({
    required super.id,
    required super.email,
    required super.accessToken,
    required super.refreshToken,
    super.name,
    super.createdAt,
  });

  factory AuthModel.fromEntity(UserEntity entity) {
    return AuthModel(
      id: entity.id,
      email: entity.email,
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      name: entity.name,
      createdAt: entity.createdAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
      name: name,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] as int,
      email: json['email'] as String,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      name: json['name'] as String?,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  String toString() {
    return 'AuthModel(id: $id, email: $email, name: $name, createdAt: $createdAt)';
  }
}
