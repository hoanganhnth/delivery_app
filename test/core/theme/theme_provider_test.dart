import 'package:delivery_app/core/theme/app_theme.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'theme starts from injected storage without an async light-theme flash',
    () {
      final storage = _FakeThemeStorage(initial: AppThemeType.dark);
      final container = ProviderContainer(
        overrides: [themeStorageProvider.overrideWithValue(storage)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(themeProvider, (_, _) {});
      addTearDown(subscription.close);

      expect(container.read(themeProvider).type, AppThemeType.dark);
    },
  );

  test(
    'theme toggle updates observable state and persists through the port',
    () async {
      final storage = _FakeThemeStorage(initial: AppThemeType.light);
      final container = ProviderContainer(
        overrides: [themeStorageProvider.overrideWithValue(storage)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(themeProvider, (_, _) {});
      addTearDown(subscription.close);

      await container.read(themeProvider.notifier).toggleTheme();

      expect(container.read(themeProvider).type, AppThemeType.dark);
      expect(storage.writes, [AppThemeType.dark]);
    },
  );

  test('storage failure does not roll visible theme state back', () async {
    final storage = _FakeThemeStorage(
      initial: AppThemeType.light,
      failWrites: true,
    );
    final container = ProviderContainer(
      overrides: [themeStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(themeProvider, (_, _) {});
    addTearDown(subscription.close);

    await container.read(themeProvider.notifier).setTheme(AppThemeType.ocean);

    expect(container.read(themeProvider).type, AppThemeType.ocean);
    expect(storage.writes, [AppThemeType.ocean]);
  });
}

class _FakeThemeStorage implements ThemeStoragePort {
  _FakeThemeStorage({this.initial, this.failWrites = false});

  AppThemeType? initial;
  final bool failWrites;
  final List<AppThemeType> writes = [];

  @override
  AppThemeType? readTheme() => initial;

  @override
  Future<void> writeTheme(AppThemeType themeType) async {
    writes.add(themeType);
    if (failWrites) throw StateError('storage unavailable');
    initial = themeType;
  }
}
