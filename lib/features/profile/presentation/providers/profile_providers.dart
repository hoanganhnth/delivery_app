import 'package:delivery_app/core/network/authenticated_network_providers.dart';
// import 'package:delivery_app/core/network/network_providers.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:delivery_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:delivery_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:delivery_app/features/profile/domain/usecases/clear_profile_cache_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileApiServiceProvider = Provider<ProfileApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return ProfileApiService(dio);
});

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  final apiService = ref.watch(profileApiServiceProvider);
  return ProfileRemoteDataSourceImpl(apiService);
});
final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  // Implement and return your local data source here
  return ProfileLocalDataSourceImpl();
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDataSource = ref.watch(profileRemoteDataSourceProvider);
  final localDataSource = ref.watch(profileLocalDataSourceProvider);
  return ProfileRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
});

final getUserProfileUseCaseProvider = Provider<GetUserProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetUserProfileUseCase(repository);
});

final updateuserProfileUseCaseProvider = Provider<UpdateUserProfileUseCase>((
  ref,
) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpdateUserProfileUseCase(repository);
});

final uploadProfileImageUseCaseProvider = Provider<UploadAvatarUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UploadAvatarUseCase(repository);
});

final clearProfileCacheUseCaseProvider = Provider<ClearProfileCacheUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ClearProfileCacheUseCase(repository);
});

final profileStateProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>(
      (ref) {
        final getUserProfileUseCase = ref.watch(getUserProfileUseCaseProvider);
        final updateUserProfileUseCase = ref.watch(
          updateuserProfileUseCaseProvider,
        );
        final uploadAvatarUseCase = ref.watch(
          uploadProfileImageUseCaseProvider,
        );
        final clearProfileCacheUseCase = ref.watch(
          clearProfileCacheUseCaseProvider,
        );
        return ProfileNotifier(
          getUserProfileUseCase: getUserProfileUseCase,
          updateUserProfileUseCase: updateUserProfileUseCase,
          uploadAvatarUseCase: uploadAvatarUseCase,
          clearProfileCacheUseCase: clearProfileCacheUseCase,
        );
      },
      // dependencies: [
      //   authenticatedDioProvider,
      //   profileApiServiceProvider,
      //   profileRemoteDataSourceProvider,
      //   profileRepositoryProvider,
      //   getUserProfileUseCaseProvider,
      //   updateuserProfileUseCaseProvider,
      //   uploadProfileImageUseCaseProvider,
      // ],
    );
