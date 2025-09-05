import 'package:flutter/material.dart';

/// App spacing constants
class AppSpacing {
  // Base spacing unit
  static const double base = 8.0;

  // Common spacing values
  static const double xs = base * 0.5; // 4
  static const double sm = base; // 8
  static const double md = base * 2; // 16
  static const double lg = base * 3; // 24
  static const double xl = base * 4; // 32
  static const double xxl = base * 5; // 40
  static const double xxxl = base * 6; // 48

  // Specific spacing for common use cases
  static const double cardPadding = md;
  static const double screenPadding = md;
  static const double buttonPadding = md;
  static const double inputPadding = md;
  static const double listItemPadding = md;

  // Margins
  static const double marginXs = xs;
  static const double marginSm = sm;
  static const double marginMd = md;
  static const double marginLg = lg;
  static const double marginXl = xl;

  // Gaps
  static const double gapXs = xs;
  static const double gapSm = sm;
  static const double gapMd = md;
  static const double gapLg = lg;
  static const double gapXl = xl;
}

/// App radius constants
class AppRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double circle = 1000; // For circular shapes

  // Common border radius
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(md));
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius dialogRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius bottomSheetRadius = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );
}

/// App sizes constants
class AppSizes {
  // Icon sizes
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 40;
  static const double iconXxl = 48;

  // Button sizes
  static const double buttonHeightSm = 32;
  static const double buttonHeightMd = 40;
  static const double buttonHeightLg = 48;
  static const double buttonHeightXl = 56;

  // Input sizes
  static const double inputHeight = 48;
  static const double inputHeightSm = 40;
  static const double inputHeightLg = 56;

  // Avatar sizes
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 56;
  static const double avatarXl = 80;

  // Card sizes
  static const double cardElevation = 2;
  static const double cardMaxWidth = 400;

  // App bar
  static const double appBarHeight = 56;
  static const double tabBarHeight = 48;

  // Bottom navigation
  static const double bottomNavHeight = 60;

  // Divider
  static const double dividerThickness = 1;
  static const double dividerThicknessBold = 2;

  // Border
  static const double borderWidth = 1;
  static const double borderWidthBold = 2;
}

/// App durations for animations
class AppDurations {
  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);
  static const Duration extraLong = Duration(milliseconds: 1000);

  // Specific animation durations
  static const Duration buttonPress = short;
  static const Duration pageTransition = medium;
  static const Duration dialogAnimation = medium;
  static const Duration loadingAnimation = long;
  static const Duration snackBar = Duration(milliseconds: 4000);
}
