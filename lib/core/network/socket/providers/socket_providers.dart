import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../websocket_service.dart';
import '../stomp_socket_service.dart';
import '../shipper_location_socket_service.dart';
import '../delivery_tracking_stomp_service.dart';

/// Global socket manager instances
final socketManagerProvider = Provider<SocketManager>((ref) {
  return SocketManager();
});

final stompManagerProvider = Provider<StompManager>((ref) {
  return StompManager();
});

/// Socket service providers
final shipperLocationSocketServiceProvider = Provider<ShipperLocationSocketService>((ref) {
  final socketManager = ref.watch(socketManagerProvider);
  return ShipperLocationSocketService(socketManager);
});

final deliveryTrackingStompServiceProvider = Provider<DeliveryTrackingStompService>((ref) {
  final stompManager = ref.watch(stompManagerProvider);
  return DeliveryTrackingStompService(stompManager);
});
