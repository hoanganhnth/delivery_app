import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart'
    as core_net;
import 'package:delivery_app/features/auth/presentation/providers/di/auth_network_providers.dart'
    as auth_net;
import 'package:delivery_app/features/auth/presentation/providers/di/storage_di_providers.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:shared_preferences/shared_preferences.dart';

/// Production composition root for dependencies that must be created before
/// [ProviderScope]. Tests pass their own overrides through [AppSetup] instead
/// of initializing plugins or global storage.
abstract final class AppDependencies {
  static List<Override> production({
    required SharedPreferences sharedPreferences,
  }) {
    return [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      themeStorageProvider.overrideWithValue(
        SharedPreferencesThemeStorage(sharedPreferences),
      ),
      core_net.authenticatedDioProvider.overrideWith((ref) {
        return ref.watch(auth_net.authAwareDioProvider);
      }),
    ];
  }
}
