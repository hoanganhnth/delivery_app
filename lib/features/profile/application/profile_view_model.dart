import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/auth/application/session/auth_notifier.dart';
import 'package:delivery_app/features/auth/application/session/auth_state.dart';
import 'package:delivery_app/features/profile/domain/entities/user_entity.dart';
import 'package:delivery_app/features/profile/application/profile_notifier.dart';
import 'package:delivery_app/features/profile/application/profile_data_state.dart';

import 'profile_effect.dart';
import 'profile_intent.dart';
import 'profile_view_state.dart';

final profileViewModelProvider =
    NotifierProvider<ProfileViewModel, ProfileViewState>(ProfileViewModel.new);

class ProfileViewModel extends Notifier<ProfileViewState> {
  int _nextEffectId = 0;
  String? _lastError;

  @override
  ProfileViewState build() {
    final profile = ref.read(profileProvider);
    ref.listen<ProfileState>(profileProvider, (_, next) {
      _onProfileChanged(next);
    });
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous?.isAuthenticated == true && !next.isAuthenticated) {
        _emit(const ProfileNavigateLogin());
      }
    });
    return _fromProfile(profile);
  }

  Future<void> dispatch(ProfileIntent intent) async {
    switch (intent) {
      case ProfileOrdersRequested():
        _emit(const ProfileNavigateOrders());
      case ProfileAddressesRequested():
        _emit(const ProfileNavigateAddresses());
      case ProfileSettingsRequested():
        _emit(const ProfileNavigateSettings());
      case ProfileVouchersRequested():
        _emit(const ProfileNavigateVouchers());
      case ProfileSupportRequested():
        _emit(const ProfileNavigateSupport());
      case ProfileLivestreamRequested():
        _emit(const ProfileNavigateLivestream());
      case ProfileLogoutRequested():
        await _logout();
      case ProfileRefreshRequested():
        await ref
            .read(profileProvider.notifier)
            .getUserProfile(forceRefresh: true, useCache: false);
      case ProfileEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _logout() async {
    if (state.isLoggingOut) return;
    state = state.copyWith(isLoggingOut: true, clearError: true);
    await ref.read(authProvider.notifier).logout();
    if (!ref.mounted) return;
    state = state.copyWith(isLoggingOut: false);
  }

  void _onProfileChanged(ProfileState next) {
    if (!ref.mounted) return;
    final nextState = _fromProfile(
      next,
      effects: state.effects,
    ).copyWith(isLoggingOut: state.isLoggingOut);
    state = nextState;
    final error = next.errorMessage;
    if (error != null && error != _lastError) {
      _lastError = error;
      _emit(ProfileShowError(error));
    }
    if (error == null) _lastError = null;
  }

  ProfileViewState _fromProfile(
    ProfileState profile, {
    List<UiEffectEnvelope<ProfileEffect>> effects = const [],
  }) {
    final user = profile.user;
    return ProfileViewState(
      data: ProfileViewData(
        displayName: user?.displayName,
        email: user?.email,
        initial: _initial(user),
      ),
      isLoading: profile.isLoading,
      errorMessage: profile.errorMessage,
      effects: effects,
    );
  }

  String? _initial(UserEntity? user) {
    final displayName = user?.displayName;
    final source = displayName != null && displayName.trim().isNotEmpty
        ? displayName.trim()
        : user?.email;
    if (source == null || source.isEmpty) return null;
    return source.substring(0, 1).toUpperCase();
  }

  void _emit(ProfileEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
