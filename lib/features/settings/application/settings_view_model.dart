import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';

import 'settings_effect.dart';
import 'settings_intent.dart';
import 'settings_state.dart';

final settingsViewModelProvider =
    NotifierProvider<SettingsViewModel, SettingsViewState>(
      SettingsViewModel.new,
    );

/// Coordinates settings actions without exposing UI/platform concerns to the
/// presentational view.
class SettingsViewModel extends Notifier<SettingsViewState> {
  int _nextEffectId = 0;

  @override
  SettingsViewState build() {
    final isDark = ref.read(isDarkThemeProvider);
    ref.listen<bool>(isDarkThemeProvider, (_, next) {
      if (!ref.mounted) return;
      state = state.copyWith(isDarkMode: next);
    });
    return SettingsViewState(isDarkMode: isDark);
  }

  Future<void> dispatch(SettingsIntent intent) async {
    switch (intent) {
      case SettingsThemeToggled():
        await _toggleTheme();
      case SettingsAboutRequested():
        _emit(const SettingsShowAbout());
      case SettingsSupportRequested():
        _emit(const SettingsOpenSupport());
      case SettingsDebugToolsRequested():
        _emit(const SettingsOpenDebugTools());
      case SettingsEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _toggleTheme() async {
    if (state.isThemeUpdating) return;

    state = state.copyWith(themeOperation: UiOperationStatus.running);
    try {
      await ref.read(themeProvider.notifier).toggleTheme();
      if (!ref.mounted) return;
      state = state.copyWith(
        isDarkMode: ref.read(isDarkThemeProvider),
        themeOperation: UiOperationStatus.succeeded,
      );
    } catch (_) {
      if (!ref.mounted) return;
      state = state.copyWith(themeOperation: UiOperationStatus.failed);
    }
  }

  void _emit(SettingsEffect effect) {
    final envelope = UiEffectEnvelope(id: _nextEffectId++, effect: effect);
    state = state.copyWith(effects: [...state.effects, envelope]);
  }
}

void dispatchSettingsIntent(WidgetRef ref, SettingsIntent intent) {
  unawaited(ref.read(settingsViewModelProvider.notifier).dispatch(intent));
}
