import 'package:delivery_app/core/design_system/design_system.dart' as design;
import 'package:delivery_app/core/theme/theme.dart' as legacy;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('legacy theme barrel preserves its public tokens and values', () {
    expect(legacy.AppSpacing.xs, 4);
    expect(legacy.AppSpacing.sm, 8);
    expect(legacy.AppSpacing.md, 16);
    expect(legacy.AppSpacing.cardPadding, 16);
    expect(legacy.AppSpacing.marginXl, 32);
    expect(legacy.AppSpacing.gapLg, 24);
    expect(legacy.AppRadius.cardRadius, isNotNull);
    expect(legacy.AppSizes.buttonHeightMd, 40);
    expect(legacy.AppDurations.medium, const Duration(milliseconds: 300));
  });

  test('legacy theme classes resolve to canonical implementations', () {
    expect(legacy.AppTheme.light, same(design.AppTheme.light));
    expect(legacy.AppTextStyles.h1, design.AppTextStyles.h1);
  });

  test('new design-system imports keep the new spacing scale', () {
    expect(design.AppSpacing.xs, 8);
    expect(design.AppSpacing.sm, 12);
    expect(design.AppSpacing.md, 16);
  });
}
