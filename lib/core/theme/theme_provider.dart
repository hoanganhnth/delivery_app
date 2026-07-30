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

class SharedPreferencesThemeStorage implements ThemeStoragePort {
  SharedPreferencesThemeStorage(this._preferences);

  static const themeKey = 'app_theme';
  final SharedPreferences _preferences;

  @override
  AppThemeType? readTheme() {
    final stored = _preferences.getString(themeKey);
    if (stored == null) return null;
    for (final themeType in AppThemeType.values) {
      if (themeType.name == stored) return themeType;
    }
    return null;
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
