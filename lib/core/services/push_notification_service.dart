import 'dart:async';

import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/storage_di_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'push/firebase_push_adapters.dart';
import 'push/push_notification_contracts.dart';
import 'push/push_persistence_adapter.dart';

export 'push/push_notification_contracts.dart';

abstract interface class PushNotificationPort {
  Stream<PushWakeSignal> get wakeSignals;
  Future<void> initialize({required bool authenticated});
  Future<void> updateAuthentication(bool authenticated);
  Future<void> unregisterToken();
}

class PushNotificationService implements PushNotificationPort {
  PushNotificationService({
    required PushNativePort native,
    required PushTokenBackendPort backend,
    required PushPersistencePort persistence,
    required PushPresentationPort presentation,
  }) : _native = native,
       _backend = backend,
       _persistence = persistence,
       _presentation = presentation;

  final PushNativePort _native;
  final PushTokenBackendPort _backend;
  final PushPersistencePort _persistence;
  final PushPresentationPort _presentation;
  final StreamController<PushWakeSignal> _wakeController =
      StreamController<PushWakeSignal>.broadcast();

  bool _authenticated = false;
  bool _initialized = false;
  bool _permissionGranted = false;
  Future<void>? _initialization;
  Future<void> _tokenOperations = Future<void>.value();
  int _sessionGeneration = 0;
  String? _registeredTokenInMemory;
  final List<StreamSubscription<Object?>> _subscriptions = [];

  @override
  Stream<PushWakeSignal> get wakeSignals => _wakeController.stream;

  @override
  Future<void> initialize({required bool authenticated}) async {
    final generation = _setAuthentication(authenticated);
    _initialization ??= _initializeOnce();
    await _initialization;
    if (_authenticated) {
      await _activateSession(generation);
    }
    // A false value during app startup is not authoritative until auth
    // bootstrap completes. Preserve the native token and pending wake ledger;
    // explicit logout/session-expiry transitions perform cleanup.
  }

  Future<void> _initializeOnce() async {
    if (_initialized) return;
    _initialized = true;
    try {
      _permissionGranted = await _native.requestPermission();
    } catch (_) {
      _permissionGranted = false;
    }

    try {
      await _presentation.initialize();
    } catch (_) {}

    try {
      _subscriptions.add(
        _native.tokenRefreshes.listen((token) {
          if (_authenticated) {
            final generation = _sessionGeneration;
            unawaited(_queueTokenReplacement(token, generation));
          }
        }),
      );
    } catch (_) {}
    try {
      _subscriptions.add(
        _native.foregroundMessages.listen((message) {
          unawaited(_handleLiveMessage(message, showForeground: true));
        }),
      );
    } catch (_) {}
    try {
      _subscriptions.add(
        _native.openedMessages.listen((message) {
          unawaited(_handleLiveMessage(message));
        }),
      );
    } catch (_) {}

    try {
      final initial = await _native.getInitialMessage();
      final signal = initial == null ? null : parsePushWakeSignal(initial);
      if (signal != null) await _persistence.recordPending(signal);
    } catch (_) {
      // Durable inbox/order REST remains the recovery path.
    }
  }

  @override
  Future<void> updateAuthentication(bool authenticated) async {
    final generation = _setAuthentication(authenticated);
    if (authenticated) {
      _initialization ??= _initializeOnce();
      await _initialization;
      await _activateSession(generation);
    } else {
      await _queueTokenCleanup(unregisterBackend: false);
    }
  }

  Future<void> _activateSession(int generation) async {
    if (_permissionGranted) {
      try {
        final token = await _native.getToken();
        if (token != null) {
          await _queueTokenReplacement(token, generation);
        }
      } catch (_) {}
    }
    final pending = await _persistence.consumePending();
    if (!_isCurrentSession(generation)) return;
    for (final signal in pending) {
      _wakeController.add(signal);
    }
  }

  Future<void> _queueTokenReplacement(String candidate, int generation) {
    return _enqueueTokenOperation(() => _replaceToken(candidate, generation));
  }

