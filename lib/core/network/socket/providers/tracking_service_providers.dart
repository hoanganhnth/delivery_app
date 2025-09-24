import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dio/network_providers.dart';
import '../../../../features/orders/data/datasources/delivery_tracking_remote_datasource_impl.dart';
import '../../../../features/orders/data/repositories/shipper_location_repository_impl.dart';
import '../../../../features/orders/data/repositories/delivery_tracking_repository_impl.dart';
import '../../../../features/orders/domain/repositories/shipper_location_repository.dart';
import '../../../../features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'socket_providers.dart';

/// Network providers for delivery tracking
final deliveryTrackingApiServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return DeliveryTrackingApiService(dio);
});

final deliveryTrackingRemoteDataSourceProvider = Provider((ref) {
  final apiService = ref.watch(deliveryTrackingApiServiceProvider);
  return DeliveryTrackingRemoteDataSourceImpl(apiService);
});

/// Repository providers - Trực tiếp inject socket service, loại bỏ datasource & service layer
final shipperLocationRepositoryProvider = Provider<ShipperLocationRepository>((ref) {
  final socketService = ref.watch(shipperLocationSocketServiceProvider);
  return ShipperLocationRepositoryImpl(socketService);
});

final deliveryTrackingRepositoryProvider = Provider<DeliveryTrackingRepository>((ref) {
  final stompService = ref.watch(deliveryTrackingStompServiceProvider);
  final remoteDataSource = ref.watch(deliveryTrackingRemoteDataSourceProvider);
  return DeliveryTrackingRepositoryImpl(stompService, remoteDataSource);
});
