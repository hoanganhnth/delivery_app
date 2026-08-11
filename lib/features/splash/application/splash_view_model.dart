import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/services/app_initializer/_riverpod/app_initializer_provider.dart';
import 'package:delivery_app/features/auth/application/session/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'splash_effect.dart';
import 'splash_delay.dart';
import 'splash_intent.dart';
import 'splash_state.dart';

final splashViewModelProvider =
    NotifierProvider<SplashViewModel, SplashViewState>(SplashViewModel.new);

class SplashViewModel extends Notifier<SplashViewState> {
  int _nextEffectId = 0;
  bool _isInitializing = false;

  @override
  SplashViewState build() => const SplashViewState();

  Future<void> dispatch(SplashIntent intent) async {
    switch (intent) {
      case SplashStartRequested() || SplashRetryRequested():
        await _initialize();
      case SplashEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _initialize() async {
    if (_isInitializing) return;
    _isInitializing = true;
    state = state.copyWith(phase: SplashPhase.initializing);
    try {
      await ref.read(splashDelayProvider).wait(const Duration(seconds: 2));
      if (!ref.mounted) return;
      state = state.copyWith(phase: SplashPhase.checkingAuth);
      await ref.read(appInitializerServiceProvider).initialize();
      if (!ref.mounted) return;
      state = state.copyWith(phase: SplashPhase.navigating);
      _emit(
        ref.read(authProvider).isAuthenticated
            ? const SplashNavigateToMain()
            : const SplashNavigateToLogin(),
      );
    } catch (_) {
      if (ref.mounted) {
        state = state.copyWith(phase: SplashPhase.error);
        _emit(const SplashNavigateToLogin());
      }
    } finally {
      _isInitializing = false;
    }
  }

  void _emit(SplashEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
