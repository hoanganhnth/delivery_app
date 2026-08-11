import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/orders/application/order_tracking_intent.dart';
import 'package:delivery_app/features/orders/application/order_tracking_state.dart';
import 'package:delivery_app/features/orders/application/order_tracking_view_model.dart';
import 'package:delivery_app/features/orders/data/services/mapbox_map_service.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_tracking_entity.dart';
import 'package:delivery_app/features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'package:delivery_app/features/orders/di/delivery_tracking_providers.dart';
import 'package:delivery_app/features/orders/application/state/tracking/shipper_location_notifier.dart';
import 'package:delivery_app/features/orders/application/state/tracking/shipper_location_state.dart';
import 'package:delivery_app/features/orders/presentation/views/order_tracking_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  test('tracking ViewModel owns polling and shipper socket leases', () async {
    final scheduler = _FakeTrackingScheduler();
    final shipper = _FakeShipperLocation();
    final container = ProviderContainer(
      overrides: [
        deliveryTrackingRepositoryProvider.overrideWithValue(
          _FakeDeliveryTrackingRepository(),
        ),
        trackingSchedulerProvider.overrideWithValue(scheduler),
        mapboxMapServiceProvider.overrideWithValue(_FakeDirections()),
        shipperLocationProvider.overrideWith(() => shipper),
      ],
    );
    addTearDown(container.dispose);
    final provider = orderTrackingViewModelProvider(
      const OrderTrackingTarget(orderId: 601, trackingRealtime: true),
    );
    final notifier = container.read(provider.notifier);

    await notifier.dispatch(const OrderTrackingStartRequested());

    expect(scheduler.tasks, hasLength(1));
    expect(shipper.started, [(701, 801)]);
    expect(container.read(provider).phase, OrderTrackingPhase.driverAssigned);

    await notifier.dispatch(const OrderTrackingStopRequested());
    expect(scheduler.tasks.single.cancelled, isTrue);
    expect(shipper.cancelLeaseCalls, 1);
  });

  testWidgets(
    'tracking view emits retry and dismiss intents without platform I/O',
    (tester) async {
      final intents = <OrderTrackingIntent>[];
      await pumpTestApp(
        tester,
        child: OrderTrackingView(
          state: const OrderTrackingViewState(
            isConnected: true,
            phase: OrderTrackingPhase.delivering,
            errorMessage: 'Mất kết nối tạm thời',
          ),
          map: const SizedBox(key: Key('tracking_map_bridge')),
          onIntent: intents.add,
        ),
      );

      expect(find.byKey(const Key('tracking_map_bridge')), findsOneWidget);
      await tester.tap(find.text('Thử lại'));
      await tester.tap(find.byTooltip('Đóng'));

      expect(intents[0], isA<OrderTrackingRetryRequested>());
      expect(intents[1], isA<OrderTrackingErrorDismissed>());
    },
  );
}

class _FakeDeliveryTrackingRepository implements DeliveryTrackingRepository {
  @override
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(
    int orderId,
  ) async => Right(buildDeliveryTracking(orderId: orderId));
}

class _FakeTrackingScheduler implements TrackingSchedulerPort {
  final List<_FakeTrackingTask> tasks = [];

  @override
  TrackingPeriodicTask schedulePeriodic(
    Duration interval,
    FutureOr<void> Function() callback,
  ) {
    final task = _FakeTrackingTask();
    tasks.add(task);
    return task;
  }
}

class _FakeTrackingTask implements TrackingPeriodicTask {
  bool cancelled = false;

  @override
  void cancel() => cancelled = true;
}

class _FakeDirections implements DirectionsPort {
  @override
  Future<Map<String, dynamic>> getDirections({
    required List<double> origin,
    required List<double> destination,
    String geometries = 'geojson',
  }) async => {
    'routes': [
      {
        'geometry': {
          'coordinates': [origin, destination],
        },
      },
    ],
  };
}

class _FakeShipperLocation extends ShipperLocation {
  final List<(int, int)> started = [];
  int cancelLeaseCalls = 0;

  @override
  ShipperLocationState build() => const ShipperLocationState();

  @override
  Future<void> startTrackingShipper(int shipperId, int deliveryId) async {
    started.add((shipperId, deliveryId));
  }

  @override
  void cancelTrackingLease() {
    cancelLeaseCalls += 1;
  }
}
