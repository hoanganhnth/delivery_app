import 'dart:async';

import 'package:delivery_app/core/services/push/push_persistence_adapter.dart';
import 'package:delivery_app/core/services/push_notification_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('parses only stable customer notification identity', () {
    expect(
      parsePushWakeSignal(
        envelope(
          notificationId: 91,
          type: 'DELIVERY_ASSIGNED',
          relatedEntityId: 42,
        ),
      ),
      const PushWakeSignal(
        notificationId: 91,
        type: 'DELIVERY_ASSIGNED',
        relatedEntityId: 42,
        relatedEntityType: 'ORDER',
      ),
    );
    expect(
      parsePushWakeSignal(
        const PushMessageEnvelope(data: {'type': 'DELIVERY_ASSIGNED'}),
      ),
      isNull,
    );
    expect(
      parsePushWakeSignal(envelope(notificationId: 91, type: 'MATCH_FOUND')),
      isNull,
    );
  });

  test(
    'auth registers token and refresh replaces the previous device token',
    () async {
      final native = _FakeNative(token: 'token-a');
      final backend = _FakeBackend();
      final persistence = _FakePersistence();
      final service = _service(native, backend, persistence);
      addTearDown(service.dispose);

      await service.initialize(authenticated: true);
      expect(backend.registered, ['token-a']);

      native.tokenRefreshController.add('token-b');
      await eventually(() => backend.registered.length == 2);

      expect(backend.unregistered, ['token-a']);
      expect(backend.registered, ['token-a', 'token-b']);
      expect(persistence.lastToken, 'token-b');
    },
  );

  test('foreground duplicate shows and wakes exactly once', () async {
    final native = _FakeNative(token: 'token-a');
    final backend = _FakeBackend();
    final persistence = _FakePersistence();
    final presentation = _FakePresentation();
    final service = PushNotificationService(
      native: native,
      backend: backend,
      persistence: persistence,
      presentation: presentation,
    );
    addTearDown(service.dispose);
    final wakes = <PushWakeSignal>[];
    service.wakeSignals.listen(wakes.add);
    await service.initialize(authenticated: true);

    final message = envelope(notificationId: 101, type: 'DELIVERY_DELIVERING');
    native.foregroundController.add(message);
    native.foregroundController.add(message);
    await eventually(() => persistence.claimAttempts == 2);

    expect(wakes.map((signal) => signal.notificationId), [101]);
    expect(presentation.shown.map((signal) => signal.notificationId), [101]);
  });

  test(
    'terminated/background wake is consumed after authenticated restart',
    () async {
      final signal = const PushWakeSignal(
        notificationId: 201,
        type: 'ORDER_CREATED',
      );
      final native = _FakeNative(token: 'token-a')
        ..initialMessage = envelope(notificationId: 201, type: 'ORDER_CREATED');
      final persistence = _FakePersistence();
      final service = _service(native, _FakeBackend(), persistence);
      addTearDown(service.dispose);
      final wakes = <PushWakeSignal>[];
      service.wakeSignals.listen(wakes.add);

      await service.initialize(authenticated: false);
      expect(wakes, isEmpty);
      await service.updateAuthentication(true);

      await eventually(() => wakes.length == 1);
      expect(wakes, [signal]);
      native.openedController.add(
        envelope(notificationId: 201, type: 'ORDER_CREATED'),
      );
      await eventually(() => persistence.claimAttempts == 1);
      expect(wakes, [signal]);
    },
  );

  test('logged-out wake queues and relogin recovers canonical state', () async {
    final native = _FakeNative(token: 'token-a');
    final persistence = _FakePersistence();
    final service = _service(native, _FakeBackend(), persistence);
    addTearDown(service.dispose);
    final wakes = <PushWakeSignal>[];
    service.wakeSignals.listen(wakes.add);
    await service.initialize(authenticated: false);

    native.foregroundController.add(
      envelope(notificationId: 301, type: 'DELIVERY_PICKED_UP'),
    );
    await eventually(() => persistence.pending.length == 1);
    await service.updateAuthentication(true);

    await eventually(() => wakes.length == 1);
    expect(wakes.map((signal) => signal.notificationId), [301]);
  });

  test(
    'logout removes this token and relogin registers a fresh installation token',
    () async {
      final native = _FakeNative(token: 'token-a');
      final backend = _FakeBackend();
      final persistence = _FakePersistence();
      final service = _service(native, backend, persistence);
      addTearDown(service.dispose);
      await service.initialize(authenticated: true);

      await service.unregisterToken();
      expect(backend.unregistered, ['token-a']);
      expect(native.deleteCalls, 1);
      expect(persistence.lastToken, isNull);

      native.token = 'token-after-reinstall';
      await service.updateAuthentication(true);
      expect(backend.registered, ['token-a', 'token-after-reinstall']);
    },
  );

  test(
    'logout waits for in-flight refresh and unregisters the rotated token',
    () async {
      final native = _FakeNative(token: 'token-a');
      final backend = _FakeBackend();
      final persistence = _FakePersistence();
      final service = _service(native, backend, persistence);
      addTearDown(service.dispose);
      await service.initialize(authenticated: true);

      final releaseRegistration = backend.blockRegistration('token-b');
      native.tokenRefreshController.add('token-b');
      await eventually(() => backend.registered.contains('token-b'));

      final logout = service.unregisterToken();
      releaseRegistration();
      await logout;

      expect(backend.unregistered, ['token-a', 'token-b']);
      expect(persistence.lastToken, isNull);
      expect(native.deleteCalls, 1);
    },
  );

  test(
    'startup auth bootstrap preserves the existing installation token',
    () async {
      final native = _FakeNative(token: 'token-a');
      final persistence = _FakePersistence()..lastToken = 'token-a';
      final service = _service(native, _FakeBackend(), persistence);
      addTearDown(service.dispose);

      await service.initialize(authenticated: false);

      expect(native.deleteCalls, 0);
      expect(persistence.lastToken, 'token-a');
    },
  );

  test(
    'session expiry deletes native token without unauthenticated REST',
    () async {
      final native = _FakeNative(token: 'token-a');
      final backend = _FakeBackend();
      final service = _service(native, backend, _FakePersistence());
      addTearDown(service.dispose);
      await service.initialize(authenticated: true);

      await service.updateAuthentication(false);

      expect(native.deleteCalls, 1);
      expect(backend.unregistered, isEmpty);
    },
  );

  test(
    'permission denial leaves REST/polling recovery independent of FCM',
    () async {
      final native = _FakeNative(token: 'token-a')..permissionGranted = false;
      final backend = _FakeBackend();
      final service = _service(native, backend, _FakePersistence());
      addTearDown(service.dispose);

      await service.initialize(authenticated: true);

      expect(native.getTokenCalls, 0);
      expect(backend.registered, isEmpty);
    },
  );

  test('background ledger deduplicates across a new app instance', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    final background = SharedPreferencesPushPersistence(preferences);
    final restarted = SharedPreferencesPushPersistence(preferences);
    final message = envelope(notificationId: 401, type: 'DELIVERY_DELIVERED');

    expect(await recordBackgroundPushWake(message, background), isTrue);
    expect(await recordBackgroundPushWake(message, restarted), isFalse);
    expect(
      (await restarted.consumePending()).map((signal) => signal.notificationId),
      [401],
    );
    final nextRestart = SharedPreferencesPushPersistence(preferences);
    expect(
      await nextRestart.claimLive(
        const PushWakeSignal(notificationId: 401, type: 'DELIVERY_DELIVERED'),
      ),
      isFalse,
    );
  });
}

