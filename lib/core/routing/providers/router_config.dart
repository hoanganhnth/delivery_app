import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/routing/models/app_router_config.dart';

part 'router_config.g.dart';

/// Router configuration provider.
/// Wiring point: selects the correct config based on environment.
@riverpod
AppRouterConfig routerConfig(Ref ref) {
  if (kDebugMode) {
    return ref.watch(devRouterConfigProvider);
  } else {
    return ref.watch(prodRouterConfigProvider);
  }
}

/// Development router config
@riverpod
AppRouterConfig devRouterConfig(Ref ref) {
  return const AppRouterConfig(
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    enableRedirects: true,
    enableDeepLinking: true,
    enableLogging: true,
    baseUrl: 'https://deliveryapp.dev',
  );
}

/// Production router config
@riverpod
AppRouterConfig prodRouterConfig(Ref ref) {
  return const AppRouterConfig(
    debugLogDiagnostics: false,
    initialLocation: '/splash',
    enableRedirects: true,
    enableDeepLinking: true,
    enableLogging: false,
    baseUrl: 'https://deliveryapp.com',
  );
}

/// Test router config
@riverpod
AppRouterConfig testRouterConfig(Ref ref) {
  return const AppRouterConfig(
    debugLogDiagnostics: false,
    initialLocation: '/splash',
    enableRedirects: false,
    enableDeepLinking: false,
    enableLogging: false,
  );
}
