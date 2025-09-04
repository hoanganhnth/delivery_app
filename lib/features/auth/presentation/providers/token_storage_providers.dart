import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/token_local_data_source.dart';
import '../../data/datasources/token_local_data_source_impl.dart';
import '../../data/repositories_impl/token_storage_repository_impl.dart';
import '../../domain/repositories/token_storage_repository.dart';
import '../../domain/usecases/clear_tokens_usecase.dart';
import '../../domain/usecases/get_tokens_usecase.dart';
import '../../domain/usecases/store_tokens_usecase.dart';

/// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});

/// Provider for TokenLocalDataSource
final tokenLocalDataSourceProvider = Provider<TokenLocalDataSource>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return TokenLocalDataSourceImpl(prefs);
});

/// Provider for TokenStorageRepository
final tokenStorageRepositoryProvider = Provider<TokenStorageRepository>((ref) {
  final localDataSource = ref.read(tokenLocalDataSourceProvider);
  return TokenStorageRepositoryImpl(localDataSource);
});

/// Provider for StoreTokensUseCase
final storeTokensUseCaseProvider = Provider<StoreTokensUseCase>((ref) {
  final repository = ref.read(tokenStorageRepositoryProvider);
  return StoreTokensUseCase(repository);
});

/// Provider for GetTokensUseCase
final getTokensUseCaseProvider = Provider<GetTokensUseCase>((ref) {
  final repository = ref.read(tokenStorageRepositoryProvider);
  return GetTokensUseCase(repository);
});

/// Provider for ClearTokensUseCase
final clearTokensUseCaseProvider = Provider<ClearTokensUseCase>((ref) {
  final repository = ref.read(tokenStorageRepositoryProvider);
  return ClearTokensUseCase(repository);
});