PushNotificationService _service(
  _FakeNative native,
  _FakeBackend backend,
  _FakePersistence persistence,
) {
  return PushNotificationService(
    native: native,
    backend: backend,
    persistence: persistence,
    presentation: _FakePresentation(),
  );
}

PushMessageEnvelope envelope({
  required int notificationId,
  required String type,
  int? relatedEntityId,
}) {
  return PushMessageEnvelope(
    data: {
      'notificationId': '$notificationId',
      'type': type,
      if (relatedEntityId != null) ...{
        'relatedEntityId': '$relatedEntityId',
        'relatedEntityType': 'ORDER',
      },
    },
    title: 'Wake title',
    body: 'Wake body',
  );
}

class _FakeNative implements PushNativePort {
  _FakeNative({this.token});

  String? token;
  bool permissionGranted = true;
  int getTokenCalls = 0;
  int deleteCalls = 0;
  PushMessageEnvelope? initialMessage;
  final tokenRefreshController = StreamController<String>.broadcast();
  final foregroundController =
      StreamController<PushMessageEnvelope>.broadcast();
  final openedController = StreamController<PushMessageEnvelope>.broadcast();

  @override
  Future<bool> requestPermission() async => permissionGranted;

  @override
  Future<String?> getToken() async {
    getTokenCalls += 1;
    return token;
  }

