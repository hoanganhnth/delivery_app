import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';
import 'app_colors.dart';

part 'theme_provider.g.dart';

abstract interface class ThemeStoragePort {
  AppThemeType? readTheme();
  Future<void> writeTheme(AppThemeType themeType);
}

typedef ThemePreferenceWriter = Future<bool> Function(String key, String value);

class SharedPreferencesThemeStorage implements ThemeStoragePort {
  SharedPreferencesThemeStorage(
    SharedPreferences preferences, {
    ThemePreferenceWriter? writePreference,
  }) : _preferences = preferences,
       _writePreference = writePreference ?? preferences.setString;

  static const themeKey = 'app_theme';
  final SharedPreferences _preferences;
  final ThemePreferenceWriter _writePreference;
  Future<void> _migrationComplete = Future<void>.value();

  /// Completes after the latest legacy preference rewrite has settled.
  ///
  /// Callers do not need to await this for a safe visible theme: an `ocean`
  /// value always reads as Light. Tests and lifecycle owners may await it when
  /// they need persistence completion as an observable boundary.
  Future<void> get migrationComplete => _migrationComplete;

  @override
  AppThemeType? readTheme() {
    final stored = _preferences.getString(themeKey);
    if (stored == null) return null;

    // Ocean was removed from the customer theme set. Normalize the legacy
    // persisted value immediately so subsequent launches read canonical data.
    if (stored == 'ocean') {
      _migrationComplete = _persistCanonicalLight();
      unawaited(_migrationComplete);
      return AppThemeType.light;
    }

    for (final themeType in AppThemeType.values) {
      if (themeType.name == stored) return themeType;
    }
    return null;
  }

  Future<void> _persistCanonicalLight() async {
    try {
      await _writePreference(themeKey, AppThemeType.light.name);
    } catch (_) {
      // Persistence can fail independently of the visible theme. Future reads
      // still normalize `ocean` to Light and retry the canonical rewrite.
    }
  }

  @override
  Future<void> writeTheme(AppThemeType themeType) async {
    await _preferences.setString(themeKey, themeType.name);
  }
}

class MemoryThemeStorage implements ThemeStoragePort {
  AppThemeType? _themeType;

  @override
  AppThemeType? readTheme() => _themeType;

  @override
  Future<void> writeTheme(AppThemeType themeType) async {
    _themeType = themeType;
  }
}

/// Safe test/preview default. Production replaces this at the application
/// composition root with [SharedPreferencesThemeStorage].
final themeStorageProvider = Provider<ThemeStoragePort>(
  (ref) => MemoryThemeStorage(),
);

/// Theme provider to manage app theme state
@riverpod
class Theme extends _$Theme {
  @override
  AppTheme build() {
    final storedTheme = ref.watch(themeStorageProvider).readTheme();
    return storedTheme == null
        ? AppTheme.light
        : AppTheme.fromType(storedTheme);
  }

  /// Change theme and save to storage
  Future<void> setTheme(AppThemeType themeType) async {
    state = AppTheme.fromType(themeType);

    try {
      await ref.read(themeStorageProvider).writeTheme(themeType);
    } catch (_) {}
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final newThemeType = state.type == AppThemeType.light
        ? AppThemeType.dark
        : AppThemeType.light;
    await setTheme(newThemeType);
  }

  /// Get current theme type
  AppThemeType get currentThemeType => state.type;

  /// Check if current theme is dark
  bool get isDarkTheme => state.type == AppThemeType.dark;

  /// Check if current theme is light
  bool get isLightTheme => state.type == AppThemeType.light;
}

/// Convenience providers for accessing theme data
@riverpod
AppColors themeColors(Ref ref) {
  return ref.watch(themeProvider).colors;
}

@riverpod
AppThemeType themeType(Ref ref) {
  return ref.watch(themeProvider).type;
}

@riverpod
bool isDarkTheme(Ref ref) {
  return ref.watch(themeProvider).type == AppThemeType.dark;
}

@riverpod
bool isLightTheme(Ref ref) {
  return ref.watch(themeProvider).type == AppThemeType.light;
}
