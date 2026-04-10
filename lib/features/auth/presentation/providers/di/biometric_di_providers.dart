import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart' as local_auth;
import '../../../data/datasources/biometric_local_datasource.dart';
import '../../../data/datasources/biometric_local_datasource_impl.dart';
import '../../../data/repositories_impl/biometric_repository_impl.dart';
import '../../../domain/repositories/biometric_repository.dart';
import '../../../domain/usecases/authenticate_with_biometric_usecase.dart';
import '../../../domain/usecases/check_biometric_availability_usecase.dart';
import '../../../domain/usecases/disable_biometric_usecase.dart';
import '../../../domain/usecases/enable_biometric_usecase.dart';
import '../../../domain/usecases/get_available_biometrics_usecase.dart';
import '../../../domain/usecases/get_auth_session_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'biometric_di_providers.g.dart';

// ============================================================================
// Infrastructure Providers
// ============================================================================

/// Provider for LocalAuthentication instance
@Riverpod(keepAlive: true)
local_auth.LocalAuthentication localAuth(Ref ref) {
  return local_auth.LocalAuthentication();
}

/// Provider for Hive box for biometric credentials
@Riverpod(keepAlive: true)
Box biometricBox(Ref ref) {
  return Hive.box('biometric_credentials');
}

// ============================================================================
// DataSource Providers
// ============================================================================

/// Provider for biometric local datasource
@Riverpod(keepAlive: true)
BiometricLocalDataSource biometricLocalDataSource(Ref ref) {
  final localAuth = ref.watch(localAuthProvider);
  final box = ref.watch(biometricBoxProvider);
  return BiometricLocalDataSourceImpl(localAuth, box);
}

// ============================================================================
// Repository Providers
// ============================================================================

/// Provider for biometric repository
@Riverpod(keepAlive: true)
BiometricRepository biometricRepository(Ref ref) {
  final dataSource = ref.watch(biometricLocalDataSourceProvider);
  return BiometricRepositoryImpl(dataSource);
}

// ============================================================================
// UseCase Providers
// ============================================================================

/// Provider for check biometric availability usecase
@Riverpod(keepAlive: true)
CheckBiometricAvailabilityUseCase checkBiometricAvailabilityUseCase(Ref ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return CheckBiometricAvailabilityUseCase(repository);
}

/// Provider for get available biometrics usecase
@Riverpod(keepAlive: true)
GetAvailableBiometricsUseCase getAvailableBiometricsUseCase(Ref ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return GetAvailableBiometricsUseCase(repository);
}

/// Provider for authenticate with biometric usecase
@Riverpod(keepAlive: true)
AuthenticateWithBiometricUseCase authenticateWithBiometricUseCase(Ref ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return AuthenticateWithBiometricUseCase(repository);
}

/// Provider for enable biometric usecase
@Riverpod(keepAlive: true)
EnableBiometricUseCase enableBiometricUseCase(Ref ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return EnableBiometricUseCase(repository);
}

/// Provider for disable biometric usecase
@Riverpod(keepAlive: true)
DisableBiometricUseCase disableBiometricUseCase(Ref ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return DisableBiometricUseCase(repository);
}

/// Provider for GetAuthSessionUseCase
@Riverpod(keepAlive: true)
GetAuthSessionUseCase getAuthSessionUseCase(Ref ref) {
  final repository = ref.watch(biometricRepositoryProvider);
  return GetAuthSessionUseCase(repository);
}
