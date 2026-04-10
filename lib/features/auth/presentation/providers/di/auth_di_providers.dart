import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/network/dio/network_providers.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../data/datasources/auth_remote_datasource_impl.dart';
import '../../../data/repositories_impl/auth_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../domain/usecases/refresh_token_usecase.dart';

part 'auth_di_providers.g.dart';

// Use the global Dio provider from core
// Auth endpoints don't need authentication, so we use the basic dio

// API service provider (for auth endpoints - no auth required)
@Riverpod(keepAlive: true)
AuthApiService authApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthApiService(dio);
}

// Data source provider
@Riverpod(keepAlive: true)
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final apiService = ref.watch(authApiServiceProvider);
  return AuthRemoteDataSourceImpl(apiService);
}

// Repository provider
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
}

// Use cases providers
@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
}

@Riverpod(keepAlive: true)
RegisterUseCase registerUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository);
}

@Riverpod(keepAlive: true)
RefreshTokenUseCase refreshTokenUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshTokenUseCase(repository);
}
