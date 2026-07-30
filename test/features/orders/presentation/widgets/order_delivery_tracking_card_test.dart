import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_status.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_tracking_entity.dart';
import 'package:delivery_app/features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'package:delivery_app/features/orders/presentation/providers/delivery_tracking/delivery_tracking_providers.dart';
import 'package:delivery_app/features/orders/presentation/widgets/track_order/order_delivery_tracking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  testWidgets(
    'tracking card cancels its injected refresh when leaving the UI',
    (tester) async {
      final scheduler = _FakeTrackingScheduler();
      await pumpTestApp(
        tester,
        overrides: [
          trackingSchedulerProvider.overrideWithValue(scheduler),
          deliveryTrackingRepositoryProvider.overrideWithValue(
            _FindingShipperRepository(),
          ),
        ],
        child: SingleChildScrollView(
          child: OrderDeliveryTrackingCard(order: buildOrder()),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(scheduler.tasks, hasLength(1));
      expect(scheduler.tasks.single.cancelled, isFalse);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      expect(scheduler.tasks.single.cancelled, isTrue);
    },
  );
}

class _FindingShipperRepository implements DeliveryTrackingRepository {
  @override
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(
    int orderId,
  ) async {
    return Right(
      buildDeliveryTracking(
        orderId: orderId,
        shipperId: null,
        status: DeliveryStatus.findingShipper,
        shipperCurrentLat: null,
        shipperCurrentLng: null,
      ),
    );
  }
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
