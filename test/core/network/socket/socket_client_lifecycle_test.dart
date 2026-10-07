import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:delivery_app/core/network/socket/socket_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'connects once, streams messages, sends raw/JSON and reconnects after close',
    () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final sockets = <WebSocket>[];
      final incoming = StreamController<String>.broadcast();
      final connected = StreamController<WebSocket>.broadcast();
      final subscription = server.listen((request) async {
        expect(request.headers.value('authorization'), 'Bearer test-token');
        final socket = await WebSocketTransformer.upgrade(request);
        sockets.add(socket);
        socket.listen((message) => incoming.add(message as String));
        connected.add(socket);
        socket.add('ready');
      });
      final client = SocketClient(
        'ws://127.0.0.1:${server.port}/ws',
        headers: {'Authorization': 'Bearer test-token'},
        requireAuthorization: true,
      );
      final raw = <String>[];
      final states = <bool>[];
      final rawSubscription = client.rawStream.listen(raw.add);
      final stateSubscription = client.connectionStream.listen(states.add);
      addTearDown(() async {
        client.dispose();
        await rawSubscription.cancel();
        await stateSubscription.cancel();
        for (final socket in sockets) {
          await socket.close();
        }
        await subscription.cancel();
        await server.close(force: true);
        await incoming.close();
        await connected.close();
      });
      final ready = client.rawStream.first;
      final first = client.connect();
      final concurrent = client.connect();
      await Future.wait([first, concurrent]);
      expect(client.isConnected, true);
      expect(await ready, 'ready');
      await client.connect();
      expect(sockets, hasLength(1));
      final rawMessage = incoming.stream.first;
      client.sendRaw('hello');
      expect(await rawMessage, 'hello');
      final jsonMessage = incoming.stream.first;
      client.sendJson({'action': 'subscribe', 'id': 7});
      expect(jsonDecode(await jsonMessage), {'action': 'subscribe', 'id': 7});
      final ping = incoming.stream.first;
      final heartbeat =
          jsonDecode(await ping.timeout(const Duration(seconds: 35))) as Map;
      expect(heartbeat['action'], 'ping');
      expect(DateTime.tryParse(heartbeat['timestamp'] as String), isNotNull);
      final reconnect = connected.stream.first;
      await sockets.first.close();
      final second = await reconnect.timeout(const Duration(seconds: 8));
      await client.connectionStream.firstWhere((value) => value);
      expect(sockets, hasLength(2));
      final message = client.rawStream.first;
      second.add('after-reconnect');
      expect(await message, 'after-reconnect');
      await client.disconnect();
      expect(client.isConnected, false);
      client.sendRaw('ignored');
      expect(states, containsAllInOrder([false, true, false, true]));
      client.dispose();
      client.dispose();
      await expectLater(client.connect(), throwsA(isA<Exception>()));
    },
    timeout: const Timeout(Duration(seconds: 50)),
  );
}
