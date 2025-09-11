import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/socket/providers/socket_providers.dart';

/// Provider để theo dõi connection status của các socket services
final shipperLocationConnectionProvider = StreamProvider<bool>((ref) {
  final socketService = ref.watch(shipperLocationSocketServiceProvider);
  final stream = socketService.connectionStream;
  
  // Return empty stream with false if connectionStream is null
  if (stream == null) {
    return Stream.value(false);
  }
  
  return stream;
});

final deliveryTrackingConnectionProvider = StreamProvider<bool>((ref) {
  final stompService = ref.watch(deliveryTrackingStompServiceProvider);
  final stream = stompService.connectionStream;
  
  // Return empty stream with false if connectionStream is null
  if (stream == null) {
    return Stream.value(false);
  }
  
  return stream;
});

/// Provider để kiểm tra tất cả connections đã sẵn sàng chưa
final allConnectionsReadyProvider = Provider<bool>((ref) {
  final shipperConnection = ref.watch(shipperLocationConnectionProvider);
  final deliveryConnection = ref.watch(deliveryTrackingConnectionProvider);
  
  return shipperConnection.maybeWhen(
    data: (shipperReady) => deliveryConnection.maybeWhen(
      data: (deliveryReady) => shipperReady && deliveryReady,
      orElse: () => false,
    ),
    orElse: () => false,
  );
});
