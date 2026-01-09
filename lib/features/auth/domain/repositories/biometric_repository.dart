import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/biometric_entity.dart';
import '../../data/models/token_model.dart';

/// Repository interface for biometric authentication
abstract class BiometricRepository {
  /// Check if biometric authentication is available on the device
  Future<Either<Failure, bool>> isBiometricAvailable();

  /// Get list of available biometric types on the device
  Future<Either<Failure, List<BiometricType>>> getAvailableBiometrics();

  /// Authenticate user using biometric
  /// [reason] is the message shown to user during authentication
  Future<Either<Failure, bool>> authenticate(String reason);

  /// Save auth session (tokens) for biometric login
  Future<Either<Failure, void>> saveAuthSession({
    required String accessToken,
    String? refreshToken,
  });

  /// Get saved auth session
  /// Returns null if no session is saved
  Future<Either<Failure, TokenModel?>> getAuthSession();

  /// Clear saved auth session
  Future<Either<Failure, void>> clearAuthSession();

  /// Check if biometric login is enabled
  Future<Either<Failure, bool>> isBiometricEnabled();

  /// Enable or disable biometric login
  Future<Either<Failure, void>> setBiometricEnabled(bool enabled);
}
