import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/logger/app_logger.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import '../../../domain/usecases/tracking_usecases.dart';
import '../../../domain/entities/shipper_location_entity.dart';
import 'shipper_location_providers.dart';
import 'shipper_location_state.dart';

part 'shipper_location_notifier.g.dart';

/// Notifier để quản lý shipper location tracking
@riverpod
class ShipperLocation extends _$ShipperLocation {
  StreamSubscription<ShipperLocationEntity>? _locationSubscription;

  @override
  ShipperLocationState build() {
    AppLogger.i('ShipperLocationNotifier created');
    
    ref.onDispose(() {
      AppLogger.i('Disposing shipper location notifier');
      if (state.isTracking) {
        stopTracking();
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
        clearError: true,
        clearLocation: true,
      );

      final trackShipperUseCase = ref.read(trackShipperLocationUseCaseProvider);
      final streamResult = await trackShipperUseCase(
        TrackShipperParams(shipperId: shipperId),
      );

      streamResult.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            isTracking: false,
            error: failure.message,
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
              state = state.copyWith(
                currentLocation: location,
                clearError: true,
              );
            },
            onError: (error) {
              AppLogger.e('Error in shipper location stream', error);
              state = state.copyWith(
                error: 'Lỗi nhận dữ liệu vị trí shipper: ${error.toString()}',
              );
            },
            onDone: () {
              AppLogger.i('Shipper location stream closed');
              state = state.copyWith(isTracking: false, isConnected: false);
            },
          );
        },
      );
    } catch (e) {
      AppLogger.e('Failed to start shipper tracking: $shipperId', e);
      state = state.copyWith(
        isLoading: false,
        isTracking: false,
        error: 'Không thể bắt đầu theo dõi shipper: ${e.toString()}',
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

      result.fold(
        (failure) {
          state = state.copyWith(error: failure.message);
        },
        (_) {
          state = state.copyWith(
            isTracking: false,
            isConnected: false,
            trackingShipperId: null,
            clearLocation: true,
            clearError: true,
          );
        },
      );
    } catch (e) {
      AppLogger.e('Error stopping shipper tracking', e);
      state = state.copyWith(error: 'Lỗi khi dừng theo dõi shipper');
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Refresh tracking (restart with current shipper)
  Future<void> refresh() async {
    try {
      AppLogger.i('Refreshing shipper location tracking');

      final currentShipperId = state.trackingShipperId;
      if (currentShipperId != null) {
        state = state.copyWith(isLoading: true, clearError: true);
        await startTrackingShipper(currentShipperId);
      } else {
        AppLogger.w('No current shipper to refresh tracking for');
        state = state.copyWith(
          error: 'Không có shipper nào đang được theo dõi để refresh',
        );
      }
    } catch (e) {
      AppLogger.e('Failed to refresh shipper tracking', e);
      state = state.copyWith(
        isLoading: false,
        error: 'Không thể làm mới tracking shipper',
      );
    }
  }
}
