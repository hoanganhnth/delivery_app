import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_config.g.dart';

/// Router configuration provider
/// This allows for easy customization of router behavior based on environment
@riverpod
AppRouterConfig routerConfig(Ref ref) {
  // Switch between different configs based on environment
  if (kDebugMode) {
    return ref.watch(devRouterConfigProvider);
  } else {
    return ref.watch(prodRouterConfigProvider);
  }
}

/// Router configuration class
class AppRouterConfig {
  final bool debugLogDiagnostics;
  final String initialLocation;
  final bool enableRedirects;
  final bool enableDeepLinking;
  final Duration navigationTimeout;
  final bool enableLogging;
  final String? baseUrl;

  const AppRouterConfig({
    this.debugLogDiagnostics = true,
    this.initialLocation = '/splash',
    this.enableRedirects = true,
    this.enableDeepLinking = true,
    this.navigationTimeout = const Duration(seconds: 30),
    this.enableLogging = true,
    this.baseUrl,
  });

  AppRouterConfig copyWith({
    bool? debugLogDiagnostics,
    String? initialLocation,
    bool? enableRedirects,
    bool? enableDeepLinking,
    Duration? navigationTimeout,
    bool? enableLogging,
    String? baseUrl,
  }) {
    return AppRouterConfig(
      debugLogDiagnostics: debugLogDiagnostics ?? this.debugLogDiagnostics,
      initialLocation: initialLocation ?? this.initialLocation,
      enableRedirects: enableRedirects ?? this.enableRedirects,
      enableDeepLinking: enableDeepLinking ?? this.enableDeepLinking,
      navigationTimeout: navigationTimeout ?? this.navigationTimeout,
      enableLogging: enableLogging ?? this.enableLogging,
      baseUrl: baseUrl ?? this.baseUrl,
    );
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
    baseUrl: 'https://deliveryapp.dev', // Development deep link base
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
    baseUrl: 'https://deliveryapp.com', // Production deep link base
  );
}

/// Test router config
@riverpod
AppRouterConfig testRouterConfig(Ref ref) {
  return const AppRouterConfig(
    debugLogDiagnostics: false,
    initialLocation: '/splash',
    enableRedirects: false, // Disable redirects for testing
    enableDeepLinking: false,
    enableLogging: false,
  );
}
