import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio/network_providers.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/auth_remote_datasource_impl.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import './auth_notifier.dart';
import './auth_state.dart';
import './token_storage_providers.dart';

// Use the global Dio provider from core
// Auth endpoints don't need authentication, so we use the basic dio

// API service provider (for auth endpoints - no auth required)
final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApiService(dio);
});

// Data source provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiService = ref.watch(authApiServiceProvider);
  return AuthRemoteDataSourceImpl(apiService);
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

// Use cases providers
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository);
});

final refreshTokenUseCaseProvider = Provider<RefreshTokenUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshTokenUseCase(repository);
});

// Auth state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);
  final refreshTokenUseCase = ref.watch(refreshTokenUseCaseProvider);
  final storeTokensUseCase = ref.watch(storeTokensUseCaseProvider);
  final getTokensUseCase = ref.watch(getTokensUseCaseProvider);
  final clearTokensUseCase = ref.watch(clearTokensUseCaseProvider);

  return AuthNotifier(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    refreshTokenUseCase: refreshTokenUseCase,
    storeTokensUseCase: storeTokensUseCase,
    getTokensUseCase: getTokensUseCase,
    clearTokensUseCase: clearTokensUseCase,
  );
});
