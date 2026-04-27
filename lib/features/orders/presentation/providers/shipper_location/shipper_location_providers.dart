import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/network/socket/socket_client.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_socket_datasource.dart' 
    as shipper_socket_ds;
import 'package:delivery_app/features/orders/data/datasources/shipper_location_datasource.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/repositories/shipper_location_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/repositories/shipper_location_repository.dart';
import 'package:delivery_app/features/orders/domain/entities/shipper_location_entity.dart';
import 'package:delivery_app/features/orders/domain/usecases/tracking_usecases.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_api_service.dart';
import 'package:delivery_app/features/orders/domain/usecases/get_shipper_location_use_case.dart';

/// Socket Client Provider - Di chuyển từ core về feature
final shipperLocationSocketClientProvider = Provider<SocketClient>((ref) {
  const url = 'ws://localhost:8090/ws/shipper-locations';
  return SocketClient(url, name: 'ShipperLocation');
});

/// DataSource Provider - Di chuyển từ core về feature  
final shipperLocationSocketDataSourceProvider = Provider<ShipperLocationDataSource>((ref) {
  final socketClient = ref.watch(shipperLocationSocketClientProvider);
  return shipper_socket_ds.ShipperLocationSocketDataSource(socket: socketClient);
});

/// Remote DataSource Provider (REST API)
final shipperLocationRemoteDataSourceProvider = Provider<ShipperLocationRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioProvider);
  final apiService = ShipperLocationApiService(dioClient);
  return ShipperLocationRemoteDataSourceImpl(apiService);
});

/// Stream provider cho entities
final shipperLocationStreamProvider = StreamProvider<ShipperLocationEntity>((ref) {
  final dataSource = ref.watch(shipperLocationSocketDataSourceProvider);
  // Direct stream - no need to expand
  return dataSource.locationStream;
});

/// Connection status provider
final shipperLocationConnectionProvider = StreamProvider<bool>((ref) {
  final dataSource = ref.watch(shipperLocationSocketDataSourceProvider);
  return dataSource.connectionStream;
});

/// Repository Provider - Di chuyển từ core về feature
final shipperLocationRepositoryProvider = Provider<ShipperLocationRepository>((ref) {
  final socketDataSource = ref.watch(shipperLocationSocketDataSourceProvider);
  final remoteDataSource = ref.watch(shipperLocationRemoteDataSourceProvider);
  return ShipperLocationRepositoryImpl(socketDataSource, remoteDataSource);
});

/// UseCase Providers for Shipper Location Tracking
// final startShipperTrackingUseCaseProvider = Provider<StartShipperTrackingUseCase>((ref) {
//   final repository = ref.watch(shipperLocationRepositoryProvider);
//   return StartShipperTrackingUseCase(repository);
// });

final stopShipperTrackingUseCaseProvider = Provider<StopShipperTrackingUseCase>((ref) {
  final repository = ref.watch(shipperLocationRepositoryProvider);
  return StopShipperTrackingUseCase(repository);
});

final trackShipperLocationUseCaseProvider = Provider<TrackShipperLocationUseCase>((ref) {
  final repository = ref.watch(shipperLocationRepositoryProvider);
  return TrackShipperLocationUseCase(repository);
});

final getShipperLocationUseCaseProvider = Provider<GetShipperLocationUseCase>((ref) {
  final repository = ref.watch(shipperLocationRepositoryProvider);
  return GetShipperLocationUseCase(repository);
});

// Since ShipperLocation is generated, replace StateNotifierProvider pattern

// We can just keep a dummy one so we don't break UI components while migrating
final isShipperLocationConnectedProvider = Provider<bool>((ref) {
  return false; 
});
