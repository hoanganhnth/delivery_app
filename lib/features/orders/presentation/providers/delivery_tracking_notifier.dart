import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../data/services/delivery_tracking_socket_service.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/shipper_location_entity.dart';
import 'delivery_tracking_state.dart';

/// Notifier để quản lý delivery tracking
class DeliveryTrackingNotifier extends StateNotifier<DeliveryTrackingState> {
  final DeliveryTrackingSocketService _socketService;
  
  StreamSubscription<DeliveryTrackingEntity>? _deliverySubscription;
  StreamSubscription<ShipperLocationEntity>? _shipperLocationSubscription;
  StreamSubscription<bool>? _connectionSubscription;
  
  DeliveryTrackingNotifier({
    required DeliveryTrackingSocketService socketService,
  }) : _socketService = socketService,
       super(const DeliveryTrackingState()) {
    _initializeService();
  }

  /// Khởi tạo service và listeners
  Future<void> _initializeService() async {
    try {
      AppLogger.i('Initializing delivery tracking service...');
      
      // Listen to connection changes
      _connectionSubscription = _socketService.connectionStream.listen(
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
      );
      
      // Listen to delivery updates
      _deliverySubscription = _socketService.deliveryStream.listen(
        (deliveryTracking) {
          AppLogger.d('Received delivery update: ${deliveryTracking.status}');
          
          state = state.copyWith(
            currentTracking: deliveryTracking,
            clearError: true,
          );
          
          // Auto-update shipper info if not available
          if (state.shipper == null) {
            // Note: Shipper info should come from API or tracking data
            AppLogger.d('Shipper info not available, need to implement API call');
          }
        },
        onError: (error) {
          AppLogger.e('Error in delivery stream', error);
          state = state.copyWith(
            error: 'Lỗi kết nối theo dõi delivery: ${error.toString()}',
          );
        },
      );

      // Listen to shipper location updates (real-time position)
      _shipperLocationSubscription = _socketService.shipperLocationStream.listen(
        (shipperLocation) {
          AppLogger.d('Received shipper location: ${shipperLocation.latitude}, ${shipperLocation.longitude}');
          
          // Update shipper location state (riêng biệt với delivery tracking)
          state = state.copyWith(
            shipperLocation: shipperLocation,
            clearError: true,
          );
        },
        onError: (error) {
          AppLogger.e('Error in shipper location stream', error);
          state = state.copyWith(
            error: 'Lỗi kết nối theo dõi vị trí shipper: ${error.toString()}',
          );
        },
      );

    } catch (e) {
      AppLogger.e('Failed to initialize delivery tracking service', e);
      state = state.copyWith(
        error: 'Không thể khởi tạo dịch vụ theo dõi delivery',
      );
    }
  }

  /// Kết nối đến service
  Future<void> connect() async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      AppLogger.i('Connecting to delivery tracking...');
      
      // Socket service auto-connects, just wait a bit
      await Future.delayed(const Duration(milliseconds: 1000));
      
      state = state.copyWith(
        isLoading: false,
        isConnected: true,
      );
      
    } catch (e) {
      AppLogger.e('Failed to connect delivery tracking', e);
      state = state.copyWith(
        isLoading: false,
        error: 'Không thể kết nối dịch vụ theo dõi delivery',
      );
    }
  }

  /// Bắt đầu theo dõi order
  Future<void> startTrackingOrder(int orderId) async {
    try {
      AppLogger.i('Starting tracking for order $orderId');
      
      if (!state.isConnected) {
        await connect();
        // Wait a bit for connection to establish
        await Future.delayed(const Duration(milliseconds: 1000));
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

      _socketService.startTrackingOrder(orderId);
      
      AppLogger.i('Successfully started tracking order $orderId');
      
    } catch (e) {
      AppLogger.e('Failed to start tracking order $orderId', e);
      state = state.copyWith(
        isTracking: false,
        error: 'Không thể bắt đầu theo dõi order: ${e.toString()}',
      );
    }
  }

  /// Dừng theo dõi order
  void stopTrackingOrder() {
    try {
      AppLogger.i('Stopping delivery tracking');
      
      _socketService.stopTrackingOrder();
      
      state = state.copyWith(
        isTracking: false,
        clearTracking: true,
        clearShipperLocation: true,
        clearError: true,
      );
      
    } catch (e) {
      AppLogger.e('Error stopping delivery tracking', e);
      state = state.copyWith(
        error: 'Lỗi khi dừng theo dõi delivery',
      );
    }
  }

  /// Làm mới kết nối
  Future<void> refresh() async {
    try {
      AppLogger.i('Refreshing delivery tracking connection');
      state = state.copyWith(isLoading: true, clearError: true);
      
      // Disconnect and reconnect
      _socketService.disconnect();
      await Future.delayed(const Duration(milliseconds: 500));
      // Socket service will auto-reconnect
      
      state = state.copyWith(isLoading: false);
      
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
    _deliverySubscription?.cancel();
    _shipperLocationSubscription?.cancel();
    _connectionSubscription?.cancel();
    
    // Stop tracking and disconnect
    _socketService.stopTrackingOrder();
    _socketService.disconnect();
    
    super.dispose();
  }
}
