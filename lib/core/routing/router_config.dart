import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Router configuration provider
/// This allows for easy customization of router behavior based on environment
final routerConfigProvider = Provider<AppRouterConfig>((ref) {
  // Switch between different configs based on environment
  if (kDebugMode) {
    return ref.watch(devRouterConfigProvider);
  } else {
    return ref.watch(prodRouterConfigProvider);
  }
});

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
    this.initialLocation = '/home',
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
final devRouterConfigProvider = Provider<AppRouterConfig>((ref) {
  return const AppRouterConfig(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    enableRedirects: true,
    enableDeepLinking: true,
    enableLogging: true,
  );
});

/// Production router config
final prodRouterConfigProvider = Provider<AppRouterConfig>((ref) {
  return const AppRouterConfig(
    debugLogDiagnostics: false,
    initialLocation: '/home',
    enableRedirects: true,
    enableDeepLinking: true,
    enableLogging: false,
  );
});

/// Test router config
final testRouterConfigProvider = Provider<AppRouterConfig>((ref) {
  return const AppRouterConfig(
    debugLogDiagnostics: false,
    initialLocation: '/home',
    enableRedirects: false, // Disable redirects for testing
    enableDeepLinking: false,
    enableLogging: false,
  );
});
