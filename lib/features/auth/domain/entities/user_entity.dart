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
}
