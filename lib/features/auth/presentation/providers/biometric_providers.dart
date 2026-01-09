import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart' as local_auth;
import '../../data/datasources/biometric_local_datasource.dart';
import '../../data/datasources/biometric_local_datasource_impl.dart';
import '../../data/repositories_impl/biometric_repository_impl.dart';
import '../../domain/repositories/biometric_repository.dart';
import '../../domain/usecases/authenticate_with_biometric_usecase.dart';
import '../../domain/usecases/check_biometric_availability_usecase.dart';
import '../../domain/usecases/disable_biometric_usecase.dart';
import '../../domain/usecases/enable_biometric_usecase.dart';
import '../../domain/usecases/get_available_biometrics_usecase.dart';
import '../../domain/usecases/get_auth_session_usecase.dart';
import 'biometric_notifier.dart';
import 'biometric_state.dart';

// ============================================================================
// Infrastructure Providers
// ============================================================================

/// Provider for LocalAuthentication instance
final localAuthProvider = Provider<local_auth.LocalAuthentication>((ref) {
  return local_auth.LocalAuthentication();
});

/// Provider for Hive box for biometric credentials
final biometricBoxProvider = Provider<Box>((ref) {
  return Hive.box('biometric_credentials');
});

// ============================================================================
// DataSource Providers
// ============================================================================

/// Provider for biometric local datasource
final biometricLocalDataSourceProvider = Provider<BiometricLocalDataSource>((
  ref,
) {
  final localAuth = ref.watch(localAuthProvider);
  final box = ref.watch(biometricBoxProvider);
  return BiometricLocalDataSourceImpl(localAuth, box);
});

// ============================================================================
// Repository Providers
// ============================================================================

/// Provider for biometric repository
final biometricRepositoryProvider = Provider<BiometricRepository>((ref) {
  final dataSource = ref.watch(biometricLocalDataSourceProvider);
  return BiometricRepositoryImpl(dataSource);
});

// ============================================================================
// UseCase Providers
// ============================================================================

/// Provider for check biometric availability usecase
final checkBiometricAvailabilityUseCaseProvider =
    Provider<CheckBiometricAvailabilityUseCase>((ref) {
      final repository = ref.watch(biometricRepositoryProvider);
      return CheckBiometricAvailabilityUseCase(repository);
    });

/// Provider for get available biometrics usecase
final getAvailableBiometricsUseCaseProvider =
    Provider<GetAvailableBiometricsUseCase>((ref) {
      final repository = ref.watch(biometricRepositoryProvider);
      return GetAvailableBiometricsUseCase(repository);
    });

/// Provider for authenticate with biometric usecase
final authenticateWithBiometricUseCaseProvider =
    Provider<AuthenticateWithBiometricUseCase>((ref) {
      final repository = ref.watch(biometricRepositoryProvider);
      return AuthenticateWithBiometricUseCase(repository);
    });

/// Provider for enable biometric usecase
final enableBiometricUseCaseProvider = Provider<EnableBiometricUseCase>((ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return EnableBiometricUseCase(repository);
});

/// Provider for disable biometric usecase
final disableBiometricUseCaseProvider = Provider<DisableBiometricUseCase>((
  ref,
) {
  final repository = ref.watch(biometricRepositoryProvider);
  return DisableBiometricUseCase(repository);
});

/// Provider for GetAuthSessionUseCase
final getAuthSessionUseCaseProvider = Provider<GetAuthSessionUseCase>((ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return GetAuthSessionUseCase(repository);
});

// ============================================================================
// StateNotifier Provider
// ============================================================================

/// Provider for biometric state notifier
final biometricNotifierProvider =
    StateNotifierProvider<BiometricNotifier, BiometricState>((ref) {
      final checkAvailability = ref.watch(
        checkBiometricAvailabilityUseCaseProvider,
      );
      final getAvailableBiometrics = ref.watch(
        getAvailableBiometricsUseCaseProvider,
      );
      final authenticate = ref.watch(authenticateWithBiometricUseCaseProvider);
      final enableBiometric = ref.watch(enableBiometricUseCaseProvider);
      final disableBiometric = ref.watch(disableBiometricUseCaseProvider);
      final getAuthSession = ref.watch(getAuthSessionUseCaseProvider);

      return BiometricNotifier(
        checkAvailability: checkAvailability,
        getAvailableBiometrics: getAvailableBiometrics,
        authenticate: authenticate,
        enableBiometric: enableBiometric,
        disableBiometric: disableBiometric,
        getAuthSession: getAuthSession,
      );
    });
