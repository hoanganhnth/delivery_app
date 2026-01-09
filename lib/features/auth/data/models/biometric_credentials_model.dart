import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/biometric_entity.dart';

part 'biometric_credentials_model.freezed.dart';
part 'biometric_credentials_model.g.dart';

/// Model for storing biometric credentials in local storage
@freezed
abstract class BiometricCredentialsModel with _$BiometricCredentialsModel {
  const BiometricCredentialsModel._();

  const factory BiometricCredentialsModel({
    required String email,
    required String encryptedPassword,
    required DateTime savedAt,
  }) = _BiometricCredentialsModel;

  factory BiometricCredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$BiometricCredentialsModelFromJson(json);

  /// Convert model to entity
  BiometricCredentials toEntity() {
    return BiometricCredentials(
      email: email,
      encryptedPassword: encryptedPassword,
    );
  }

  /// Create model from entity
  factory BiometricCredentialsModel.fromEntity(BiometricCredentials entity) {
    return BiometricCredentialsModel(
      email: entity.email,
      encryptedPassword: entity.encryptedPassword,
      savedAt: DateTime.now(),
    );
  }
}
