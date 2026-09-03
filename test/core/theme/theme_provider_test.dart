import 'package:delivery_app/core/design_system/design_system.dart' as design;
import 'package:delivery_app/core/theme/app_theme.dart' as compatibility;
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test(
    'theme starts from injected storage without an async light-theme flash',
    () {
      final storage = _FakeThemeStorage(initial: design.AppThemeType.dark);
      final container = ProviderContainer(
        overrides: [themeStorageProvider.overrideWithValue(storage)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(themeProvider, (_, _) {});
      addTearDown(subscription.close);

      expect(container.read(themeProvider).type, design.AppThemeType.dark);
    },
  );

  test(
    'theme toggle updates observable state and persists through the port',
    () async {
      final storage = _FakeThemeStorage(initial: design.AppThemeType.light);
      final container = ProviderContainer(
        overrides: [themeStorageProvider.overrideWithValue(storage)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(themeProvider, (_, _) {});
      addTearDown(subscription.close);

      await container.read(themeProvider.notifier).toggleTheme();

      expect(container.read(themeProvider).type, design.AppThemeType.dark);
      expect(storage.writes, [design.AppThemeType.dark]);
    },
  );

  test('storage failure does not roll visible theme state back', () async {
    final storage = _FakeThemeStorage(
      initial: design.AppThemeType.light,
      failWrites: true,
    );
    final container = ProviderContainer(
      overrides: [themeStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(themeProvider, (_, _) {});
    addTearDown(subscription.close);

    await container
        .read(themeProvider.notifier)
        .setTheme(design.AppThemeType.dark);

    expect(container.read(themeProvider).type, design.AppThemeType.dark);
    expect(storage.writes, [design.AppThemeType.dark]);
  });

  test('legacy core/theme exports resolve to the canonical design system', () {
    expect(compatibility.AppTheme.light, same(design.AppTheme.light));
    expect(compatibility.AppThemeType.light, design.AppThemeType.light);
  });

  test('theme construction exposes only light and dark choices', () {
    expect(design.AppTheme.allThemes.map((theme) => theme.type), [
      design.AppThemeType.light,
      design.AppThemeType.dark,
    ]);
    expect(design.AppTheme.availableThemes.keys, ['light', 'dark']);
  });

  test('canonical typography uses logical pixels without ScreenUtil', () {
    expect(design.AppTextStyles.h1.fontSize, 30);
    expect(design.AppTextStyles.h1.fontFamily, 'Plus Jakarta Sans');
    expect(design.AppTextStyles.navigationLabel.height, 1.33);
  });

  test('stored ocean preference migrates and persists light', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesThemeStorage.themeKey: 'ocean',
    });
    final preferences = await SharedPreferences.getInstance();
    final storage = SharedPreferencesThemeStorage(preferences);

    expect(storage.readTheme(), design.AppThemeType.light);
    await storage.migrationComplete;
    expect(
      preferences.getString(SharedPreferencesThemeStorage.themeKey),
      'light',
    );
  });

  test('failed ocean rewrite stays light without an unhandled error', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesThemeStorage.themeKey: 'ocean',
    });
    final preferences = await SharedPreferences.getInstance();
    var writes = 0;
    final storage = SharedPreferencesThemeStorage(
      preferences,
      writePreference: (_, _) {
        writes++;
        return Future<bool>.error(StateError('disk unavailable'));
      },
    );

    expect(storage.readTheme(), design.AppThemeType.light);
    await storage.migrationComplete;
    expect(storage.readTheme(), design.AppThemeType.light);
    await storage.migrationComplete;
    expect(writes, 2);
  });
}

class _FakeThemeStorage implements ThemeStoragePort {
  _FakeThemeStorage({this.initial, this.failWrites = false});

  design.AppThemeType? initial;
  final bool failWrites;
  final List<design.AppThemeType> writes = [];

  @override
  design.AppThemeType? readTheme() => initial;

  @override
  Future<void> writeTheme(design.AppThemeType themeType) async {
    writes.add(themeType);
    if (failWrites) throw StateError('storage unavailable');
    initial = themeType;
  }
}
