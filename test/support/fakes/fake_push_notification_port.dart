import 'dart:async';

import 'package:delivery_app/core/services/push_notification_service.dart';

class FakePushNotificationPort implements PushNotificationPort {
  final List<bool> initializeCalls = [];
  final List<bool> authenticationUpdates = [];
  int unregisterCalls = 0;
  Object? error;
  final StreamController<PushWakeSignal> _wakeController =
      StreamController<PushWakeSignal>.broadcast();

  @override
  Stream<PushWakeSignal> get wakeSignals => _wakeController.stream;

  void emitWake(PushWakeSignal signal) => _wakeController.add(signal);

  Future<void> dispose() => _wakeController.close();

  @override
  Future<void> initialize({required bool authenticated}) async {
    initializeCalls.add(authenticated);
    final failure = error;
    if (failure != null) throw failure;
  }

  @override
  Future<void> unregisterToken() async {
    unregisterCalls += 1;
    final failure = error;
    if (failure != null) throw failure;
  }

  @override
  Future<void> updateAuthentication(bool authenticated) async {
    authenticationUpdates.add(authenticated);
    final failure = error;
    if (failure != null) throw failure;
  }
}
