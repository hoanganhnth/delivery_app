import 'package:delivery_app/features/profile/domain/usecases/clear_profile_cache_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/usecases/usecase.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final UploadAvatarUseCase _uploadAvatarUseCase;
  final ClearProfileCacheUseCase _clearProfileCacheUseCase;
  

  ProfileNotifier({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateUserProfileUseCase updateUserProfileUseCase,
    required UploadAvatarUseCase uploadAvatarUseCase,
    required ClearProfileCacheUseCase clearProfileCacheUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _updateUserProfileUseCase = updateUserProfileUseCase,
       _uploadAvatarUseCase = uploadAvatarUseCase,
       _clearProfileCacheUseCase = clearProfileCacheUseCase,
       super(const ProfileState());

  Future<void> getUserProfile({bool forceRefresh = false, bool useCache = true}) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final params = GetUserProfileParams(
      forceRefresh: forceRefresh,
      useCache: useCache,
    );
    final result = await _getUserProfileUseCase(params);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, failure: failure);
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
      },
    );
  }

  Future<void> updateUserProfile({
    required String name,
    String? phone,
    String? address,
  }) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final params = UpdateUserProfileParams(
      user: state.user!.copyWith(
        fullName: name,
        phone: phone ?? state.user!.phone,
        address: address ?? state.user!.address,
      ),
    );
    final result = await _updateUserProfileUseCase(params);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, failure: failure);
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user);
      },
    );
  }

  Future<void> uploadAvatar(String filePath) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _uploadAvatarUseCase(
      UploadAvatarParams(imagePath: filePath),
    );
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, failure: failure);
      },
      (avatarUrl) {
        final updatedUser = state.user!.copyWith(avatarUrl: avatarUrl);
        state = state.copyWith(isLoading: false, user: updatedUser);
      },
    );
  }

  Future<void> clearProfileCache() async {
    final result = await _clearProfileCacheUseCase(NoParams());
    result.fold(
      (failure) {
        // Log error but don't change state
      },
      (_) {
        // Cache cleared successfully, reset profile state
        state = state.copyWith(clearUser: true);
      },
    );
  }

 
}