  @override
  Future<void> deleteToken() async {
    deleteCalls += 1;
  }

  @override
  Future<PushMessageEnvelope?> getInitialMessage() async => initialMessage;

  @override
  Stream<String> get tokenRefreshes => tokenRefreshController.stream;

  @override
  Stream<PushMessageEnvelope> get foregroundMessages =>
      foregroundController.stream;

  @override
  Stream<PushMessageEnvelope> get openedMessages => openedController.stream;
}

class _FakeBackend implements PushTokenBackendPort {
  final registered = <String>[];
  final unregistered = <String>[];
  final _registrationGates = <String, Completer<void>>{};

  @override
  Future<void> registerToken(String token) async {
    registered.add(token);
    await _registrationGates[token]?.future;
  }

  @override
  Future<void> unregisterToken(String token) async => unregistered.add(token);

  void Function() blockRegistration(String token) {
    final completer = Completer<void>();
    _registrationGates[token] = completer;
    return () {
      _registrationGates.remove(token);
      completer.complete();
    };
  }
}

class _FakePersistence implements PushPersistencePort {
  String? lastToken;
  final pending = <PushWakeSignal>[];
  final processed = <int>{};
  int claimAttempts = 0;

  @override
  Future<String?> getLastSyncedToken() async => lastToken;

  @override
  Future<void> setLastSyncedToken(String? token) async => lastToken = token;

  @override
  Future<bool> claimLive(PushWakeSignal signal) async {
    claimAttempts += 1;
    if (!processed.add(signal.notificationId)) return false;
    pending.removeWhere(
      (pendingSignal) => pendingSignal.notificationId == signal.notificationId,
    );
    return true;
  }

  @override
  Future<bool> recordPending(PushWakeSignal signal) async {
    if (processed.contains(signal.notificationId) ||
        pending.any((item) => item.notificationId == signal.notificationId)) {
      return false;
    }
    pending.add(signal);
    return true;
  }

  @override
  Future<List<PushWakeSignal>> consumePending() async {
    final result = [...pending];
    pending.clear();
    processed.addAll(result.map((signal) => signal.notificationId));
    return result;
  }

  @override
  Future<void> clearPending() async => pending.clear();
}

class _FakePresentation implements PushPresentationPort {
  final shown = <PushWakeSignal>[];

  @override
  Future<void> initialize() async {}

  @override
  Future<void> showForeground(
    PushWakeSignal signal, {
    String? title,
    String? body,
  }) async {
    shown.add(signal);
  }
}

Future<void> eventually(bool Function() predicate) async {
  for (var attempt = 0; attempt < 20; attempt += 1) {
    if (predicate()) return;
    await Future<void>.delayed(Duration.zero);
  }
  throw StateError('condition did not converge');
}
