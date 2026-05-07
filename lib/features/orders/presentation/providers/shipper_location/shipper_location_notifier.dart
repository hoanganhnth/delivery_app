import 'dart:async';
import 'package:delivery_app/core/error/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import '../../../domain/usecases/tracking_usecases.dart';
import '../../../domain/entities/shipper_location_entity.dart';
import 'shipper_location_providers.dart';
import 'shipper_location_state.dart';

part 'shipper_location_notifier.g.dart';

/// Notifier để quản lý shipper location tracking
@Riverpod(keepAlive: true)
class ShipperLocation extends _$ShipperLocation {
  StreamSubscription<ShipperLocationEntity>? _locationSubscription;

  @override
  ShipperLocationState build() {
    AppLogger.i('ShipperLocationNotifier created');

    // Đọc provider ra ngoài trước khi onDispose để tránh lỗi Riverpod cấm dùng ref.read bên trong onDispose
    final stopTrackingUseCase = ref.read(stopShipperTrackingUseCaseProvider);

    ref.onDispose(() {
      AppLogger.i('Disposing shipper location notifier');

      // Chỉ gửi yêu cầu dừng lên backend và huỷ subscription.
      if (state.isTracking) {
        try {
          stopTrackingUseCase.call(NoParams());
        } catch (_) {}
      }

      _locationSubscription?.cancel();
      _locationSubscription = null;
    });

    return const ShipperLocationState();
  }

  /// Bắt đầu theo dõi shipper location thông qua UseCase
  Future<void> startTrackingShipper(int shipperId) async {
    try {
      // Stop previous tracking if any
      await stopTracking();

      state = state.copyWith(
        isLoading: true,
        trackingShipperId: shipperId,
        failure: null,
        currentLocation: null,
      );

      final trackShipperUseCase = ref.read(trackShipperLocationUseCaseProvider);
      final getShipperLocationUseCase = ref.read(getShipperLocationUseCaseProvider);

      // 1. Fetch initial location via REST
      final initialResult = await getShipperLocationUseCase(shipperId);
      
      if (!ref.mounted) return;
      
      initialResult.fold(
        (failure) => AppLogger.w('Fetch initial location failed: ${failure.message}'),
        (location) {
          AppLogger.i('Fetched initial location for shipper: $shipperId');
          state = state.copyWith(currentLocation: location);
        },
      );

      // 2. Start real-time stream
      final streamResult = await trackShipperUseCase(
        TrackShipperParams(shipperId: shipperId),
      );

      if (!ref.mounted) return;

      streamResult.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            isTracking: false,
            failure: failure,
          );
        },
        (locationStream) {
          state = state.copyWith(
            isLoading: false,
            isTracking: true,
            isConnected: true,
          );

          // Listen to location updates
          _locationSubscription = locationStream.listen(
            (location) {
              if (!ref.mounted) return;
              state = state.copyWith(
                currentLocation: location,
                failure: null,
              );
            },
            onError: (error) {
              AppLogger.e('Error in shipper location stream', error);
              if (!ref.mounted) return;
              state = state.copyWith(
                failure: Failure.server('Lỗi nhận dữ liệu vị trí shipper: ${error.toString()}'),
              );
            },
            onDone: () {
              AppLogger.i('Shipper location stream closed');
              if (!ref.mounted) return;
              state = state.copyWith(isTracking: false, isConnected: false);
            },
          );
        },
      );
    } catch (e) {
      AppLogger.e('Failed to start shipper tracking: $shipperId', e);
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        isTracking: false,
        failure: Failure.server('Không thể bắt đầu theo dõi shipper: ${e.toString()}'),
      );
    }
  }

  /// Dừng theo dõi shipper location
  Future<void> stopTracking() async {
    try {
      AppLogger.i('Stopping shipper location tracking');

      // Cancel local subscription
      await _locationSubscription?.cancel();
      _locationSubscription = null;

      final stopTrackingUseCase = ref.read(stopShipperTrackingUseCaseProvider);
      final result = await stopTrackingUseCase(NoParams());

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          state = state.copyWith(failure: failure);
        },
        (_) {
          state = state.copyWith(
            isTracking: false,
            isConnected: false,
            trackingShipperId: null,
            currentLocation: null,
            failure: null,
          );
        },
      );
    } catch (e) {
      AppLogger.e('Error stopping shipper tracking', e);
      if (!ref.mounted) return;
      state = state.copyWith(failure: const Failure.server('Lỗi khi dừng theo dõi shipper'));
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(failure: null);
  }

  /// Refresh tracking (restart with current shipper)
  Future<void> refresh() async {
    try {
      AppLogger.i('Refreshing shipper location tracking');

      final currentShipperId = state.trackingShipperId;
      if (currentShipperId != null) {
        state = state.copyWith(isLoading: true, failure: null);
        await startTrackingShipper(currentShipperId);
      } else {
        AppLogger.w('No current shipper to refresh tracking for');

        state = state.copyWith(
          failure: const Failure.server('Không có shipper nào đang được theo dõi để refresh'),
        );
      }
    } catch (e) {
      AppLogger.e('Failed to refresh shipper tracking', e);
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        failure: const Failure.server('Không thể làm mới tracking shipper'),
      );
    }
  }
}
