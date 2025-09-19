import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_dimensions.dart';

enum AppThemeType {
  light,
  dark,
  ocean,
  // Có thể thêm nhiều theme khác ở đây
}

/// Main app theme class
class AppTheme {
  final AppThemeType type;
  final AppColors colors;

  const AppTheme({required this.type, required this.colors});

  /// Get the theme name for display
  String get name {
    switch (type) {
      case AppThemeType.light:
        return 'light';
      case AppThemeType.dark:
        return 'dark';
      case AppThemeType.ocean:
        return 'ocean';
    }
  }

  /// Get theme data for Material Design
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: _getBrightness(),

      // Color scheme
      colorScheme: ColorScheme(
        brightness: _getBrightness(),
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        error: colors.error,
        onError: colors.onPrimary,
        // surface: colors.background,
        // onBackground: colors.onBackground,
        surface: colors.surface,
        onSurface: colors.onSurface,
      ),

      // Scaffold
      scaffoldBackgroundColor: colors.background,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
        titleTextStyle: AppTextStyles.withColor(
          AppTextStyles.h6,
          colors.textPrimary,
        ),
        toolbarHeight: AppSizes.appBarHeight,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: colors.cardBackground,
        elevation: AppSizes.cardElevation,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.buttonDisabled,
          disabledForegroundColor: colors.textDisabled,
          elevation: 2,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          minimumSize: const Size(0, AppSizes.buttonHeightMd),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          disabledForegroundColor: colors.textDisabled,
          side: BorderSide(color: colors.primary),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          minimumSize: const Size(0, AppSizes.buttonHeightMd),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          disabledForegroundColor: colors.textDisabled,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          minimumSize: const Size(0, AppSizes.buttonHeightMd),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.buttonRadius,
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colors.inputBackground,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: colors.primary, width: 2.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: BorderSide(color: colors.error, width: 2.w),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        labelStyle: AppTextStyles.withColor(
          AppTextStyles.inputLabel,
          colors.textSecondary,
        ),
        hintStyle: AppTextStyles.withColor(
          AppTextStyles.inputHint,
          colors.textDisabled,
        ),
        errorStyle: AppTextStyles.withColor(
          AppTextStyles.inputError,
          colors.error,
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.withColor(
          AppTextStyles.h1,
          colors.textPrimary,
        ),
        displayMedium: AppTextStyles.withColor(
          AppTextStyles.h2,
          colors.textPrimary,
        ),
        displaySmall: AppTextStyles.withColor(
          AppTextStyles.h3,
          colors.textPrimary,
        ),
        headlineLarge: AppTextStyles.withColor(
          AppTextStyles.h4,
          colors.textPrimary,
        ),
        headlineMedium: AppTextStyles.withColor(
          AppTextStyles.h5,
          colors.textPrimary,
        ),
        headlineSmall: AppTextStyles.withColor(
          AppTextStyles.h6,
          colors.textPrimary,
        ),
        titleLarge: AppTextStyles.withColor(
          AppTextStyles.h6,
          colors.textPrimary,
        ),
        titleMedium: AppTextStyles.withColor(
          AppTextStyles.labelLarge,
          colors.textPrimary,
        ),
        titleSmall: AppTextStyles.withColor(
          AppTextStyles.labelMedium,
          colors.textPrimary,
        ),
        bodyLarge: AppTextStyles.withColor(
          AppTextStyles.bodyLarge,
          colors.textPrimary,
        ),
        bodyMedium: AppTextStyles.withColor(
          AppTextStyles.bodyMedium,
          colors.textPrimary,
        ),
        bodySmall: AppTextStyles.withColor(
          AppTextStyles.bodySmall,
          colors.textSecondary,
        ),
        labelLarge: AppTextStyles.withColor(
          AppTextStyles.labelLarge,
          colors.textPrimary,
        ),
        labelMedium: AppTextStyles.withColor(
          AppTextStyles.labelMedium,
          colors.textSecondary,
        ),
        labelSmall: AppTextStyles.withColor(
          AppTextStyles.labelSmall,
          colors.textSecondary,
        ),
      ),

      // Bottom navigation theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: AppTextStyles.navigationLabel,
        unselectedLabelStyle: AppTextStyles.navigationLabel,
      ),

      // Tab bar theme
      tabBarTheme: TabBarThemeData(
        labelColor: colors.primary,
        unselectedLabelColor: colors.textSecondary,
        labelStyle: AppTextStyles.tabLabel,
        unselectedLabelStyle: AppTextStyles.tabLabel,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colors.primary, width: 2.w),
        ),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: AppSizes.dividerThickness,
        space: AppSizes.dividerThickness,
      ),

      // Icon theme
      iconTheme: IconThemeData(
        color: colors.textPrimary,
        size: AppSizes.iconMd,
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary.withValues(alpha: 0.5);
          }
          return colors.textDisabled;
        }),
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.surface;
        }),
        checkColor: WidgetStateProperty.all(colors.onPrimary),
      ),

      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.textSecondary;
        }),
      ),

      // Snack bar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surface,
        contentTextStyle: AppTextStyles.withColor(
          AppTextStyles.bodyMedium,
          colors.onSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        titleTextStyle: AppTextStyles.withColor(
          AppTextStyles.h6,
          colors.textPrimary,
        ),
        contentTextStyle: AppTextStyles.withColor(
          AppTextStyles.bodyMedium,
          colors.textPrimary,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.dialogRadius,
        ),
      ),
    );
  }

  Brightness _getBrightness() {
    return colors.brightness;
  }

  /// Predefined themes
  static final AppTheme light = AppTheme(
    type: AppThemeType.light,
    colors: LightColors(),
  );

  static final AppTheme dark = AppTheme(
    type: AppThemeType.dark,
    colors: DarkColors(),
  );

  static final AppTheme ocean = AppTheme(
    type: AppThemeType.ocean,
    colors: OceanColors(),
  );

  /// Get theme by type
  static AppTheme fromType(AppThemeType type) {
    switch (type) {
      case AppThemeType.light:
        return light;
      case AppThemeType.dark:
        return dark;
      case AppThemeType.ocean:
        return ocean;
    }
  }

  /// Get all available themes
  static List<AppTheme> get allThemes => [light, dark, ocean];

  /// Get all available themes as a map with names as keys
  static Map<String, AppTheme> get availableThemes => {
    'light': light,
    'dark': dark,
    'ocean': ocean,
  };

  /// Get theme names for UI
  static Map<AppThemeType, String> get themeNames => {
    AppThemeType.light: 'Light',
    AppThemeType.dark: 'Dark',
    AppThemeType.ocean: 'Ocean',
  };
}
