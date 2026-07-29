import 'package:flutter/foundation.dart';

/// Runtime endpoints for the customer app.
///
/// [API_BASE_URL] is the Gateway origin (without `/api`). It can be supplied
/// with `--dart-define=API_BASE_URL=https://gateway.example.com`.
class RuntimeConfig {
  RuntimeConfig._();

  static const _configuredGateway = String.fromEnvironment('API_BASE_URL');

  static String get gatewayBaseUrl => resolveGatewayBaseUrl(
    configuredValue: _configuredGateway,
    platform: defaultTargetPlatform,
  );

  static String get apiBaseUrl => '$gatewayBaseUrl/api';

  static String get shipperLocationWebSocketUrl {
    return resolveShipperLocationWebSocketUrl(gatewayBaseUrl);
  }

  @visibleForTesting
  static String resolveShipperLocationWebSocketUrl(String baseUrl) {
    final gateway = Uri.parse(baseUrl);
    return gateway
        .replace(
          scheme: gateway.scheme == 'https' ? 'wss' : 'ws',
          path: '/ws/shipper-locations',
          query: null,
        )
        .toString();
  }

  @visibleForTesting
  static String resolveGatewayBaseUrl({
    required String configuredValue,
    required TargetPlatform platform,
  }) {
    final configured = configuredValue.trim();
    final fallback = platform == TargetPlatform.android
        ? 'http://10.0.2.2:8079'
        : 'http://localhost:8079';
    final value = configured.isEmpty ? fallback : configured;

    return value
        .replaceFirst(RegExp(r'/api/?$'), '')
        .replaceFirst(RegExp(r'/+$'), '');
  }
}
