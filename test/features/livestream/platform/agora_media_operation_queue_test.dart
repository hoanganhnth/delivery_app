import 'dart:async';

import 'package:delivery_app/features/livestream/platform/agora_media_operation_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('runs Agora lifecycle operations one at a time', () async {
    final queue = AgoraMediaOperationQueue();
    final first = Completer<void>();
    final events = <String>[];

    final firstRun = queue.run(() async {
      events.add('first-start');
      await first.future;
      events.add('first-end');
    });
    final secondRun = queue.run(() async {
      events.add('second-start');
    });

    await Future<void>.delayed(Duration.zero);
    expect(events, ['first-start']);
    first.complete();
    await Future.wait([firstRun, secondRun]);

    expect(events, ['first-start', 'first-end', 'second-start']);
  });

  test('a failed operation does not poison the lifecycle queue', () async {
    final queue = AgoraMediaOperationQueue();
    final failed = queue.run(() async => throw StateError('init failed'));
    final events = <String>[];
    final recovered = queue.run(() async => events.add('recovered'));

    await expectLater(failed, throwsStateError);
    await recovered;

    expect(events, ['recovered']);
  });
}
