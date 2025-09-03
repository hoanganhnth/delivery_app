import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final int authId;
  final String email;
  final String role;
  final String? fullName;
  final String? phone;
  final DateTime? dob;
  final String? avatarUrl;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    this.id,
    required this.authId,
    required this.email,
    required this.role,
    this.fullName,
    this.phone,
    this.dob,
    this.avatarUrl,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  UserEntity copyWith({
    int? id,
    int? authId,
    String? email,
    String? role,
    String? fullName,
    String? phone,
    DateTime? dob,
    String? avatarUrl,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      authId: authId ?? this.authId,
      email: email ?? this.email,
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasCompleteProfile {
    return fullName != null && 
           fullName!.isNotEmpty && 
           phone != null && 
           phone!.isNotEmpty;
  }

  String get displayName {
    if (fullName != null && fullName!.isNotEmpty) {
      return fullName!;
    }
    return email.split('@').first;
  }

  int get profileCompletionPercentage {
    int completedFields = 0;
    int totalFields = 6; // email, fullName, phone, dob, avatarUrl, address

    // Email is always required
    completedFields++;

    if (fullName != null && fullName!.isNotEmpty) completedFields++;
    if (phone != null && phone!.isNotEmpty) completedFields++;
    if (dob != null) completedFields++;
    if (avatarUrl != null && avatarUrl!.isNotEmpty) completedFields++;
    if (address != null && address!.isNotEmpty) completedFields++;

    return ((completedFields / totalFields) * 100).round();
  }

  @override
  List<Object?> get props => [
        id,
        authId,
        email,
        role,
        fullName,
        phone,
        dob,
        avatarUrl,
        address,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'UserEntity(id: $id, authId: $authId, email: $email, role: $role, '
           'fullName: $fullName, phone: $phone, dob: $dob, avatarUrl: $avatarUrl, '
           'address: $address, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
