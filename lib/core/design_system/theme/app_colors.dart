import 'package:flutter/material.dart';

/// Base color scheme interface
abstract class AppColors {
  // Primary colors
  Color get primary;
  Color get primaryLight;
  Color get primaryDark;
  Color get onPrimary;

  // Secondary colors
  Color get secondary;
  Color get secondaryLight;
  Color get secondaryDark;
  Color get onSecondary;

  // Surface colors
  Color get background;
  Color get surface;
  Color get onBackground;
  Color get onSurface;

  // Text colors
  Color get textPrimary;
  Color get textSecondary;
  Color get textDisabled;

  // Status colors
  Color get success;
  Color get error;
  Color get warning;
  Color get info;

  // Border and divider colors
  Color get border;
  Color get divider;

  // Additional Material 3 colors
  Color get outline;
  Color get onSurfaceVariant;

  // Specific component colors
  Color get cardBackground;
  Color get inputBackground;
  Color get buttonDisabled;
  Color get shadow;

  // Brightness for theme detection
  Brightness get brightness;
}

/// Light theme colors - Amber Hearth Design System
class LightColors implements AppColors {
  @override
  Color get primary => const Color(0xFFEE4D2D);

  @override
  Color get primaryLight => const Color(0xFFFF8066);

  @override
  Color get primaryDark => const Color(0xFFB93820);

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get secondary => const Color(0xFF9c7a49); // Muted Umber - sophisticated anchor

  @override
  Color get secondaryLight => const Color(0xFFb89764);

  @override
  Color get secondaryDark => const Color(0xFF7d6038);

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get background => const Color(0xFFF5F5F5);

  @override
  Color get surface => Colors.white; // Pure white for maximum content clarity

  @override
  Color get onBackground => const Color(0xFF212121);

  @override
  Color get onSurface => const Color(0xFF212121);

  @override
  Color get textPrimary => const Color(0xFF212121);

  @override
  Color get textSecondary => const Color(0xFF666666);

  @override
  Color get textDisabled => const Color(0xFFc9b89a); // Warm disabled state

  @override
  Color get success => const Color(0xFF4CAF50);

  @override
  Color get error => const Color(0xFFF44336);

  @override
  Color get warning => const Color(0xFFFF9800);

  @override
  Color get info => const Color(0xFF2196F3);

  @override
  Color get border => const Color(0xFFEEEEEE);

  @override
  Color get divider => border;

  @override
  Color get cardBackground => Colors.white; // Surface Lowest: Pure white

  @override
  Color get inputBackground => Colors.white;

  @override
  Color get buttonDisabled => const Color(0xFFc9b89a); // Warm disabled state

  @override
  Color get shadow => const Color(0xFF9c7a49).withValues(alpha: 0.08); // Amber-tinted shadow

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get outline => border;

  @override
  Color get onSurfaceVariant => textSecondary;
}

/// Dark theme colors
class DarkColors implements AppColors {
  @override
  Color get primary => const Color(0xFFFF8066);

  @override
  Color get primaryLight => const Color(0xFFBBDEFB);

  @override
  Color get primaryDark => const Color(0xFF42A5F5);

  @override
  Color get onPrimary => Colors.black;

  @override
  Color get secondary => const Color(0xFF4FE8D7);

  @override
  Color get secondaryLight => const Color(0xFF80E8D4);

  @override
  Color get secondaryDark => const Color(0xFF00B8A4);

  @override
  Color get onSecondary => Colors.black;

  @override
  Color get background => const Color(0xFF121212);

  @override
  Color get surface => const Color(0xFF1E1E1E);

  @override
  Color get onBackground => Colors.white;

  @override
  Color get onSurface => Colors.white;

  @override
  Color get textPrimary => const Color(0xFFFFFFFF);

  @override
  Color get textSecondary => const Color(0xFFB0B0B0);

  @override
  Color get textDisabled => const Color(0xFF666666);

  @override
  Color get success => const Color(0xFF66BB6A);

  @override
  Color get error => const Color(0xFFEF5350);

  @override
  Color get warning => const Color(0xFFFFB74D);

  @override
  Color get info => const Color(0xFF42A5F5);

  @override
  Color get border => const Color(0xFF333333);

  @override
  Color get divider => const Color(0xFF333333);

  @override
  Color get cardBackground => const Color(0xFF2C2C2C);

  @override
  Color get inputBackground => const Color(0xFF2C2C2C);

  @override
  Color get buttonDisabled => const Color(0xFF444444);

  @override
  Color get shadow => Colors.black.withValues(alpha: 0.3);

  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get outline => border;

  @override
  Color get onSurfaceVariant => textSecondary;
}
