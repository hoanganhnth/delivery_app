import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:delivery_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;
  final UploadAvatarUseCase _uploadAvatarUseCase;

  ProfileNotifier({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateUserProfileUseCase updateUserProfileUseCase,
    required UploadAvatarUseCase uploadAvatarUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _updateUserProfileUseCase = updateUserProfileUseCase,
       _uploadAvatarUseCase = uploadAvatarUseCase,
       super(const ProfileState());

  Future<void> getUserProfile() async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _getUserProfileUseCase(NoParams());
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

 
}
