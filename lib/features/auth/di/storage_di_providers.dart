import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:delivery_app/features/auth/data/datasources/token_local_data_source.dart';
import 'package:delivery_app/features/auth/data/datasources/token_local_data_source_impl.dart';
import 'package:delivery_app/features/auth/data/repositories_impl/token_storage_repository_impl.dart';
import 'package:delivery_app/features/auth/domain/repositories/token_storage_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/clear_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/get_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/store_tokens_usecase.dart';

part 'storage_di_providers.g.dart';

/// Provider for SharedPreferences
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
}

/// Provider for TokenLocalDataSource
@Riverpod(keepAlive: true)
TokenLocalDataSource tokenLocalDataSource(Ref ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return TokenLocalDataSourceImpl(prefs);
}

/// Provider for TokenStorageRepository
@Riverpod(keepAlive: true)
TokenStorageRepository tokenStorageRepository(Ref ref) {
  final localDataSource = ref.read(tokenLocalDataSourceProvider);
  return TokenStorageRepositoryImpl(localDataSource);
}

/// Provider for StoreTokensUseCase
@Riverpod(keepAlive: true)
StoreTokensUseCase storeTokensUseCase(Ref ref) {
  final repository = ref.read(tokenStorageRepositoryProvider);
  return StoreTokensUseCase(repository);
}

/// Provider for GetTokensUseCase
@Riverpod(keepAlive: true)
GetTokensUseCase getTokensUseCase(Ref ref) {
  final repository = ref.read(tokenStorageRepositoryProvider);
  return GetTokensUseCase(repository);
}

/// Provider for ClearTokensUseCase
@Riverpod(keepAlive: true)
ClearTokensUseCase clearTokensUseCase(Ref ref) {
  final repository = ref.read(tokenStorageRepositoryProvider);
  return ClearTokensUseCase(repository);
}
