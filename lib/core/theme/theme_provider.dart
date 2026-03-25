import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';
import 'app_colors.dart';

part 'theme_provider.g.dart';

/// Theme provider to manage app theme state
@riverpod
class Theme extends _$Theme {
  static const String _themeKey = 'app_theme';

  @override
  AppTheme build() {
    _loadTheme();
    return AppTheme.light;
  }

  /// Load theme from storage
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeTypeString = prefs.getString(_themeKey);
      
      if (themeTypeString != null) {
        final themeType = AppThemeType.values.firstWhere(
          (type) => type.name == themeTypeString,
          orElse: () => AppThemeType.light,
        );
        state = AppTheme.fromType(themeType);
      }
    } catch (e) {
      // If loading fails, keep default light theme
    }
  }

  /// Change theme and save to storage
  Future<void> setTheme(AppThemeType themeType) async {
    state = AppTheme.fromType(themeType);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeType.name);
    } catch (e) {
      // Handle storage error
    }
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