  Future<void> _enqueueTokenOperation(Future<void> Function() operation) {
    final completer = Completer<void>();
    _tokenOperations = _tokenOperations.then((_) async {
      try {
        await operation();
        completer.complete();
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  Future<void> _replaceToken(String candidate, int generation) async {
    final token = candidate.trim();
    if (!_isCurrentSession(generation) || token.isEmpty) return;
    final previous = await _persistence.getLastSyncedToken();
    if (previous == token) {
      _registeredTokenInMemory = token;
      return;
    }

    if (previous != null) {
      try {
        await _backend.unregisterToken(previous);
        if (_registeredTokenInMemory == previous) {
          _registeredTokenInMemory = null;
        }
      } catch (_) {}
    }
    if (!_isCurrentSession(generation)) return;
    try {
      await _backend.registerToken(token);
      // Persist even if logout started while registration was in flight. The
      // serialized cleanup queued by logout will then unregister this token.
      _registeredTokenInMemory = token;
      await _persistence.setLastSyncedToken(token);
    } catch (_) {
      // Token sync is best-effort; REST polling remains available.
    }
  }

  Future<void> _handleLiveMessage(
    PushMessageEnvelope message, {
    bool showForeground = false,
  }) async {
    final signal = parsePushWakeSignal(message);
    if (signal == null) return;
    final generation = _sessionGeneration;
    if (!_authenticated) {
      await _persistence.recordPending(signal);
      return;
    }
    if (!await _persistence.claimLive(signal)) return;
    if (!_isCurrentSession(generation)) return;

    if (showForeground) {
      try {
        await _presentation.showForeground(
          signal,
          title: message.title,
          body: message.body,
        );
      } catch (_) {}
    }
    _wakeController.add(signal);
  }

  @override
  Future<void> unregisterToken() async {
    _setAuthentication(false);
    await _queueTokenCleanup(unregisterBackend: true);
  }

  Future<void> _queueTokenCleanup({required bool unregisterBackend}) {
    return _enqueueTokenOperation(() async {
      final persistedToken = await _persistence.getLastSyncedToken();
      final tokens = <String>{
        if (persistedToken != null) persistedToken,
        if (_registeredTokenInMemory != null) _registeredTokenInMemory!,
      };
      if (unregisterBackend) {
        for (final token in tokens) {
          try {
            await _backend.unregisterToken(token);
          } catch (_) {}
        }
      }
      _registeredTokenInMemory = null;
      try {
        await _native.deleteToken();
      } catch (_) {}
      await _persistence.setLastSyncedToken(null);
      await _persistence.clearPending();
    });
  }

  int _setAuthentication(bool authenticated) {
    if (_authenticated != authenticated) {
      _sessionGeneration += 1;
      _authenticated = authenticated;
    }
    return _sessionGeneration;
  }

  bool _isCurrentSession(int generation) {
    return _authenticated && generation == _sessionGeneration;
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
    await _wakeController.close();
  }
}

final pushNativePortProvider = Provider<PushNativePort>(
  (ref) => FirebasePushNativeAdapter(),
);

final pushTokenBackendPortProvider = Provider<PushTokenBackendPort>((ref) {
  return DioPushTokenBackendAdapter(ref.watch(authenticatedDioProvider));
});

final pushPersistencePortProvider = Provider<PushPersistencePort>((ref) {
  return SharedPreferencesPushPersistence(ref.watch(sharedPreferencesProvider));
});

final pushPresentationPortProvider = Provider<PushPresentationPort>(
  (ref) => FlutterLocalPushPresentationAdapter(),
);

final pushNotificationPortProvider = Provider<PushNotificationPort>((ref) {
  final service = PushNotificationService(
    native: ref.watch(pushNativePortProvider),
    backend: ref.watch(pushTokenBackendPortProvider),
    persistence: ref.watch(pushPersistencePortProvider),
    presentation: ref.watch(pushPresentationPortProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});
