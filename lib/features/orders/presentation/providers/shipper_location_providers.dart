import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/network/socket/socket_client.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_socket_datasource.dart' 
    as shipper_socket_ds;
import 'package:delivery_app/features/orders/data/datasources/shipper_location_datasource.dart';
import 'package:delivery_app/features/orders/data/repositories/shipper_location_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/repositories/shipper_location_repository.dart';
import 'package:delivery_app/features/orders/domain/entities/shipper_location_entity.dart';
import 'package:delivery_app/features/orders/domain/usecases/tracking_usecases.dart';
import 'shipper_location_notifier.dart';
import 'shipper_location_state.dart';

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

/// Stream provider cho entities
final shipperLocationStreamProvider = StreamProvider<ShipperLocationEntity>((ref) {
  final dataSource = ref.watch(shipperLocationSocketDataSourceProvider);
  // Convert từ List stream sang individual entity stream
  return dataSource.locationStream
      .expand((locations) => locations);
});

/// Connection status provider
final shipperLocationConnectionProvider = StreamProvider<bool>((ref) {
  final dataSource = ref.watch(shipperLocationSocketDataSourceProvider);
  return dataSource.connectionStream;
});

/// Repository Provider - Di chuyển từ core về feature
final shipperLocationRepositoryProvider = Provider<ShipperLocationRepository>((ref) {
  final socketDataSource = ref.watch(shipperLocationSocketDataSourceProvider);
  return ShipperLocationRepositoryImpl(socketDataSource);
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

/// Shipper Location Notifier Provider
/// Không sử dụng autoDispose để tránh bị dispose khi navigation
final shipperLocationNotifierProvider = StateNotifierProvider.autoDispose<ShipperLocationNotifier, ShipperLocationState>((ref) {
  // final startTrackingUseCase = ref.watch(startShipperTrackingUseCaseProvider);
  final stopTrackingUseCase = ref.watch(stopShipperTrackingUseCaseProvider);
  final trackShipperUseCase = ref.watch(trackShipperLocationUseCaseProvider);
  
  final notifier = ShipperLocationNotifier(
    // startTrackingUseCase: startTrackingUseCase,
    stopTrackingUseCase: stopTrackingUseCase,
    trackShipperUseCase: trackShipperUseCase,
  );
  
  // Cleanup when provider is disposed
  ref.onDispose(() {
    notifier.dispose();
  });
  
  return notifier;
});

/// Convenience providers for easy access in UI
// final currentShipperLocationProvider = Provider<ShipperLocationState>((ref) {
//   return ref.watch(shipperLocationNotifierProvider);
// });

// final isTrackingShipperProvider = Provider<bool>((ref) {
//   return ref.watch(shipperLocationNotifierProvider.select((state) => state.isTracking));
// });
