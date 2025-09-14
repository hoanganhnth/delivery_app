import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/tracking_usecases.dart';
import 'delivery_tracking_state.dart';

/// Notifier để quản lý delivery tracking
class DeliveryTrackingNotifier extends StateNotifier<DeliveryTrackingState> {
  final ConnectDeliveryTrackingUseCase _connectUseCase;
  // final StartDeliveryTrackingUseCase _startTrackingUseCase;
  final StopDeliveryTrackingUseCase _stopTrackingUseCase;
  final RefreshDeliveryTrackingUseCase _refreshUseCase;
  
  // Removed _repository - using UseCase only for Clean Architecture
  
  DeliveryTrackingNotifier({
    required ConnectDeliveryTrackingUseCase connectUseCase,
    required StartDeliveryTrackingUseCase startTrackingUseCase,
    required StopDeliveryTrackingUseCase stopTrackingUseCase,
    required RefreshDeliveryTrackingUseCase refreshUseCase,
  }) : _connectUseCase = connectUseCase,
      //  _startTrackingUseCase = startTrackingUseCase,
       _stopTrackingUseCase = stopTrackingUseCase,
       _refreshUseCase = refreshUseCase,
       super(const DeliveryTrackingState());



  /// Kết nối đến service thông qua UseCase
  Future<void> connect() async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      AppLogger.i('Connecting to delivery tracking...');
      
      final result = await _connectUseCase(NoParams());
      
      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
          );
        },
        (_) {
          state = state.copyWith(
            isLoading: false,
            isConnected: true,
          );
        },
      );
      
    } catch (e) {
      AppLogger.e('Failed to connect delivery tracking', e);
      state = state.copyWith(
        isLoading: false,
        error: 'Không thể kết nối dịch vụ theo dõi delivery',
      );
    }
  }

  /// Bắt đầu theo dõi order thông qua UseCase
  // Future<void> startTrackingOrder(int orderId) async {
  //   try {
  //     AppLogger.i('Starting tracking for order $orderId');
      
  //     if (!state.isConnected) {
  //       await connect();
  //     }

  //     if (!state.isConnected) {
  //       throw Exception('Chưa kết nối được dịch vụ theo dõi');
  //     }

  //     state = state.copyWith(
  //       isTracking: true,
  //       clearError: true,
  //       clearTracking: true,
  //       clearShipperLocation: true,
  //     );

  //     final result = await _startTrackingUseCase(
  //       StartDeliveryTrackingParams(orderId: orderId),
  //     );
      
  //     result.fold(
  //       (failure) {
  //         state = state.copyWith(
  //           isTracking: false,
  //           error: failure.message,
  //         );
  //       },
  //       (_) {
  //         AppLogger.i('Successfully started tracking order $orderId');
  //       },
  //     );
      
  //   } catch (e) {
  //     AppLogger.e('Failed to start tracking order $orderId', e);
  //     state = state.copyWith(
  //       isTracking: false,
  //       error: 'Không thể bắt đầu theo dõi order: ${e.toString()}',
  //     );
  //   }
  // }

  /// Dừng theo dõi order thông qua UseCase
  Future<void> stopTrackingOrder() async {
    try {
      AppLogger.i('Stopping delivery tracking');
      
      final result = await _stopTrackingUseCase(NoParams());
      
      result.fold(
        (failure) {
          state = state.copyWith(
            error: failure.message,
          );
        },
        (_) {
          state = state.copyWith(
            isTracking: false,
            clearTracking: true,
            clearShipperLocation: true,
            clearError: true,
          );
        },
      );
      
    } catch (e) {
      AppLogger.e('Error stopping delivery tracking', e);
      state = state.copyWith(
        error: 'Lỗi khi dừng theo dõi delivery',
      );
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
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
          );
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

  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Get mock shipper info
  dynamic getMockShipper() {
    AppLogger.w('getMockShipper called - should implement proper API call');
    return null; // TODO: Implement proper shipper API
  }

  @override
  void dispose() {
    AppLogger.i('Disposing delivery tracking notifier');
    stopTrackingOrder();
    // Clean Architecture: Notifier only calls UseCases
    // Connection management is handled by UseCase layer
    
    super.dispose();
  }
}
