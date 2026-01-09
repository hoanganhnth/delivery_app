import '../../domain/entities/biometric_entity.dart';
import '../models/token_model.dart';

/// Local datasource interface for biometric authentication
abstract class BiometricLocalDataSource {
  /// Check if device can check biometrics
  Future<bool> canCheckBiometrics();

  /// Get list of available biometric types
  Future<List<BiometricType>> getAvailableBiometrics();

  /// Authenticate user with biometric
  Future<bool> authenticate(String reason);

  /// Save auth session (tokens) after successful login
  Future<void> saveAuthSession({
    required String accessToken,
    String? refreshToken,
  });

  /// Get saved auth session
  Future<TokenModel?> getAuthSession();

  /// Clear saved session (logout)
  Future<void> clearSession();

  /// Check if biometric is enabled
  Future<bool> isBiometricEnabled();

  /// Enable or disable biometric
  Future<void> setBiometricEnabled(bool enabled);
}
