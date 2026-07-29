import 'dart:async';
import 'dart:convert';

import 'package:delivery_app/core/network/socket/socket_client.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_socket_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingSocketClient extends SocketClient {
  _RecordingSocketClient() : super('ws://localhost/ws/shipper-locations');

  final sentMessages = <String>[];

  @override
  void sendRaw(String message) => sentMessages.add(message);
}

class _ControllableSocketClient extends SocketClient {
  _ControllableSocketClient() : super('ws://localhost/ws/shipper-locations');

  final rawMessages = StreamController<String>.broadcast();
  final connections = StreamController<bool>.broadcast();

  @override
  Stream<String> get rawStream => rawMessages.stream;

  @override
  Stream<bool> get connectionStream => connections.stream;

  @override
  bool get isConnected => true;

  @override
  Future<void> connect() async {
    connections.add(true);
  }

  @override
  Future<void> disconnect() async {}

  @override
  void sendRaw(String message) {}

  Future<void> close() async {
    await rawMessages.close();
    await connections.close();
  }
}

void main() {
  test(
    'participant subscription includes shipper and delivery identity',
    () async {
      final socket = _RecordingSocketClient();
      final dataSource = ShipperLocationSocketDataSource(socket: socket);

      await dataSource.subscribeToShipper('42', 100);

      expect(jsonDecode(socket.sentMessages.single), {
        'action': 'subscribe_shipper',
        'shipperId': '42',
        'deliveryId': 100,
      });

      await dataSource.dispose();
    },
  );

  test(
    'ignores malformed location instead of inventing zero coordinates',
    () async {
      final socket = _ControllableSocketClient();
      final dataSource = ShipperLocationSocketDataSource(socket: socket);

      await dataSource.connect();
      await dataSource.subscribeToShipper('42', 100);
      socket.rawMessages.add(
        jsonEncode({
          'type': 'location_update',
          'shipperId': 42,
          'timestamp': '2026-07-26T10:00:00Z',
        }),
      );
      await Future<void>.delayed(Duration.zero);

      expect(dataSource.getShipperLocation('42'), isNull);

      await dataSource.dispose();
      await socket.close();
    },
  );
}
