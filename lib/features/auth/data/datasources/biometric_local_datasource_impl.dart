import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart' as local_auth;
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/biometric_entity.dart';
import '../models/token_model.dart';
import 'biometric_local_datasource.dart';

/// Implementation of biometric local datasource using local_auth and Hive
class BiometricLocalDataSourceImpl implements BiometricLocalDataSource {
  final local_auth.LocalAuthentication _localAuth;
  final Box _secureBox;

  // Keys for Hive storage
  static const String _sessionKey = 'biometric_auth_session';
  static const String _enabledKey = 'biometric_enabled';

  BiometricLocalDataSourceImpl(this._localAuth, this._secureBox);

  @override
  Future<bool> canCheckBiometrics() async {
    try {
      AppLogger.d('Checking if device can check biometrics');
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      final result = canCheck && isDeviceSupported;
      AppLogger.i('Biometric availability: $result');
      return result;
    } catch (e) {
      AppLogger.e('Error checking biometric availability', e);
      throw Exception(
        'Failed to check biometric availability: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      AppLogger.d('Getting available biometric types');
      final availableBiometrics = await _localAuth.getAvailableBiometrics();

      final biometricTypes = <BiometricType>[];

      for (final biometric in availableBiometrics) {
        // Map from local_auth BiometricType to our domain BiometricType
        if (biometric == local_auth.BiometricType.face) {
          biometricTypes.add(BiometricType.face);
        } else if (biometric == local_auth.BiometricType.fingerprint) {
          biometricTypes.add(BiometricType.fingerprint);
        } else if (biometric == local_auth.BiometricType.iris) {
          biometricTypes.add(BiometricType.iris);
        }
      }

      AppLogger.i('Available biometric types: $biometricTypes');
      return biometricTypes;
    } catch (e) {
      AppLogger.e('Error getting available biometrics', e);
      throw Exception('Failed to get available biometrics: ${e.toString()}');
    }
  }

  @override
  Future<bool> authenticate(String reason) async {
    try {
      AppLogger.d('Attempting biometric authentication');

      final authenticated = await _localAuth.authenticate(
        localizedReason: reason,
        options: const local_auth.AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        AppLogger.i('Biometric authentication successful');
      } else {
        AppLogger.w('Biometric authentication failed');
      }

      return authenticated;
    } catch (e) {
      AppLogger.e('Error during biometric authentication', e);
      throw Exception('Biometric authentication error: ${e.toString()}');
    }
  }

  @override
  Future<void> saveAuthSession({
    required String accessToken,
    String? refreshToken,
  }) async {
    try {
      AppLogger.d('Saving biometric auth session');

      final tokenModel = TokenModel(
        accessToken: accessToken,
        refreshToken: refreshToken ?? '',
      );

      await _secureBox.put(_sessionKey, tokenModel.toJson());
      await _secureBox.put(_enabledKey, true);

      AppLogger.i('Biometric auth session saved successfully');
    } catch (e) {
      AppLogger.e('Error saving biometric auth session', e);
      throw Exception('Failed to save auth session: ${e.toString()}');
    }
  }

  @override
  Future<TokenModel?> getAuthSession() async {
    try {
      AppLogger.d('Getting saved biometric auth session');

      final data = _secureBox.get(_sessionKey);
      if (data == null) {
        AppLogger.i('No biometric auth session found');
        return null;
      }

      final tokenModel = TokenModel.fromJson(
        Map<String, dynamic>.from(data as Map),
      );

      AppLogger.i('Biometric auth session retrieved successfully');
      return tokenModel;
    } catch (e) {
      AppLogger.e('Error getting biometric auth session', e);
      throw Exception('Failed to get auth session: ${e.toString()}');
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      AppLogger.d('Clearing biometric auth session');

      await _secureBox.delete(_sessionKey);
      await _secureBox.put(_enabledKey, false);

      AppLogger.i('Biometric auth session cleared successfully');
    } catch (e) {
      AppLogger.e('Error clearing biometric auth session', e);
      throw Exception('Failed to clear auth session: ${e.toString()}');
    }
  }

  @override
  Future<bool> isBiometricEnabled() async {
    try {
      final enabled = _secureBox.get(_enabledKey, defaultValue: false) as bool;
      AppLogger.d('Biometric enabled status: $enabled');
      return enabled;
    } catch (e) {
      AppLogger.e('Error checking biometric enabled status', e);
      return false;
    }
  }

  @override
  Future<void> setBiometricEnabled(bool enabled) async {
    try {
      AppLogger.d('Setting biometric enabled: $enabled');
      await _secureBox.put(_enabledKey, enabled);

      if (!enabled) {
        // Clear session when disabling
        await _secureBox.delete(_sessionKey);
      }

      AppLogger.i('Biometric enabled status updated to: $enabled');
    } catch (e) {
      AppLogger.e('Error setting biometric enabled status', e);
      throw Exception('Failed to set biometric enabled: ${e.toString()}');
    }
  }
}
