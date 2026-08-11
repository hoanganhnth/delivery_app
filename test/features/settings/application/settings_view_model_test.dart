import 'package:delivery_app/core/theme/app_theme.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:delivery_app/features/settings/application/settings_effect.dart';
import 'package:delivery_app/features/settings/application/settings_intent.dart';
import 'package:delivery_app/features/settings/application/settings_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingsViewModel', () {
    test('turns a user intent into persisted theme state', () async {
      final storage = _FakeThemeStorage();
      final container = ProviderContainer(
        overrides: [themeStorageProvider.overrideWithValue(storage)],
      );
      addTearDown(container.dispose);

      expect(container.read(settingsViewModelProvider).isDarkMode, isFalse);

      await container
          .read(settingsViewModelProvider.notifier)
          .dispatch(const SettingsThemeToggled());

      expect(storage.writes, [AppThemeType.dark]);
      expect(container.read(settingsViewModelProvider).isDarkMode, isTrue);
    });

    test('queues and acknowledges one-shot effects', () async {
      final container = ProviderContainer(
        overrides: [
          themeStorageProvider.overrideWithValue(_FakeThemeStorage()),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(settingsViewModelProvider.notifier);

      await notifier.dispatch(const SettingsAboutRequested());
      final effect = container.read(settingsViewModelProvider).effects.single;
      expect(effect.effect, isA<SettingsShowAbout>());

      await notifier.dispatch(SettingsEffectConsumed(effect.id));
      expect(container.read(settingsViewModelProvider).effects, isEmpty);
    });
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
