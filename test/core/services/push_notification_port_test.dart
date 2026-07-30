import 'package:delivery_app/core/services/push_notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes/fake_push_notification_port.dart';

void main() {
  test('app-facing push port can be replaced without constructing Firebase', () async {
    final fake = FakePushNotificationPort();
    final container = ProviderContainer(
      overrides: [pushNotificationPortProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);

    final port = container.read(pushNotificationPortProvider);
    await port.initialize(authenticated: false);
    await port.updateAuthentication(true);
    await port.unregisterToken();

    expect(fake.initializeCalls, [false]);
    expect(fake.authenticationUpdates, [true]);
    expect(fake.unregisterCalls, 1);
  });
}
