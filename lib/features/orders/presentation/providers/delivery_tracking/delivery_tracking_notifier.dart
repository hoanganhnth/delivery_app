import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import '../../../domain/usecases/tracking_usecases.dart';
import '../../../domain/usecases/get_current_delivery_usecase.dart';
import 'delivery_tracking_providers.dart';
import '../shipper_providers.dart';
import 'delivery_tracking_state.dart';
import '../../../data/services/mapbox_map_service.dart';
import '../../../domain/entities/delivery_status.dart';
import '../../../domain/entities/delivery_tracking_entity.dart';

part 'delivery_tracking_notifier.g.dart';

/// Notifier để quản lý delivery tracking
@riverpod
class DeliveryTracking extends _$DeliveryTracking {
  /// ✅ Lưu subscription để có thể cancel khi cần
  StreamSubscription<dynamic>? _deliverySubscription;

  @override
  DeliveryTrackingState build() {
    // ✅ Tự động cancel subscription khi provider bị dispose (người dùng rời khỏi màn hình)
    ref.onDispose(() {
      AppLogger.d(
        'DeliveryTracking provider disposed — cancelling stream subscription',
      );
      _deliverySubscription?.cancel();
      _deliverySubscription = null;
    });
    return const DeliveryTrackingState();
  }

  /// Bắt đầu theo dõi order - ưu tiên sử dụng getCurrentDelivery trước
  Future<void> startTrackingOrderSafe(
    int orderId, {
    bool trackingRealtime = false,
  }) async {
    // Kiểm tra nếu đã đang track order này
    if (state.currentTracking?.orderId == orderId && state.isTracking) {
      AppLogger.d('Already tracking order $orderId, skipping duplicate call');
      return;
    }

    // Bước 1: Lấy delivery hiện tại qua REST API trước
    await getCurrentDelivery(orderId);

    // Bước 2: Nếu cần real-time updates, start WebSocket tracking
    if (state.currentTracking != null && trackingRealtime) {
      AppLogger.i('Starting real-time tracking for order: $orderId');
      await startTrackingOrder(orderId);
    }
  }

  /// Bắt đầu theo dõi order thông qua UseCase (WebSocket)
  Future<void> startTrackingOrder(int orderId) async {
    try {
      AppLogger.i('Starting tracking for order $orderId');

      state = state.copyWith(isTracking: true, clearError: true);

      final startTrackingUseCase = ref.read(trackDeliveryUseCaseProvider);
      final result = await startTrackingUseCase(
        TrackDeliveryParams(orderId: orderId),
      );

      result.fold(
        (failure) {
          state = state.copyWith(isTracking: false, error: failure.message);
        },
        (deliveryStream) {
          state = state.copyWith(
            isLoading: false,
            isTracking: true,
            isConnected: true,
          );

          // ✅ Cancel subscription cũ trước khi subscribe mới — tránh nhận data cũ lọt ra
          _deliverySubscription?.cancel();
          _deliverySubscription = deliveryStream.listen(
            (delivery) {
              AppLogger.d(
                'Received delivery tracking: Order ${delivery.orderId}, Status ${delivery.status}',
              );

              // Cập nhật delivery tracking
              state = state.copyWith(
                currentTracking: delivery,
                clearError: true,
              );

              // Lấy thông tin shipper nếu là shipper ID mới
              if (delivery.shipperId != null &&
                  delivery.shipperId != state.currentShipperId) {
                _fetchShipperInfoIfNeeded(delivery.shipperId!);
              }

              // ✅ Cập nhật route polyline dựa trên vị trí mới
              _updateRoutePoints(delivery);
            },
            onError: (error) {
              state = state.copyWith(
                error: 'Lỗi nhận dữ liệu delivery: ${error.toString()}',
              );
            },
            onDone: () {
              AppLogger.i('Delivery stream closed');
              state = state.copyWith(isTracking: false, isConnected: false);
              _deliverySubscription = null;
            },
          );
        },
      );
    } catch (e) {
      AppLogger.e('Failed to start tracking order $orderId', e);
      state = state.copyWith(
        isTracking: false,
        error: 'Không thể bắt đầu theo dõi order: ${e.toString()}',
      );
    }
  }

  /// Dừng theo dõi order thông qua UseCase
  Future<void> stopTrackingOrder() async {
    try {
      AppLogger.i('Stopping delivery tracking');

      // ✅ Cancel subscription trước khi gọi UseCase
      await _deliverySubscription?.cancel();
      _deliverySubscription = null;

      final stopTrackingUseCase = ref.read(stopDeliveryTrackingUseCaseProvider);
      final result = await stopTrackingUseCase(NoParams());

      result.fold(
        (failure) {
          state = state.copyWith(error: failure.message);
        },
        (_) {
          state = state.copyWith(
            isTracking: false,
            clearTracking: true,
            clearError: true,
            clearPolyline: true,
          );
        },
      );
    } catch (e) {
      AppLogger.e('Error stopping delivery tracking', e);
      state = state.copyWith(error: 'Lỗi khi dừng theo dõi delivery');
    }
  }

