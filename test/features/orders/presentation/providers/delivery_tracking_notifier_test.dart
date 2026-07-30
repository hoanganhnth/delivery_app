import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/orders/data/services/mapbox_map_service.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_tracking_entity.dart';
import 'package:delivery_app/features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'package:delivery_app/features/orders/presentation/providers/delivery_tracking/delivery_tracking_notifier.dart';
import 'package:delivery_app/features/orders/presentation/providers/delivery_tracking/delivery_tracking_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'tracking refresh uses injected scheduler and tears it down explicitly',
    () async {
      final repository = _FakeDeliveryTrackingRepository();
      final scheduler = _FakeTrackingScheduler();
      final directions = _FakeDirections();
      final container = _container(repository, scheduler, directions);
      final subscription = container.listen(
        deliveryTrackingProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);
      addTearDown(container.dispose);

      await container
          .read(deliveryTrackingProvider.notifier)
          .startTrackingOrderSafe(601, trackingRealtime: true);

      expect(repository.requestedOrderIds, [601]);
      expect(container.read(deliveryTrackingProvider).isTracking, isTrue);
      expect(container.read(deliveryTrackingProvider).isConnected, isTrue);
      expect(scheduler.intervals, [const Duration(seconds: 15)]);
      expect(directions.calls, hasLength(1));
      expect(container.read(deliveryTrackingProvider).polylinePoints, [
        [106.70, 10.77],
        [106.7009, 10.7769],
      ]);

      await scheduler.tasks.single.tick();
      expect(repository.requestedOrderIds, [601, 601]);

      await container
          .read(deliveryTrackingProvider.notifier)
          .startTrackingOrderSafe(601, trackingRealtime: true);
      expect(repository.requestedOrderIds, [601, 601]);
      expect(scheduler.tasks, hasLength(1));

      await container
          .read(deliveryTrackingProvider.notifier)
          .stopTrackingOrder();
      expect(scheduler.tasks.single.cancelled, isTrue);
      expect(container.read(deliveryTrackingProvider).isTracking, isFalse);
      expect(container.read(deliveryTrackingProvider).currentTracking, isNull);
    },
  );

  test(
    'tracking failure remains observable and the same order can retry',
    () async {
      final repository = _FakeDeliveryTrackingRepository()
        ..results.add(const Left(NetworkFailure('Mất kết nối tracking')))
        ..results.add(Right(buildDeliveryTracking()));
      final container = _container(
        repository,
        _FakeTrackingScheduler(),
        _FakeDirections(),
      );
      final subscription = container.listen(
        deliveryTrackingProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);
      addTearDown(container.dispose);
      final notifier = container.read(deliveryTrackingProvider.notifier);

      await notifier.startTrackingOrderSafe(601, trackingRealtime: false);
      expect(
        container.read(deliveryTrackingProvider).failure?.message,
        'Mất kết nối tracking',
      );

      await notifier.startTrackingOrderSafe(601, trackingRealtime: false);
      expect(container.read(deliveryTrackingProvider).failure, isNull);
      expect(
        container.read(deliveryTrackingProvider).currentTracking?.orderId,
        601,
      );
      expect(repository.requestedOrderIds, [601, 601]);
    },
  );

  test('provider disposal cancels an active periodic refresh', () async {
    final scheduler = _FakeTrackingScheduler();
    final container = _container(
      _FakeDeliveryTrackingRepository(),
      scheduler,
      _FakeDirections(),
    );
    final subscription = container.listen(deliveryTrackingProvider, (_, _) {});

    await container
        .read(deliveryTrackingProvider.notifier)
        .startTrackingOrderSafe(601, trackingRealtime: true);
    subscription.close();
    container.invalidate(deliveryTrackingProvider);
    await Future<void>.delayed(Duration.zero);

    expect(scheduler.tasks.single.cancelled, isTrue);
    container.dispose();
  });

  test('stop wins over a late in-flight tracking response', () async {
    final repository = _DeferredDeliveryTrackingRepository();
    final scheduler = _FakeTrackingScheduler();
    final container = ProviderContainer(
      overrides: [
        deliveryTrackingRepositoryProvider.overrideWithValue(repository),
        trackingSchedulerProvider.overrideWithValue(scheduler),
        mapboxMapServiceProvider.overrideWithValue(_FakeDirections()),
      ],
    );
    final subscription = container.listen(deliveryTrackingProvider, (_, _) {});
    addTearDown(subscription.close);
    addTearDown(container.dispose);
    final notifier = container.read(deliveryTrackingProvider.notifier);

    final start = notifier.startTrackingOrderSafe(601, trackingRealtime: true);
    await Future<void>.delayed(Duration.zero);
    await notifier.stopTrackingOrder();
    repository.pending.complete(Right(buildDeliveryTracking()));
    await start;

    expect(container.read(deliveryTrackingProvider).currentTracking, isNull);
    expect(container.read(deliveryTrackingProvider).isTracking, isFalse);
    expect(scheduler.tasks, isEmpty);
  });
}

ProviderContainer _container(
  _FakeDeliveryTrackingRepository repository,
  _FakeTrackingScheduler scheduler,
  DirectionsPort directions,
) {
  return ProviderContainer(
    overrides: [
      deliveryTrackingRepositoryProvider.overrideWithValue(repository),
      trackingSchedulerProvider.overrideWithValue(scheduler),
      mapboxMapServiceProvider.overrideWithValue(directions),
    ],
  );
}

class _FakeDeliveryTrackingRepository implements DeliveryTrackingRepository {
  final List<Either<Failure, DeliveryTrackingEntity>> results = [];
  final List<int> requestedOrderIds = [];

  @override
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(
    int orderId,
  ) async {
    requestedOrderIds.add(orderId);
    if (results.isNotEmpty) return results.removeAt(0);
    return Right(buildDeliveryTracking(orderId: orderId));
  }
}

class _DeferredDeliveryTrackingRepository
    implements DeliveryTrackingRepository {
  final Completer<Either<Failure, DeliveryTrackingEntity>> pending =
      Completer();

  @override
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(
    int orderId,
  ) => pending.future;
}

class _FakeDirections implements DirectionsPort {
  final List<(List<double>, List<double>)> calls = [];

  @override
  Future<Map<String, dynamic>> getDirections({
    required List<double> origin,
    required List<double> destination,
    String geometries = 'geojson',
  }) async {
    calls.add((origin, destination));
    return {
      'routes': [
        {
          'geometry': {
            'coordinates': [origin, destination],
          },
        },
      ],
    };
  }
}

class _FakeTrackingScheduler implements TrackingSchedulerPort {
  final List<Duration> intervals = [];
  final List<_FakeTrackingTask> tasks = [];

  @override
  TrackingPeriodicTask schedulePeriodic(
    Duration interval,
    FutureOr<void> Function() callback,
  ) {
    intervals.add(interval);
    final task = _FakeTrackingTask(callback);
    tasks.add(task);
    return task;
  }
}

class _FakeTrackingTask implements TrackingPeriodicTask {
  _FakeTrackingTask(this._callback);

  final FutureOr<void> Function() _callback;
  bool cancelled = false;

  Future<void> tick() async {
    if (cancelled) return;
    await _callback();
  }

  @override
  void cancel() => cancelled = true;
}
