import 'package:delivery_app/core/services/push/customer_push_wake_coordinator.dart';
import 'package:delivery_app/core/services/push/push_notification_contracts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'customer wake invalidates REST-backed state without applying payload',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(customerPushWakeCoordinatorProvider)
          .handle(
            const PushWakeSignal(
              notificationId: 77,
              type: 'DELIVERY_DELIVERING',
              relatedEntityId: 601,
              relatedEntityType: 'ORDER',
            ),
          );

      expect(container.read(notificationWakeEpochProvider), 1);
    },
  );
}
