/// Router configuration class.
/// Pure Dart — no Riverpod, no Flutter dependency.
/// Providers live separately in `providers/router_config.dart`.
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
