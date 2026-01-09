import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/authenticate_with_biometric_usecase.dart';
import '../../domain/usecases/check_biometric_availability_usecase.dart';
import '../../domain/usecases/disable_biometric_usecase.dart';
import '../../domain/usecases/enable_biometric_usecase.dart';
import '../../domain/usecases/get_available_biometrics_usecase.dart';
import '../../domain/usecases/get_auth_session_usecase.dart';
import 'biometric_state.dart';

/// Notifier for biometric authentication state
class BiometricNotifier extends StateNotifier<BiometricState> {
  final CheckBiometricAvailabilityUseCase _checkAvailability;
  final GetAvailableBiometricsUseCase _getAvailableBiometrics;
  final AuthenticateWithBiometricUseCase _authenticate;
  final EnableBiometricUseCase _enableBiometric;
  final DisableBiometricUseCase _disableBiometric;
  final GetAuthSessionUseCase _getAuthSession;

  BiometricNotifier({
    required CheckBiometricAvailabilityUseCase checkAvailability,
    required GetAvailableBiometricsUseCase getAvailableBiometrics,
    required AuthenticateWithBiometricUseCase authenticate,
    required EnableBiometricUseCase enableBiometric,
    required DisableBiometricUseCase disableBiometric,
    required GetAuthSessionUseCase getAuthSession,
  }) : _checkAvailability = checkAvailability,
       _getAvailableBiometrics = getAvailableBiometrics,
       _authenticate = authenticate,
       _enableBiometric = enableBiometric,
       _disableBiometric = disableBiometric,
       _getAuthSession = getAuthSession,
       super(const BiometricState());

  /// Check if biometric is available and get available types
  Future<void> checkBiometricAvailability() async {
    AppLogger.d('BiometricNotifier: Checking biometric availability');
    state = state.copyWith(isLoading: true, clearFailure: true);

    final availabilityResult = await _checkAvailability(NoParams());

    await availabilityResult.fold(
      (failure) async {
        AppLogger.e('BiometricNotifier: Failed to check availability');
        state = state.copyWith(
          isLoading: false,
          isAvailable: false,
          failure: failure,
        );
      },
      (isAvailable) async {
        if (isAvailable) {
          // Get available biometric types
          final typesResult = await _getAvailableBiometrics(NoParams());

          typesResult.fold(
            (failure) {
              AppLogger.e('BiometricNotifier: Failed to get biometric types');
              state = state.copyWith(
                isLoading: false,
                isAvailable: true,
                availableTypes: [],
                failure: failure,
              );
            },
            (types) {
              AppLogger.i(
                'BiometricNotifier: Biometric available with types: $types',
              );
              state = state.copyWith(
                isLoading: false,
                isAvailable: true,
                availableTypes: types,
              );
            },
          );
        } else {
          AppLogger.i('BiometricNotifier: Biometric not available');
          state = state.copyWith(
            isLoading: false,
            isAvailable: false,
            availableTypes: [],
          );
        }
      },
    );
  }

  /// Authenticate with biometric
  Future<bool> authenticateWithBiometric(String reason) async {
    AppLogger.d('BiometricNotifier: Authenticating with biometric');
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _authenticate(
      AuthenticateWithBiometricParams(reason: reason),
    );

    return result.fold(
      (failure) {
        AppLogger.e('BiometricNotifier: Authentication failed');
        state = state.copyWith(isLoading: false, failure: failure);
        return false;
      },
      (success) {
        AppLogger.i('BiometricNotifier: Authentication successful');
        state = state.copyWith(isLoading: false);
        return success;
      },
    );
  }

  /// Enable biometric login by saving auth tokens
  Future<void> enableBiometric(
    String accessToken, {
    String? refreshToken,
  }) async {
    AppLogger.d('BiometricNotifier: Enabling biometric with access token');
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _enableBiometric(
      EnableBiometricParams(
        accessToken: accessToken,
        refreshToken: refreshToken,
      ),
    );

    result.fold(
      (failure) {
        AppLogger.e('BiometricNotifier: Failed to enable biometric');
        state = state.copyWith(
          isLoading: false,
          isEnabled: false,
          failure: failure,
        );
      },
      (_) {
        AppLogger.i('BiometricNotifier: Biometric enabled successfully');
        state = state.copyWith(isLoading: false, isEnabled: true);
      },
    );
  }

  /// Disable biometric login
  Future<void> disableBiometric() async {
    AppLogger.d('BiometricNotifier: Disabling biometric');
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _disableBiometric(NoParams());

    result.fold(
      (failure) {
        AppLogger.e('BiometricNotifier: Failed to disable biometric');
        state = state.copyWith(isLoading: false, failure: failure);
      },
      (_) {
        AppLogger.i('BiometricNotifier: Biometric disabled successfully');
        state = state.copyWith(isLoading: false, isEnabled: false);
      },
    );
  }

  /// Check if biometric is enabled by checking for saved session
  Future<void> checkBiometricEnabled() async {
    AppLogger.d('BiometricNotifier: Checking if biometric is enabled');

    final result = await _getAuthSession(NoParams());

    result.fold(
      (failure) {
        AppLogger.e('BiometricNotifier: Failed to check biometric status');
        state = state.copyWith(isEnabled: false);
      },
      (session) {
        final isEnabled = session != null;
        AppLogger.i('BiometricNotifier: Biometric enabled: $isEnabled');
        state = state.copyWith(isEnabled: isEnabled);
      },
    );
  }
}
