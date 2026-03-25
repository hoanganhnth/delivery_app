import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_state.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:delivery_app/core/usecases/usecase.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() {
    return const ProfileState();
  }

  Future<void> getUserProfile({bool forceRefresh = false, bool useCache = true}) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final params = GetUserProfileParams(
      forceRefresh: forceRefresh,
      useCache: useCache,
    );
    
    final getUserProfileUseCase = ref.read(getUserProfileUseCaseProvider);
    final result = await getUserProfileUseCase(params);
    
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
    
    final updateUserProfileUseCase = ref.read(updateUserProfileUseCaseProvider);
    final result = await updateUserProfileUseCase(params);
    
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
    
    final uploadAvatarUseCase = ref.read(uploadProfileImageUseCaseProvider);
    final result = await uploadAvatarUseCase(
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
    final clearProfileCacheUseCase = ref.read(clearProfileCacheUseCaseProvider);
    final result = await clearProfileCacheUseCase(NoParams());
    
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
