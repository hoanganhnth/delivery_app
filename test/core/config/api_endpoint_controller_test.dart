import 'package:delivery_app/core/config/api_endpoint_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizes Gateway origin and updates the API base URL', () async {
    final controller = ApiEndpointController.memory(
      defaultGatewayOrigin: 'http://localhost:8079',
    );

    await controller.setGatewayOrigin(' https://gateway.example/api/ ');

    expect(controller.gatewayOrigin, 'https://gateway.example');
    expect(controller.apiBaseUrl, 'https://gateway.example/api');
    expect(controller.hasOverride, isTrue);
  });

  test('rejects invalid backend URLs and restores the default', () async {
    final controller = ApiEndpointController.memory(
      defaultGatewayOrigin: 'http://localhost:8079',
    );

    expect(
      () => controller.setGatewayOrigin('gateway.example'),
      throwsA(isA<FormatException>()),
    );
    await controller.setGatewayOrigin('https://other.example');
    await controller.reset();

    expect(controller.gatewayOrigin, 'http://localhost:8079');
    expect(controller.hasOverride, isFalse);
  });
}
