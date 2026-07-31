import 'package:delivery_app/features/orders/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'push_notification_contracts.dart';

final notificationWakeEpochProvider = StateProvider<int>((ref) => 0);

abstract interface class CustomerPushWakeCoordinatorPort {
  void handle(PushWakeSignal signal);
}

class RiverpodCustomerPushWakeCoordinator
    implements CustomerPushWakeCoordinatorPort {
  RiverpodCustomerPushWakeCoordinator(this._ref);

  final Ref _ref;

  @override
  void handle(PushWakeSignal signal) {
    _ref.read(notificationWakeEpochProvider.notifier).state += 1;
    // Invalidation refreshes an already-visible order list and guarantees the
    // next visit fetches REST state. Push payload never mutates an order.
    _ref.invalidate(ordersListProvider);

    if (signal.relatedEntityType == 'ORDER' && signal.relatedEntityId != null) {
      _ref.invalidate(orderDetailProvider(signal.relatedEntityId!));
    }
  }
}

final customerPushWakeCoordinatorProvider =
    Provider<CustomerPushWakeCoordinatorPort>(
      (ref) => RiverpodCustomerPushWakeCoordinator(ref),
    );
