import 'dart:async';

import 'package:delivery_app/features/livestream/platform/agora_token_renewal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'fetches and applies one token while duplicate callbacks are in flight',
    () async {
      final token = Completer<String>();
      final applied = <String>[];
      var fetchCount = 0;
      final renewal = AgoraTokenRenewal(
        fetchToken: () {
          fetchCount++;
          return token.future;
        },
        applyToken: (value) async => applied.add(value),
        onFailure: () {},
      );

      renewal.request();
      renewal.request();
      expect(fetchCount, 1);
      token.complete('renewed-viewer-token');
      await Future<void>.delayed(Duration.zero);

      expect(applied, ['renewed-viewer-token']);
    },
  );

  test('does not apply a late token after disposal', () async {
    final token = Completer<String>();
    final applied = <String>[];
    final renewal = AgoraTokenRenewal(
      fetchToken: () => token.future,
      applyToken: (value) async => applied.add(value),
      onFailure: () {},
    );

    renewal.request();
    renewal.dispose();
    token.complete('late-token');
    await Future<void>.delayed(Duration.zero);

    expect(applied, isEmpty);
  });

  test('reports renewal failures while the session is active', () async {
    var failures = 0;
    final renewal = AgoraTokenRenewal(
      fetchToken: () => Future<String>.error(StateError('offline')),
      applyToken: (_) async {},
      onFailure: () => failures++,
    );

    renewal.request();
    await Future<void>.delayed(Duration.zero);

    expect(failures, 1);
  });
}
