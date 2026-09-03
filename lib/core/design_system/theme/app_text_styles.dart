import 'package:flutter/material.dart';

/// Text styles for the app - Amber Hearth Design System
///
/// Plus Jakarta Sans is bundled under the SIL Open Font License. Platform
/// sans-serif fonts remain fallbacks for glyphs outside the bundled family.
class AppTextStyles {
  static const String fontFamily = 'Plus Jakarta Sans';
  static const List<String> fontFamilyFallback = <String>[
    'Arial',
    'sans-serif',
  ];

  // Display & Large Headlines - Black/ExtraBold for editorial impact
  static TextStyle get display => TextStyle(
    fontSize: 36, // logical pixels
    fontWeight: FontWeight.w800, // Highest weight supplied by the family
    height: 1.2,
    letterSpacing: -0.02, // Negative spacing for compact feel
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get h1 => TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w800, // ExtraBold
    height: 1.25,
    letterSpacing: -0.02,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get h2 => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 1.3,
    letterSpacing: -0.01,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get h3 => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700, // Bold for subheadings
    height: 1.4,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get h4 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.44,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get h5 => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.5,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get h6 => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  // Body text - High legibility at 14px (0.875rem)
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get bodySmall => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  // Labels
  static TextStyle get labelLarge => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get labelMedium => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get labelSmall => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.6,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  // Captions
  static TextStyle get caption => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.33,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get overline => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1.6,
    letterSpacing: 1.2, // Editorial spacing
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  // Button text styles - Bold for emphasis
  static TextStyle get buttonLarge => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.25,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get buttonMedium => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.43,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get buttonSmall => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  // Input text styles
  static TextStyle get input => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get inputLabel => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get inputHint => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get inputError => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.33,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  // Navigation styles
  static TextStyle get navigationLabel => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
  );

  static TextStyle get tabLabel => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    fontFamily: fontFamily,
    fontFamilyFallback: fontFamilyFallback,
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
