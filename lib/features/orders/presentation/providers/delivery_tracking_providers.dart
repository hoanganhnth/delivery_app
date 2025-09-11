import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/delivery_tracking_socket_service.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import 'delivery_tracking_notifier.dart';
import 'delivery_tracking_state.dart';

/// Delivery Tracking Socket Service Provider
final deliveryTrackingSocketServiceProvider = Provider<DeliveryTrackingSocketService>((ref) {
  return DeliveryTrackingSocketService();
});

/// Delivery Tracking Notifier Provider
final deliveryTrackingNotifierProvider = StateNotifierProvider<DeliveryTrackingNotifier, DeliveryTrackingState>((ref) {
  final socketService = ref.watch(deliveryTrackingSocketServiceProvider);
  
  return DeliveryTrackingNotifier(
    socketService: socketService,
  );
});

/// Provider để kiểm tra xem có đang tracking hay không
final isTrackingProvider = Provider<bool>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.isTracking;
});

/// Provider để lấy current tracking entity
final currentTrackingProvider = Provider<DeliveryTrackingEntity?>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.currentTracking;
});

/// Provider để lấy shipper info
final shipperInfoProvider = Provider<ShipperEntity?>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.shipper;
});

/// Provider để kiểm tra connection status
final trackingConnectionProvider = Provider<bool>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.isConnected;
});

/// Provider để lấy tracking error
final trackingErrorProvider = Provider<String?>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.error;
});
