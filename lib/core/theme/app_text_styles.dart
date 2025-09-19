import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Text styles for the app
class AppTextStyles {
  // Headings
  static TextStyle get h1  => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    height: 1.25.w,
  );

  static TextStyle get h2  => TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    height: 1.29.w,
  );

  static TextStyle get h3  => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.33.w,
  );

  static TextStyle get h4  => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.4.w,
  );

  static TextStyle get h5  => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.44.w,
  );

  static TextStyle get h6  => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.5.w,
  );

  // Body text
  static TextStyle get bodyLarge  => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5.w,
  );

  static TextStyle get bodyMedium  => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 1.43.w,
  );

  static TextStyle get bodySmall  => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.33.w,
  );

  // Labels
  static TextStyle get labelLarge  => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43.w,
  );

  static TextStyle get labelMedium  => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.33.w,
  );

  static TextStyle get labelSmall  => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.45.w,
  );

  // Captions
  static TextStyle get caption  => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.33.w,
  );

  static TextStyle get overline  => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    height: 1.6.w,
    letterSpacing: 1.5,
  );

  // Button text styles
  static TextStyle get buttonLarge  => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.25.w,
  );

  static TextStyle get buttonMedium  => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.43.w,
  );

  static TextStyle get buttonSmall  => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.33.w,
  );

  // Input text styles
  static TextStyle get input  => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5.w,
  );

  static TextStyle get inputLabel  => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43.w,
  );

  static TextStyle get inputHint  => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5.w,
  );

  static TextStyle get inputError  => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.33.w,
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
