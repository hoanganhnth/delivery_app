import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/tracking_usecases.dart';
import '../../domain/repositories/delivery_tracking_repository.dart';
// TODO: Add these imports back when DTOs are ready
// import '../../domain/entities/delivery_tracking_entity.dart';
// import '../../domain/entities/shipper_location_entity.dart';
import 'delivery_tracking_state.dart';

/// Notifier để quản lý delivery tracking
class DeliveryTrackingNotifier extends StateNotifier<DeliveryTrackingState> {
  final ConnectDeliveryTrackingUseCase _connectUseCase;
  final StartDeliveryTrackingUseCase _startTrackingUseCase;
  final StopDeliveryTrackingUseCase _stopTrackingUseCase;
  final RefreshDeliveryTrackingUseCase _refreshUseCase;
  final DeliveryTrackingRepository _repository;
  
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;
  StreamSubscription<bool>? _connectionSubscription;
  
  DeliveryTrackingNotifier({
    required ConnectDeliveryTrackingUseCase connectUseCase,
    required StartDeliveryTrackingUseCase startTrackingUseCase,
    required StopDeliveryTrackingUseCase stopTrackingUseCase,
    required RefreshDeliveryTrackingUseCase refreshUseCase,
    required DeliveryTrackingRepository repository,
  }) : _connectUseCase = connectUseCase,
       _startTrackingUseCase = startTrackingUseCase,
       _stopTrackingUseCase = stopTrackingUseCase,
       _refreshUseCase = refreshUseCase,
       _repository = repository,
       super(const DeliveryTrackingState()) {
    _initializeService();
  }

  /// Khởi tạo service và listeners
  Future<void> _initializeService() async {
    try {
      AppLogger.i('Initializing delivery tracking service...');
      
      // Listen to connection changes từ repository
      _connectionSubscription = _repository.connectionStream.listen(
        (isConnected) {
          AppLogger.d('Connection status changed: $isConnected');
          state = state.copyWith(isConnected: isConnected, clearError: true);
          
          if (!isConnected) {
            // Clear tracking when disconnected
            state = state.copyWith(
              isTracking: false,
              clearTracking: true,
              clearShipperLocation: true,
            );
          }
        },
        onError: (error) {
          AppLogger.e('Error in connection stream', error);
          state = state.copyWith(
            error: 'Lỗi kết nối: ${error.toString()}',
          );
        },
      );
      
      // Listen to delivery updates từ repository
      // TODO: Uncomment when DeliveryTrackingEntity is ready
      // _messageSubscription = _repository.deliveryStream.listen(
      //   (deliveryEntity) {
      //     AppLogger.d('Received delivery update: ${deliveryEntity.status}');
      //     
      //     state = state.copyWith(
      //       currentTracking: deliveryEntity,
      //       clearError: true,
      //     );
      //   },
      //   onError: (error) {
      //     AppLogger.e('Error in delivery stream', error);
      //     state = state.copyWith(
      //       error: 'Lỗi nhận dữ liệu delivery: ${error.toString()}',
      //     );
      //   },
      // );

      AppLogger.i('Delivery tracking service initialized successfully');

    } catch (e) {
      AppLogger.e('Failed to initialize delivery tracking service', e);
      state = state.copyWith(
        error: 'Không thể khởi tạo dịch vụ theo dõi delivery',
      );
    }
  }

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
  Future<void> startTrackingOrder(int orderId) async {
    try {
      AppLogger.i('Starting tracking for order $orderId');
      
      if (!state.isConnected) {
        await connect();
      }

      if (!state.isConnected) {
        throw Exception('Chưa kết nối được dịch vụ theo dõi');
      }

      state = state.copyWith(
        isTracking: true,
        clearError: true,
        clearTracking: true,
        clearShipperLocation: true,
      );

      final result = await _startTrackingUseCase(
        StartDeliveryTrackingParams(orderId: orderId),
      );
      
      result.fold(
        (failure) {
          state = state.copyWith(
            isTracking: false,
            error: failure.message,
          );
        },
        (_) {
          AppLogger.i('Successfully started tracking order $orderId');
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
    
    // Cancel subscriptions
    _messageSubscription?.cancel();
    _connectionSubscription?.cancel();
    
    // Stop tracking and disconnect through repository
    _repository.disconnect();
    
    super.dispose();
  }
}
