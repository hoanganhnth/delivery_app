import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_dimensions.dart';
import 'theme_provider.dart';

/// Extension on BuildContext to easily access theme colors
extension ThemeExtension on BuildContext {
  /// Get current app colors
  AppColors get colors {
    return ProviderScope.containerOf(this)
        .read(themeColorsProvider);
  }

  /// Get current theme type
  bool get isDarkTheme {
    return ProviderScope.containerOf(this)
        .read(isDarkThemeProvider);
  }

  /// Get current theme type
  bool get isLightTheme {
    return ProviderScope.containerOf(this)
        .read(isLightThemeProvider);
  }
}

/// Extension on WidgetRef to easily access theme data
extension ThemeRefExtension on WidgetRef {
  /// Get current app colors
  AppColors get colors => watch(themeColorsProvider);
  
  /// Get theme notifier
  ThemeNotifier get themeNotifier => read(themeProvider.notifier);
  
  /// Check if current theme is dark
  bool get isDarkTheme => watch(isDarkThemeProvider);
  
  /// Check if current theme is light
  bool get isLightTheme => watch(isLightThemeProvider);
}

/// Utility class for accessing theme data without context
class AppThemeData {
  // Common text styles with theme colors
  static TextStyle headingLarge(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.h1, colors.textPrimary);

  static TextStyle headingMedium(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.h2, colors.textPrimary);

  static TextStyle headingSmall(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.h3, colors.textPrimary);

  static TextStyle titleLarge(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.h4, colors.textPrimary);

  static TextStyle titleMedium(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.h5, colors.textPrimary);

  static TextStyle titleSmall(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.h6, colors.textPrimary);

  static TextStyle bodyLarge(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.bodyLarge, colors.textPrimary);

  static TextStyle bodyMedium(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.bodyMedium, colors.textPrimary);

  static TextStyle bodySmall(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.bodySmall, colors.textSecondary);

  static TextStyle labelLarge(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.labelLarge, colors.textPrimary);

  static TextStyle labelMedium(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.labelMedium, colors.textSecondary);

  static TextStyle labelSmall(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.labelSmall, colors.textSecondary);

  static TextStyle caption(AppColors colors) =>
      AppTextStyles.withColor(AppTextStyles.caption, colors.textSecondary);

  // Common decorations
  static BoxDecoration cardDecoration(AppColors colors) => BoxDecoration(
        color: colors.cardBackground,
        borderRadius: AppRadius.cardRadius,
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );

  static BoxDecoration inputDecoration(AppColors colors) => BoxDecoration(
        color: colors.inputBackground,
        borderRadius: AppRadius.inputRadius,
        border: Border.all(color: colors.border),
      );

  static BoxDecoration buttonDecoration(AppColors colors) => BoxDecoration(
        color: colors.primary,
        borderRadius: AppRadius.buttonRadius,
      );

  // Common borders
  static Border allBorder(AppColors colors) => Border.all(
        color: colors.border,
        width: AppSizes.borderWidth,
      );

  static Border bottomBorder(AppColors colors) => Border(
        bottom: BorderSide(
          color: colors.divider,
          width: AppSizes.dividerThickness,
        ),
      );

  // Common shadows
  static List<BoxShadow> cardShadow(AppColors colors) => [
        BoxShadow(
          color: colors.shadow,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> buttonShadow(AppColors colors) => [
        BoxShadow(
          color: colors.shadow,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];
}
