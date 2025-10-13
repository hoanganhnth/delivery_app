import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/logger/app_logger.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import '../../../domain/usecases/tracking_usecases.dart';
import '../../../domain/usecases/get_shipper_usecase.dart';
import '../../../domain/usecases/get_current_delivery_usecase.dart';

import 'delivery_tracking_state.dart';

/// Notifier để quản lý delivery tracking
class DeliveryTrackingNotifier extends StateNotifier<DeliveryTrackingState> {
  // final ConnectDeliveryTrackingUseCase _connectUseCase;
  final TrackDeliveryUseCase _startTrackingUseCase;
  final StopDeliveryTrackingUseCase _stopTrackingUseCase;
  final RefreshDeliveryTrackingUseCase _refreshUseCase;
  final GetShipperByIdUseCase _getShipperUseCase;
  final GetCurrentDeliveryUseCase _getCurrentDeliveryUseCase;

  DeliveryTrackingNotifier({
    required ConnectDeliveryTrackingUseCase connectUseCase,
    required TrackDeliveryUseCase startTrackingUseCase,
    required StopDeliveryTrackingUseCase stopTrackingUseCase,
    required RefreshDeliveryTrackingUseCase refreshUseCase,
    required GetShipperByIdUseCase getShipperUseCase,
    required GetCurrentDeliveryUseCase getCurrentDeliveryUseCase,
  }) : //  _connectUseCase = connectUseCase,
       _startTrackingUseCase = startTrackingUseCase,
       _stopTrackingUseCase = stopTrackingUseCase,
       _refreshUseCase = refreshUseCase,
       _getShipperUseCase = getShipperUseCase,
       _getCurrentDeliveryUseCase = getCurrentDeliveryUseCase,
       super(const DeliveryTrackingState());

  // /// Kết nối đến service thông qua UseCase
  // Future<void> connect() async {
  //   try {
  //     state = state.copyWith(isLoading: true, clearError: true);
  //     AppLogger.i('Connecting to delivery tracking...');

  //     final result = await _connectUseCase(NoParams());

  //     result.fold(
  //       (failure) {
  //         state = state.copyWith(isLoading: false, error: failure.message);
  //       },
  //       (_) {
  //         state = state.copyWith(isLoading: false, isConnected: true);
  //       },
  //     );
  //   } catch (e) {
  //     AppLogger.e('Failed to connect delivery tracking', e);
  //     state = state.copyWith(
  //       isLoading: false,
  //       error: 'Không thể kết nối dịch vụ theo dõi delivery',
  //     );
  //   }
  // }

  /// Bắt đầu theo dõi order - ưu tiên sử dụng getCurrentDelivery trước
  Future<void> startTrackingOrderSafe(int orderId) async {
    // Kiểm tra nếu đã đang track order này
    if (state.currentTracking?.orderId == orderId && state.isTracking) {
      AppLogger.d('Already tracking order $orderId, skipping duplicate call');
      return;
    }

    // Bước 1: Lấy delivery hiện tại qua REST API trước
    await getCurrentDelivery(orderId);

    // Bước 2: Nếu cần real-time updates, start WebSocket tracking
    if (state.currentTracking != null) {
      AppLogger.i('Starting real-time tracking for order: $orderId');
      await startTrackingOrder(orderId);
    }
  }

  /// Bắt đầu theo dõi order thông qua UseCase (WebSocket)
  Future<void> startTrackingOrder(int orderId) async {
    try {
      AppLogger.i('Starting tracking for order $orderId');

      // if (!state.isConnected) {
      //   await connect();
      // }

      // if (!state.isConnected) {
      //   throw Exception('Chưa kết nối được dịch vụ theo dõi');
      // }

      state = state.copyWith(isTracking: true, clearError: true);

      final result = await _startTrackingUseCase(
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
          deliveryStream.listen(
            (delivery) {
              AppLogger.d(
                'Received delivery tracking: Order ${delivery.orderId}, Shipper ${delivery.shipperId}',
              );

              // Cập nhật delivery tracking
              // Lấy thông tin shipper nếu là shipper ID mới
              if (delivery.shipperId != null &&
                  delivery.shipperId != state.currentShipperId) {
                _fetchShipperInfoIfNeeded(delivery.shipperId!);
              }
              state = state.copyWith(
                currentTracking: delivery,
                clearError: true,
              );
            },
            onError: (error) {
              state = state.copyWith(
                error: 'Lỗi nhận dữ liệu delivery: ${error.toString()}',
              );
            },
            onDone: () {
              AppLogger.i('Delivery stream closed');
              state = state.copyWith(isTracking: false, isConnected: false);
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

      final result = await _stopTrackingUseCase(NoParams());

      result.fold(
        (failure) {
          state = state.copyWith(error: failure.message);
        },
        (_) {
          state = state.copyWith(
            isTracking: false,
            clearTracking: true,
            clearError: true,
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

      final result = await _refreshUseCase(NoParams());

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

      final result = await _getShipperUseCase.call(shipperId);

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

      final result = await _getCurrentDeliveryUseCase.call(
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

  /// Get mock shipper info (deprecated - use real API)
  @Deprecated('Use _fetchShipperInfoIfNeeded instead')
  dynamic getMockShipper() {
    AppLogger.w('getMockShipper called - should use _fetchShipperInfoIfNeeded');
    return null;
  }

  @override
  void dispose() {
    AppLogger.i('Disposing delivery tracking notifier');
    _stopTrackingUseCase(NoParams());
    // Clean Architecture: Notifier only calls UseCases
    // Connection management is handled by UseCase layer

    super.dispose();
  }
}
