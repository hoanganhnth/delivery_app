import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shipper_location_providers.dart';
import 'delivery_tracking_providers.dart';

/// Provider để kiểm tra tất cả connections đã sẵn sàng chưa
final allConnectionsReadyProvider = Provider<bool>((ref) {
  final shipperConnection = ref.watch(shipperLocationConnectionProvider);
  final deliveryConnection = ref.watch(deliveryConnectionProvider);
  
  return shipperConnection.maybeWhen(
    data: (shipperReady) => deliveryConnection.maybeWhen(
      data: (deliveryReady) => shipperReady && deliveryReady,
      orElse: () => false,
    ),
    orElse: () => false,
  );
});