  /// Làm mới kết nối thông qua UseCase
  Future<void> refresh() async {
    try {
      AppLogger.i('Refreshing delivery tracking connection');
      state = state.copyWith(isLoading: true, clearError: true);

      final refreshUseCase = ref.read(refreshDeliveryTrackingUseCaseProvider);
      final result = await refreshUseCase(NoParams());

      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.message);
        },
        (_) {
          state = state.copyWith(isLoading: false);
        },
      );
    } catch (e) {
      AppLogger.e('Failed to refresh delivery tracking', e);
      state = state.copyWith(
        isLoading: false,
        error: 'Không thể làm mới kết nối',
      );
    }
  }

  /// Lấy thông tin shipper nếu cần (shipper ID khác với hiện tại)
  Future<void> _fetchShipperInfoIfNeeded(int shipperId) async {
    // Kiểm tra xem có cần lấy thông tin shipper không
    if (state.currentShipperId == shipperId) {
      AppLogger.d('Shipper $shipperId already loaded, skipping API call');
      return;
    }

    try {
      AppLogger.i('Fetching shipper info for ID: $shipperId');

      // Bắt đầu loading shipper
      state = state.copyWith(
        isLoadingShipper: true,
        currentShipperId: shipperId,
      );

      final getShipperUseCase = ref.read(getShipperByIdUseCaseProvider);
      final result = await getShipperUseCase(shipperId);

      result.fold(
        (failure) {
          AppLogger.e('Failed to fetch shipper info: ${failure.message}');
          state = state.copyWith(
            isLoadingShipper: false,
            error: 'Không thể lấy thông tin shipper: ${failure.message}',
          );
        },
        (shipper) {
          state = state.copyWith(
            shipper: shipper,
            isLoadingShipper: false,
            clearError: true,
          );
        },
      );
    } catch (e) {
      AppLogger.e('Unexpected error fetching shipper info', e);
      state = state.copyWith(
        isLoadingShipper: false,
        error: 'Lỗi không mong muốn khi lấy thông tin shipper',
      );
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Lấy delivery tracking hiện tại qua REST API
  Future<void> getCurrentDelivery(int orderId) async {
    try {
      AppLogger.i('Getting current delivery for order: $orderId');

      state = state.copyWith(isLoading: true, clearError: true);

      final getCurrentDeliveryUseCase = ref.read(
        getCurrentDeliveryUseCaseProvider,
      );
      final result = await getCurrentDeliveryUseCase.call(
        GetCurrentDeliveryParams(orderId: orderId),
      );

      result.fold(
        (failure) {
          AppLogger.e('Failed to get current delivery: ${failure.message}');
          state = state.copyWith(isLoading: false, error: failure.message);
        },
        (delivery) {
          AppLogger.i('Successfully got current delivery for order: $orderId');
          state = state.copyWith(
            isLoading: false,
            currentTracking: delivery,
            clearError: true,
          );

          // Tự động lấy thông tin shipper nếu cần
          if (delivery.shipperId != null) {
            _fetchShipperInfoIfNeeded(delivery.shipperId!);
          }

          // ✅ Cập nhật route polyline ban đầu
          _updateRoutePoints(delivery);
        },
      );
    } catch (e) {
      AppLogger.e('Unexpected error getting current delivery', e);
      state = state.copyWith(
        isLoading: false,
        error:
            'Lỗi không mong muốn khi lấy thông tin delivery: ${e.toString()}',
      );
    }
  }

  /// ✅ Cập nhật danh sách toạ độ vẽ đường đi (Polyline) từ Mapbox
  Future<void> _updateRoutePoints(DeliveryTrackingEntity delivery) async {
    // Nếu chưa có shipper hoặc đã giao xong thì xóa polyline
    if (delivery.shipperId == null ||
        delivery.status == DeliveryStatus.delivered ||
        delivery.status == DeliveryStatus.cancelled) {
      if (state.polylinePoints != null) {
        state = state.copyWith(clearPolyline: true);
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

          state = state.copyWith(polylinePoints: polylinePoints);
          AppLogger.d('✅ Updated route polyline: ${polylinePoints.length} points');
        }
      }
    } catch (e) {
      AppLogger.e('Error updating route points: $e');
      // Không set error state ở đây để tránh làm phiền người dùng nếu lỗi Mapbox
    }
  }
}
