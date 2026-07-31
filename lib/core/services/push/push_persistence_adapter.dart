import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'push_notification_contracts.dart';

class SharedPreferencesPushPersistence implements PushPersistencePort {
  SharedPreferencesPushPersistence(this._preferences);

  static const _lastTokenKey = 'push.last_synced_token';
  static const _wakeStateKey = 'push.wake_state.v1';
  static const _maxProcessed = 100;
  static const _maxPending = 20;

  final SharedPreferences _preferences;
  Future<void> _operation = Future<void>.value();

  @override
  Future<String?> getLastSyncedToken() async =>
      _preferences.getString(_lastTokenKey);

  @override
  Future<void> setLastSyncedToken(String? token) async {
    if (token == null) {
      await _preferences.remove(_lastTokenKey);
    } else {
      await _preferences.setString(_lastTokenKey, token);
    }
  }

  @override
  Future<bool> claimLive(PushWakeSignal signal) => _serial(() async {
    final state = _readState();
    if (state.processed.contains(signal.notificationId)) return false;
    state.pending.removeWhere(
      (pending) => pending.notificationId == signal.notificationId,
    );
    _appendProcessed(state.processed, signal.notificationId);
    await _writeState(state);
    return true;
  });

  @override
  Future<bool> recordPending(PushWakeSignal signal) => _serial(() async {
    final state = _readState();
    if (state.processed.contains(signal.notificationId) ||
        state.pending.any(
          (pending) => pending.notificationId == signal.notificationId,
        )) {
      return false;
    }
    state.pending.add(signal);
    if (state.pending.length > _maxPending) {
      state.pending.removeRange(0, state.pending.length - _maxPending);
    }
    await _writeState(state);
    return true;
  });

  @override
  Future<List<PushWakeSignal>> consumePending() => _serial(() async {
    final state = _readState();
    final pending = List<PushWakeSignal>.from(state.pending);
    if (pending.isEmpty) return pending;
    state.pending.clear();
    for (final signal in pending) {
      _appendProcessed(state.processed, signal.notificationId);
    }
    await _writeState(state);
    return pending;
  });

  @override
  Future<void> clearPending() => _serial(() async {
    final state = _readState()..pending.clear();
    await _writeState(state);
  });

  _WakeState _readState() {
    final raw = _preferences.getString(_wakeStateKey);
    if (raw == null) return _WakeState();
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return _WakeState();
      final processed = (decoded['processedIds'] as List? ?? const [])
          .whereType<int>()
          .where((id) => id > 0)
          .toList()
          .takeLast(_maxProcessed);
      final pending = (decoded['pending'] as List? ?? const [])
          .map(PushWakeSignal.fromJson)
          .whereType<PushWakeSignal>()
          .toList()
          .takeLast(_maxPending);
      return _WakeState(processed: processed, pending: pending);
    } catch (_) {
      return _WakeState();
    }
  }

  Future<void> _writeState(_WakeState state) => _preferences.setString(
    _wakeStateKey,
    jsonEncode({
      'processedIds': state.processed,
      'pending': state.pending.map((signal) => signal.toJson()).toList(),
    }),
  );

  void _appendProcessed(List<int> ids, int id) {
    ids.remove(id);
    ids.add(id);
    if (ids.length > _maxProcessed) {
      ids.removeRange(0, ids.length - _maxProcessed);
    }
  }

  Future<T> _serial<T>(Future<T> Function() task) {
    final completer = Completer<T>();
    _operation = _operation.then((_) async {
      try {
        completer.complete(await task());
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }
}

class _WakeState {
  _WakeState({List<int>? processed, List<PushWakeSignal>? pending})
    : processed = processed ?? [],
      pending = pending ?? [];

  final List<int> processed;
  final List<PushWakeSignal> pending;
}

extension<T> on List<T> {
  List<T> takeLast(int count) =>
      length <= count ? List<T>.from(this) : sublist(length - count);
}
