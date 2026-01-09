/// Entity representing biometric credentials stored locally
class BiometricCredentials {
  final String email;
  final String encryptedPassword;

  BiometricCredentials({required this.email, required this.encryptedPassword});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BiometricCredentials &&
        other.email == email &&
        other.encryptedPassword == encryptedPassword;
  }

  @override
  int get hashCode => email.hashCode ^ encryptedPassword.hashCode;

  @override
  String toString() =>
      'BiometricCredentials(email: $email, encryptedPassword: ***)';
}

/// Types of biometric authentication available
enum BiometricType { fingerprint, face, iris }

/// Extension to get display name for biometric types
extension BiometricTypeExtension on BiometricType {
  String get displayName {
    switch (this) {
      case BiometricType.fingerprint:
        return 'Fingerprint';
      case BiometricType.face:
        return 'Face ID';
      case BiometricType.iris:
        return 'Iris';
    }
  }
}
