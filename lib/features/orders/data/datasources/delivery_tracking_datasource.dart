import '../../domain/entities/delivery_tracking_entity.dart';

/// Abstract interface cho delivery tracking data sources
abstract class DeliveryTrackingDataSource {
  /// Stream tất cả delivery tracking updates
  Stream<DeliveryTrackingEntity> get deliveryStream;
  
  /// Stream delivery updates cho order cụ thể
  Stream<DeliveryTrackingEntity> deliveryUpdatesForOrder(int orderId);
  
  /// Stream connection status
  Stream<bool> get connectionStream;
  
  /// Check if currently connected
  bool get isConnected;

  /// Kết nối đến data source
  Future<void> connect();
  
  /// Subscribe to delivery tracking cho order
  void subscribeToOrder(int orderId);
  
  /// Unsubscribe from delivery tracking
  void unsubscribeFromOrder(int orderId);
  
  /// Get list of subscribed orders
  Set<int> get subscribedOrders;
  
  /// Ngắt kết nối
  Future<void> disconnect();
  
  /// Close method để graceful shutdown
  Future<void> close();
  
  /// Dispose resources
  void dispose();
}
