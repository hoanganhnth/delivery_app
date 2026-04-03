import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Text styles for the app - Amber Hearth Design System
/// Uses Plus Jakarta Sans with extreme weight variations
class AppTextStyles {
  // Display & Large Headlines - Black/ExtraBold for editorial impact
  static TextStyle get display => TextStyle(
    fontSize: 36.sp, // 2.25rem
    fontWeight: FontWeight.w900, // Black weight
    height: 1.2,
    letterSpacing: -0.02, // Negative spacing for compact feel
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get h1 => TextStyle(
    fontSize: 30.sp, // 1.875rem
    fontWeight: FontWeight.w800, // ExtraBold
    height: 1.25,
    letterSpacing: -0.02,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get h2 => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w800,
    height: 1.3,
    letterSpacing: -0.01,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get h3 => TextStyle(
    fontSize: 20.sp, // 1.25rem
    fontWeight: FontWeight.w700, // Bold for subheadings
    height: 1.4,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get h4 => TextStyle(
    fontSize: 18.sp, // 1.125rem
    fontWeight: FontWeight.w700,
    height: 1.44,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get h5 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.5,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get h6 => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontFamily: 'PlusJakartaSans',
  );

  // Body text - High legibility at 14px (0.875rem)
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.sp, // 0.875rem - primary body size
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.4,
    fontFamily: 'PlusJakartaSans',
  );

  // Labels
  static TextStyle get labelLarge => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.43,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.33,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 10.sp, // Micro-labels for rating stars
    fontWeight: FontWeight.w500,
    height: 1.6,
    fontFamily: 'PlusJakartaSans',
  );

  // Captions
  static TextStyle get caption => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.33,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get overline => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    height: 1.6,
    letterSpacing: 1.2, // Editorial spacing
    fontFamily: 'PlusJakartaSans',
  );

  // Button text styles - Bold for emphasis
  static TextStyle get buttonLarge => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.25,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get buttonMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.43,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get buttonSmall => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.33,
    fontFamily: 'PlusJakartaSans',
  );

  // Input text styles
  static TextStyle get input => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get inputLabel => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.43,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get inputHint => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: 'PlusJakartaSans',
  );

  static TextStyle get inputError => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.33,
    fontFamily: 'PlusJakartaSans',
  );

  // Navigation styles
  static TextStyle get navigationLabel  => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.33.w,
  );

  static TextStyle get tabLabel  => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43.w,
  );

  // Create colored text styles
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  // Create text style with custom font family
  static TextStyle withFontFamily(TextStyle style, String fontFamily) {
    return style.copyWith(fontFamily: fontFamily);
  }
}
