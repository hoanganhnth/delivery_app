import 'package:delivery_app/core/network/socket/socket_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('authenticated socket fails closed when access token is missing', () {
    final client = SocketClient(
      'ws://localhost/ws/shipper-locations',
      headers: const {'Authorization': 'Bearer '},
      requireAuthorization: true,
    );

    expect(client.connect, throwsStateError);
    client.dispose();
  });
}
