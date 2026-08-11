import 'package:flutter/material.dart';

/// Semantic colors used by UI states and components.
///
/// Feature/domain code must expose a status or intent, not a Flutter Color;
/// the presentation layer resolves that value through this extension.
@immutable
final class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.onSuccess,
    required this.onWarning,
    required this.onInfo,
    required this.surfaceRaised,
  });

  final Color success;
  final Color warning;
  final Color info;
  final Color onSuccess;
  final Color onWarning;
  final Color onInfo;
  final Color surfaceRaised;

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? onSuccess,
    Color? onWarning,
    Color? onInfo,
    Color? surfaceRaised,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      onSuccess: onSuccess ?? this.onSuccess,
      onWarning: onWarning ?? this.onWarning,
      onInfo: onInfo ?? this.onInfo,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      info: Color.lerp(info, other.info, t) ?? info,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      onInfo: Color.lerp(onInfo, other.onInfo, t) ?? onInfo,
      surfaceRaised:
          Color.lerp(surfaceRaised, other.surfaceRaised, t) ?? surfaceRaised,
    );
  }
}

extension AppSemanticColorsContext on BuildContext {
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>() ??
      const AppSemanticColors(
        success: Color(0xFF2E7D32),
        warning: Color(0xFFB26A00),
        info: Color(0xFF1565C0),
        onSuccess: Colors.white,
        onWarning: Colors.white,
        onInfo: Colors.white,
        surfaceRaised: Colors.white,
      );
}
