import 'dart:async';

import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/repositories/delivery_tracking_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'package:delivery_app/features/orders/domain/usecases/get_current_delivery_usecase.dart';

abstract interface class TrackingPeriodicTask {
  void cancel();
}

abstract interface class TrackingSchedulerPort {
  TrackingPeriodicTask schedulePeriodic(
    Duration interval,
    FutureOr<void> Function() callback,
  );
}

class DartTrackingScheduler implements TrackingSchedulerPort {
  const DartTrackingScheduler();

  @override
  TrackingPeriodicTask schedulePeriodic(
    Duration interval,
    FutureOr<void> Function() callback,
  ) {
    return _DartTrackingPeriodicTask(
      Timer.periodic(interval, (_) => callback()),
    );
  }
}

class _DartTrackingPeriodicTask implements TrackingPeriodicTask {
  _DartTrackingPeriodicTask(this._timer);

  final Timer _timer;

  @override
  void cancel() => _timer.cancel();
}

final trackingSchedulerProvider = Provider<TrackingSchedulerPort>(
  (ref) => const DartTrackingScheduler(),
);

/// Network providers
final deliveryTrackingApiServiceProvider = Provider((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return DeliveryTrackingApiService(dio);
});

final deliveryTrackingRemoteDataSourceProvider = Provider((ref) {
  final apiService = ref.watch(deliveryTrackingApiServiceProvider);
  return DeliveryTrackingRemoteDataSourceImpl(apiService);
});

/// Repository Provider - Di chuyển từ core về feature
final deliveryTrackingRepositoryProvider = Provider<DeliveryTrackingRepository>(
  (ref) {
    final remoteDataSource = ref.watch(
      deliveryTrackingRemoteDataSourceProvider,
    );
    return DeliveryTrackingRepositoryImpl(remoteDataSource);
  },
);

final getCurrentDeliveryUseCaseProvider = Provider<GetCurrentDeliveryUseCase>((
  ref,
) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return GetCurrentDeliveryUseCase(repository);
});
