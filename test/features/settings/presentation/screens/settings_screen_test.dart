import 'package:delivery_app/core/theme/app_theme.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:delivery_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('dark-mode switch persists through the injected theme port', (
    tester,
  ) async {
    final storage = _FakeThemeStorage();
    await pumpTestApp(
      tester,
      child: const SettingsScreen(),
      overrides: [themeStorageProvider.overrideWithValue(storage)],
    );

    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(storage.writes, [AppThemeType.dark]);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });

  testWidgets('about action opens an observable dialog', (tester) async {
    await pumpTestApp(
      tester,
      child: const SettingsScreen(),
      overrides: [themeStorageProvider.overrideWithValue(_FakeThemeStorage())],
    );

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(find.byType(AboutDialog), findsOneWidget);
    expect(
      find.text('Ứng dụng giao đồ ăn nhanh chóng và tiện lợi.'),
      findsOneWidget,
    );
  });
}

class _FakeThemeStorage implements ThemeStoragePort {
  AppThemeType current = AppThemeType.light;
  final List<AppThemeType> writes = [];

  @override
  AppThemeType? readTheme() => current;

  @override
  Future<void> writeTheme(AppThemeType themeType) async {
    writes.add(themeType);
    current = themeType;
  }
}
