import 'package:flutter/foundation.dart';

/// Runtime endpoints for the customer app.
///
/// [API_BASE_URL] is the Gateway origin (without `/api`). It can be supplied
/// with `--dart-define=API_BASE_URL=https://gateway.example.com`.
class RuntimeConfig {
  RuntimeConfig._();

  static const _configuredGateway = String.fromEnvironment('API_BASE_URL');
  static const voucherCheckoutEnabled = bool.fromEnvironment(
    'VOUCHER_CHECKOUT_ENABLED',
    defaultValue: false,
  );
  static const voucherStackingEnabled = bool.fromEnvironment(
    'VOUCHER_STACKING_ENABLED',
    defaultValue: false,
  );
  static const flashSaleCheckoutEnabled = bool.fromEnvironment(
    'FLASHSALE_CHECKOUT_ENABLED',
    defaultValue: false,
  );
  static const livestreamViewerEnabled = bool.fromEnvironment(
    'LIVESTREAM_CLIENT_API_ENABLED',
    defaultValue: false,
  );
  static const vnpayPaymentEnabled = bool.fromEnvironment(
    'VNPAY_PAYMENT_ENABLED',
    defaultValue: false,
  );
  static const _vnpayReturnUri = String.fromEnvironment(
    'VNPAY_RETURN_URI',
    defaultValue: 'delivery://payments/vnpay-return',
  );

  static Uri get vnpayReturnUri => Uri.parse(_vnpayReturnUri);

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
