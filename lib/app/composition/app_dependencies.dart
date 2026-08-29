import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart'
    as core_net;
import 'package:delivery_app/core/contracts/session_port_provider.dart'
    as session_contract;
import 'package:delivery_app/core/contracts/catalog_port_provider.dart'
    as catalog_contract;
import 'package:delivery_app/core/contracts/cart_port_provider.dart'
    as cart_contract;
import 'package:delivery_app/core/config/api_endpoint_controller.dart';
import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/features/auth/di/auth_network_providers.dart'
    as auth_net;
import 'package:delivery_app/features/auth/di/session_port_provider.dart'
    as auth_session;
import 'package:delivery_app/features/restaurants/di/catalog_browse_port_provider.dart'
    as restaurants_catalog;
import 'package:delivery_app/features/cart/di/cart_port_provider.dart'
    as cart_feature;
import 'package:delivery_app/features/auth/di/storage_di_providers.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:shared_preferences/shared_preferences.dart';

/// Application composition root. Feature implementations are wired here and
/// exposed through neutral core contracts.
abstract final class AppDependencies {
  static List<Override> production({
    required SharedPreferences sharedPreferences,
  }) => [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    apiEndpointControllerProvider.overrideWithValue(
      ApiEndpointController(
        defaultGatewayOrigin: RuntimeConfig.gatewayBaseUrl,
        preferences: sharedPreferences,
      ),
    ),
    themeStorageProvider.overrideWithValue(
      SharedPreferencesThemeStorage(sharedPreferences),
    ),
    core_net.authenticatedDioProvider.overrideWith(
      (ref) => ref.watch(auth_net.authAwareDioProvider),
    ),
    session_contract.sessionPortProvider.overrideWith(
      (ref) => ref.watch(auth_session.authSessionPortProvider),
    ),
    catalog_contract.catalogBrowsePortProvider.overrideWith(
      (ref) => ref.watch(restaurants_catalog.catalogBrowsePortProvider),
    ),
    catalog_contract.catalogMenuLookupPortProvider.overrideWith(
      (ref) => ref.watch(restaurants_catalog.catalogMenuLookupPortProvider),
    ),
    cart_contract.cartCommandsPortProvider.overrideWith(
      (ref) => ref.watch(cart_feature.cartCommandsPortOverrideProvider),
    ),
    cart_contract.cartReaderPortProvider.overrideWith(
      (ref) => ref.watch(cart_feature.cartReaderPortOverrideProvider),
    ),
  ];
}
