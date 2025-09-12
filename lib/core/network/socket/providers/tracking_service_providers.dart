import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/orders/data/repositories/shipper_location_repository_impl.dart';
import '../../../../features/orders/data/repositories/delivery_tracking_repository_impl.dart';
import '../../../../features/orders/domain/repositories/shipper_location_repository.dart';
import '../../../../features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'socket_providers.dart';

/// Repository providers - Trực tiếp inject socket service, loại bỏ datasource & service layer
final shipperLocationRepositoryProvider = Provider<ShipperLocationRepository>((ref) {
  final socketService = ref.watch(shipperLocationSocketServiceProvider);
  return ShipperLocationRepositoryImpl(socketService);
});

final deliveryTrackingRepositoryProvider = Provider<DeliveryTrackingRepository>((ref) {
  final stompService = ref.watch(deliveryTrackingStompServiceProvider);
  return DeliveryTrackingRepositoryImpl(stompService);
});
