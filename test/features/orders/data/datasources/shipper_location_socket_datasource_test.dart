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
  final sentMessages = <String>[];
  bool connected = true;
  bool failConnect = false;
  bool failSend = false;

  @override
  Stream<String> get rawStream => rawMessages.stream;

  @override
  Stream<bool> get connectionStream => connections.stream;

  @override
  bool get isConnected => connected;

  @override
  Future<void> connect() async {
    if (failConnect) throw StateError('connect failed');
    connections.add(connected);
  }

  @override
  Future<void> disconnect() async {}

  @override
  void sendRaw(String message) {
    if (failSend) throw StateError('send failed');
    sentMessages.add(message);
  }

  Future<void> close() async {
    await rawMessages.close();
    await connections.close();
  }
}

void main() {
  test(
    'caches tracked locations, ignores invalid data and resubscribes on reconnect',
    () async {
      final socket = _ControllableSocketClient();
      final source = ShipperLocationSocketDataSource(socket: socket);
      final events = <Object>[];
      final subscription = source.locationStream.listen(events.add);
      expect(await source.connectionStream.first, isFalse);
      expect(await source.connect(), isTrue);
      await source.subscribeToShipper('42', 100);
      await Future<void>.delayed(Duration.zero);
      socket.sentMessages.clear();
      final message = <String, dynamic>{
        'type': 'location_update',
        'shipperId': '42',
        'latitude': '10.77',
        'longitude': 106,
        'accuracy': 2.0,
        'speed': '3',
        'heading': 90,
        'timestamp': 1000,
      };
      socket.rawMessages.add(jsonEncode(message));
      socket.rawMessages.add(
        jsonEncode({...message, 'shipperId': 42.0, 'latitude': 10.78}),
      );
      socket.rawMessages.add(jsonEncode({...message, 'shipperId': 43}));
      socket.rawMessages.add('bad json');
      socket.rawMessages.add(jsonEncode({'type': 'heartbeat'}));
      for (final change in [
        {'shipperId': null},
        {'shipperId': true},
        {'latitude': true},
        {'timestamp': null},
        {'timestamp': true},
        {'timestamp': 'bad'},
      ]) {
        socket.rawMessages.add(jsonEncode({...message, ...change}));
      }
      await Future<void>.delayed(Duration.zero);
      expect(events, hasLength(2));
      final cached = source.getShipperLocation('42')!;
      expect(cached.latitude, 10.78);
      expect(cached.longitude, 106);
      expect(cached.accuracy, 2);
      expect(cached.speed, 3);
      expect(cached.heading, 90);
      expect(cached.updatedAt.millisecondsSinceEpoch, 1000);
      expect(source.trackedShipperIds, ['42']);
      socket.connections.add(false);
      socket.connections.add(true);
      await Future<void>.delayed(Duration.zero);
      expect(jsonDecode(socket.sentMessages.single), {
        'action': 'subscribe_shipper',
        'shipperId': '42',
        'deliveryId': 100,
      });
      await source.unsubscribeAll();
      expect(source.trackedShipperIds, isEmpty);
      expect(source.getShipperLocation('42'), isNull);
      expect(jsonDecode(socket.sentMessages.last), {
        'action': 'unsubscribe_shipper',
        'shipperId': '42',
      });
      await source.disconnect();
      await subscription.cancel();
      await source.dispose();
      await socket.close();
    },
  );

  test('connection failure and send failure retain observable state', () async {
    final socket = _ControllableSocketClient()..failConnect = true;
    final source = ShipperLocationSocketDataSource(socket: socket);
    expect(await source.connect(), isFalse);
    socket.failConnect = false;
    socket.connected = false;
    expect(await source.connect(), isFalse);
    socket.failSend = true;
    await expectLater(source.subscribeToShipper('42', 100), throwsStateError);
    expect(source.trackedShipperIds, isEmpty);
    socket.failSend = false;
    await source.subscribeToShipper('42', 100);
    socket.failSend = true;
    await expectLater(source.unsubscribeFromShipper('42'), throwsStateError);
    expect(source.trackedShipperIds, isEmpty);
    socket.failSend = false;
    await source.dispose();
    await socket.close();
  });

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
