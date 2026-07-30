import 'package:delivery_app/core/error/failures.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import '../../../domain/usecases/get_current_delivery_usecase.dart';
import 'delivery_tracking_providers.dart';
import 'delivery_tracking_state.dart';
import '../../../data/services/mapbox_map_service.dart';
import '../../../domain/entities/delivery_status.dart';
import '../../../domain/entities/delivery_tracking_entity.dart';

part 'delivery_tracking_notifier.g.dart';

/// Notifier để quản lý delivery tracking
@Riverpod(keepAlive: true)
class DeliveryTracking extends _$DeliveryTracking {
  static const _refreshInterval = Duration(seconds: 15);
  TrackingPeriodicTask? _refreshTask;
  int? _trackedOrderId;
  int _lifecycleGeneration = 0;

  @override
  DeliveryTrackingState build() {
    ref.onDispose(() {
      _refreshTask?.cancel();
      _refreshTask = null;
    });
    return const DeliveryTrackingState();
  }

  /// Bắt đầu theo dõi order - ưu tiên sử dụng getCurrentDelivery trước
  Future<void> startTrackingOrderSafe(
    int orderId, {
    bool trackingRealtime = false,
  }) async {
    if (_trackedOrderId == orderId && state.isTracking) {
      AppLogger.d('Already tracking order $orderId, skipping duplicate call');
      return;
    }

    final generation = ++_lifecycleGeneration;
    await getCurrentDelivery(orderId, expectedGeneration: generation);

    if (!ref.mounted || generation != _lifecycleGeneration) return;
    if (state.currentTracking != null && trackingRealtime) {
      _startRestRefresh(orderId);
    }
  }

  /// Backward-compatible entry point. Delivery status is refreshed via REST.
  Future<void> startTrackingOrder(int orderId) async {
    final generation = ++_lifecycleGeneration;
    await getCurrentDelivery(orderId, expectedGeneration: generation);
    if (!ref.mounted || generation != _lifecycleGeneration) return;
    if (state.currentTracking != null) _startRestRefresh(orderId);
  }

  void _startRestRefresh(int orderId) {
    _refreshTask?.cancel();
    _trackedOrderId = orderId;
    state = state.copyWith(isTracking: true, isConnected: true);
    _refreshTask = ref
        .read(trackingSchedulerProvider)
        .schedulePeriodic(
          _refreshInterval,
          () => getCurrentDelivery(orderId, showLoading: false),
        );
  }

  Future<void> stopTrackingOrder() async {
    cancelTrackingLease();
    state = state.copyWith(
      isTracking: false,
      isConnected: false,
      currentTracking: null,
      failure: null,
      polylinePoints: null,
    );
  }

  /// Releases timers without notifying UI listeners during widget unmount.
  void cancelTrackingLease() {
    _lifecycleGeneration += 1;
    _refreshTask?.cancel();
    _refreshTask = null;
    _trackedOrderId = null;
  }

  Future<void> refresh() async {
    final orderId = _trackedOrderId ?? state.currentTracking?.orderId;
    if (orderId != null) await getCurrentDelivery(orderId);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(failure: null);
  }

  /// Lấy delivery tracking hiện tại qua REST API
  Future<void> getCurrentDelivery(
    int orderId, {
    bool showLoading = true,
    int? expectedGeneration,
  }) async {
    bool isCurrentGeneration() =>
        expectedGeneration == null ||
        expectedGeneration == _lifecycleGeneration;

    try {
      AppLogger.i('Getting current delivery for order: $orderId');

      if (showLoading && isCurrentGeneration()) {
        state = state.copyWith(isLoading: true, failure: null);
      }

      final getCurrentDeliveryUseCase = ref.read(
        getCurrentDeliveryUseCaseProvider,
      );
      final result = await getCurrentDeliveryUseCase.call(
        GetCurrentDeliveryParams(orderId: orderId),
      );

      await result.fold(
        (failure) async {
          AppLogger.e('Failed to get current delivery: ${failure.message}');
          if (ref.mounted && isCurrentGeneration()) {
            state = state.copyWith(isLoading: false, failure: failure);
          }
        },
        (delivery) async {
          AppLogger.i('Successfully got current delivery for order: $orderId');
          if (ref.mounted && isCurrentGeneration()) {
            final previousStatus = state.currentTracking?.status;
            state = state.copyWith(
              isLoading: false,
              currentTracking: delivery,
              failure: null,
            );

            if (previousStatus != delivery.status ||
                state.polylinePoints == null) {
              await _updateRoutePoints(delivery);
            }
          }
        },
      );
    } catch (e) {
      AppLogger.e('Unexpected error getting current delivery', e);
      if (ref.mounted && isCurrentGeneration()) {
        state = state.copyWith(
          isLoading: false,
          failure: ServerFailure(
            'Lỗi không mong muốn khi lấy thông tin delivery: ${e.toString()}',
          ),
        );
      }
    }
  }

  /// ✅ Cập nhật danh sách toạ độ vẽ đường đi (Polyline) từ Mapbox
  Future<void> _updateRoutePoints(DeliveryTrackingEntity delivery) async {
    // Nếu chưa có shipper hoặc đã giao xong thì xóa polyline
    if (delivery.shipperId == null ||
        delivery.status == DeliveryStatus.delivered ||
        delivery.status == DeliveryStatus.cancelled) {
      if (state.polylinePoints != null) {
        state = state.copyWith(polylinePoints: null);
      }
      return;
    }

    // Cần có vị trí shipper hiện tại để vẽ route
    if (delivery.shipperCurrentLat == null ||
        delivery.shipperCurrentLng == null) {
      return;
    }

    try {
      final origin = [delivery.shipperCurrentLng!, delivery.shipperCurrentLat!];
      List<double> destination;

      // Xác định điểm đến dựa trên trạng thái
      if (delivery.status == DeliveryStatus.assigned) {
        // Đang đi lấy hàng -> Đích là nhà hàng
        destination = [delivery.pickupLng, delivery.pickupLat];
      } else {
        // Đã lấy hàng -> Đích là nhà khách
        destination = [delivery.deliveryLng, delivery.deliveryLat];
      }

      // Gọi Mapbox Service qua Provider
      final mapboxService = ref.read(mapboxMapServiceProvider);
      final directions = await mapboxService.getDirections(
        origin: origin,
        destination: destination,
      );

      if (directions['routes'] != null &&
          (directions['routes'] as List).isNotEmpty) {
        final route = (directions['routes'] as List).first;
        final geometry = route['geometry'];

        if (geometry != null && geometry['coordinates'] != null) {
          final List<dynamic> coords = geometry['coordinates'];
          final polylinePoints = coords
              .map((c) => [c[0] as double, c[1] as double])
              .toList()
              .cast<List<double>>();

          if (ref.mounted) {
            state = state.copyWith(polylinePoints: polylinePoints);
            AppLogger.d(
              '✅ Updated route polyline: ${polylinePoints.length} points',
            );
          }
        }
      }
    } catch (e) {
      AppLogger.e('Error updating route points: $e');
      // Không set error state ở đây để tránh làm phiền người dùng nếu lỗi Mapbox
    }
  }
}
