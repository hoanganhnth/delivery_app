import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/tracking_usecases.dart';
import '../../domain/entities/shipper_location_entity.dart';
import 'shipper_location_state.dart';

/// Notifier để quản lý shipper location tracking
class ShipperLocationNotifier extends StateNotifier<ShipperLocationState> {
  // final StartShipperTrackingUseCase _startTrackingUseCase;
  final StopShipperTrackingUseCase _stopTrackingUseCase;
  final TrackShipperLocationUseCase _trackShipperUseCase;

  StreamSubscription<ShipperLocationEntity>? _locationSubscription;

  ShipperLocationNotifier({
    // required StartShipperTrackingUseCase startTrackingUseCase,
    required StopShipperTrackingUseCase stopTrackingUseCase,
    required TrackShipperLocationUseCase trackShipperUseCase,
  }) : _stopTrackingUseCase = stopTrackingUseCase,
       _trackShipperUseCase = trackShipperUseCase,
       super(const ShipperLocationState()) {
    AppLogger.i('ShipperLocationNotifier created');
  }

  /// Bắt đầu theo dõi shipper location thông qua UseCase
  Future<void> startTrackingShipper(int shipperId) async {
    try {
      // AppLogger.i('Starting shipper location tracking: $shipperId');

      // Stop previous tracking if any
      // await stopTracking();

      state = state.copyWith(
        isLoading: true,
        trackingShipperId: shipperId,
        clearError: true,
        clearLocation: true,
      );

      // Start tracking through UseCase
      // final startResult = await _startTrackingUseCase(
      //   StartShipperTrackingParams(shipperId: shipperId),
      // );

      // startResult.fold(
      //   (failure) {
      //     state = state.copyWith(
      //       isLoading: false,
      //       isTracking: false,
      //       error: failure.message,
      //     );
      //     return;
      //   },
      //   (_) {
      //     // Successfully started, now get the stream
      //   },
      // );

      // Get location stream through UseCase
      final streamResult = await _trackShipperUseCase(
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
              // AppLogger.d('Received shipper location: ${location.shipperId}');
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

      // Stop tracking through UseCase
      final result = await _stopTrackingUseCase(NoParams());

      result.fold(
        (failure) {
          // AppLogger.e('Failed to stop tracking via UseCase: ${failure.message}');
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
          // AppLogger.i('Stopped shipper location tracking successfully');
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

  @override
  void dispose() {
    AppLogger.i('Disposing shipper location notifier');
    
    // Stop tracking gracefully
    if (state.isTracking) {
      stopTracking();
    }
    
    // Cancel subscriptions
    _locationSubscription?.cancel();
    _locationSubscription = null;

    super.dispose();
  }
}
