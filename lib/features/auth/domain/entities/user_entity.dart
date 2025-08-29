class UserEntity {
  final int id;
  final String email;
  final String accessToken;
  final String refreshToken;
  final String? name;
  final DateTime? createdAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    this.name,
    this.createdAt,
  });

  UserEntity copyWith({
    int? id,
    String? email,
    String? accessToken,
    String? refreshToken,
    String? name,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.email == email &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.name == name &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        name.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, name: $name, createdAt: $createdAt)';
  }
}
