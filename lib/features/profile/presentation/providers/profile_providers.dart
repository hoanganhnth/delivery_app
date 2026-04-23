import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:delivery_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:delivery_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:delivery_app/features/profile/domain/usecases/clear_profile_cache_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_providers.g.dart';

@Riverpod(keepAlive: true)
ProfileApiService profileApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return ProfileApiService(dio);
}

@Riverpod(keepAlive: true)
ProfileRemoteDataSource profileRemoteDataSource(Ref ref) {
  final apiService = ref.watch(profileApiServiceProvider);
  return ProfileRemoteDataSourceImpl(apiService);
}

@Riverpod(keepAlive: true)
ProfileLocalDataSource profileLocalDataSource(Ref ref) {
  return ProfileLocalDataSourceImpl();
}

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  final remoteDataSource = ref.watch(profileRemoteDataSourceProvider);
  final localDataSource = ref.watch(profileLocalDataSourceProvider);
  return ProfileRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
}

@Riverpod(keepAlive: true)
GetUserProfileUseCase getUserProfileUseCase(Ref ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetUserProfileUseCase(repository);
}

@Riverpod(keepAlive: true)
UpdateUserProfileUseCase updateUserProfileUseCase(Ref ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpdateUserProfileUseCase(repository);
}

@Riverpod(keepAlive: true)
UploadAvatarUseCase uploadAvatarUseCase(Ref ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UploadAvatarUseCase(repository);
}

@Riverpod(keepAlive: true)
ClearProfileCacheUseCase clearProfileCacheUseCase(Ref ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ClearProfileCacheUseCase(repository);
}
