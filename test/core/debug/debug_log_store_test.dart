import 'package:delivery_app/core/debug/debug_log_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('redacts sensitive payload fields and keeps a bounded history', () {
    final store = DebugLogStore(maxEntries: 2);

    store.recordApi(
      phase: DebugApiPhase.request,
      method: 'POST',
      url: 'http://gateway.test/api/auth/login',
      requestBody: {
        'email': 'tester@example.com',
        'password': 'do-not-render',
        'accessToken': 'also-do-not-render',
      },
    );
    store.recordMessage(DebugLogLevel.info, 'second');

    expect(store.entries, hasLength(2));
    expect(store.entries.first.requestBody, contains('[REDACTED]'));
    expect(store.entries.first.requestBody, isNot(contains('do-not-render')));

    store.recordMessage(DebugLogLevel.warning, 'third');
    expect(store.entries, hasLength(2));
    expect(store.entries.last.message, 'third');
  });

  test('clear notifies listeners and removes all entries', () {
    final store = DebugLogStore();
    var notifications = 0;
    store.addListener(() => notifications++);

    store.recordMessage(DebugLogLevel.debug, 'hello');
    store.clear();

    expect(store.entries, isEmpty);
    expect(notifications, 2);
  });
}
