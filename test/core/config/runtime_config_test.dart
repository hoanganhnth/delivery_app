import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RuntimeConfig', () {
    test('uses Android emulator Gateway when API_BASE_URL is empty', () {
      expect(
        RuntimeConfig.resolveGatewayBaseUrl(
          configuredValue: '',
          platform: TargetPlatform.android,
        ),
        'http://10.0.2.2:8079',
      );
    });

    test('uses localhost Gateway on iOS when API_BASE_URL is empty', () {
      expect(
        RuntimeConfig.resolveGatewayBaseUrl(
          configuredValue: '',
          platform: TargetPlatform.iOS,
        ),
        'http://localhost:8079',
      );
    });

    test('normalizes configured Gateway origin', () {
      expect(
        RuntimeConfig.resolveGatewayBaseUrl(
          configuredValue: ' https://gateway.example.com/api/ ',
          platform: TargetPlatform.android,
        ),
        'https://gateway.example.com',
      );
    });

    test('derives secure raw WebSocket URL from HTTPS Gateway', () {
      final gateway = RuntimeConfig.resolveGatewayBaseUrl(
        configuredValue: 'https://gateway.example.com/api',
        platform: TargetPlatform.android,
      );

      expect(
        RuntimeConfig.resolveShipperLocationWebSocketUrl(gateway),
        'wss://gateway.example.com/ws/shipper-locations',
      );
    });
  });
}
