import 'package:flutter/material.dart';

/// Phone-preview tokens, scoped to Home while other screens are migrated.
abstract final class HomeStyle {
  static const gutter = 12.0;
  static const sectionGap = 8.0;
  static const controlRadius = BorderRadius.all(Radius.circular(4));
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
  static Color accent(BuildContext context) =>
      Theme.of(context).colorScheme.primary;
  static Color muted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFFB0B0B0)
      : const Color(0xFF777777);
  static Color canvas(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFF171717)
      : const Color(0xFFF5F5F5);
}
