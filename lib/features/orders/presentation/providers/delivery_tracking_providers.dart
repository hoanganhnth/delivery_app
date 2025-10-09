import 'package:delivery_app/core/network/dio/authenticated_network_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/network/socket/stomp_client.dart';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_socket_datasource.dart' 
    as delivery_socket_ds;
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_datasource.dart';
import 'package:delivery_app/features/orders/data/repositories/delivery_tracking_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/repositories/delivery_tracking_repository.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_tracking_entity.dart';
import 'package:delivery_app/features/orders/domain/usecases/tracking_usecases.dart';
import 'package:delivery_app/features/orders/domain/usecases/get_current_delivery_usecase.dart';
import 'shipper_providers.dart';
import 'delivery_tracking_notifier.dart';
import 'delivery_tracking_state.dart';

/// Socket Client Provider - Di chuyển từ core về feature
final deliveryTrackingStompClientProvider = Provider<StompSocketClient>((ref) {
  const url = 'ws://localhost:8085/ws/delivery-native';
  return StompSocketClient(url, name: 'DeliveryTracking');
});

/// DataSource Provider - Di chuyển từ core về feature
final deliveryTrackingSocketDataSourceProvider = Provider<DeliveryTrackingDataSource>((ref) {
  final stompClient = ref.watch(deliveryTrackingStompClientProvider);
  return delivery_socket_ds.DeliveryTrackingSocketDataSource(stompClient);
});

/// Stream provider cho entities
final deliveryTrackingStreamProvider = StreamProvider<DeliveryTrackingEntity>((ref) {
  final dataSource = ref.watch(deliveryTrackingSocketDataSourceProvider);
  return dataSource.deliveryStream;
});

/// Connection status provider
final deliveryConnectionProvider = StreamProvider<bool>((ref) {
  final dataSource = ref.watch(deliveryTrackingSocketDataSourceProvider);
  return dataSource.connectionStream;
});

/// Network providers
final deliveryTrackingApiServiceProvider = Provider((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return DeliveryTrackingApiService(dio);
});

final deliveryTrackingRemoteDataSourceProvider = Provider((ref) {
  final apiService = ref.watch(deliveryTrackingApiServiceProvider);
  return DeliveryTrackingRemoteDataSourceImpl(apiService);
});

/// Repository Provider - Di chuyển từ core về feature
final deliveryTrackingRepositoryProvider = Provider<DeliveryTrackingRepository>((ref) {
  final socketDataSource = ref.watch(deliveryTrackingSocketDataSourceProvider);
  final remoteDataSource = ref.watch(deliveryTrackingRemoteDataSourceProvider);
  return DeliveryTrackingRepositoryImpl(socketDataSource, remoteDataSource);
});

/// UseCase Providers
final connectDeliveryTrackingUseCaseProvider = Provider((ref) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return ConnectDeliveryTrackingUseCase(repository);
});

final startDeliveryTrackingUseCaseProvider = Provider((ref) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return TrackDeliveryUseCase(repository);
});

final stopDeliveryTrackingUseCaseProvider = Provider((ref) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return StopDeliveryTrackingUseCase(repository);
});

final refreshDeliveryTrackingUseCaseProvider = Provider((ref) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return RefreshDeliveryTrackingUseCase(repository);
});

final getCurrentDeliveryUseCaseProvider = Provider((ref) {
  final repository = ref.watch(deliveryTrackingRepositoryProvider);
  return GetCurrentDeliveryUseCase(repository);
});

/// Delivery Tracking Notifier Provider
/// Không sử dụng autoDispose để tránh bị dispose khi navigation
final deliveryTrackingNotifierProvider = StateNotifierProvider.autoDispose<DeliveryTrackingNotifier, DeliveryTrackingState>((ref) {
  final connectUseCase = ref.watch(connectDeliveryTrackingUseCaseProvider);
  final startTrackingUseCase = ref.watch(startDeliveryTrackingUseCaseProvider);
  final stopTrackingUseCase = ref.watch(stopDeliveryTrackingUseCaseProvider);
  final refreshUseCase = ref.watch(refreshDeliveryTrackingUseCaseProvider);
  final getShipperUseCase = ref.watch(getShipperByIdUseCaseProvider);
  final getCurrentDeliveryUseCase = ref.watch(getCurrentDeliveryUseCaseProvider);
  
  // Clean Architecture: Notifier only depends on UseCases, not Repository
  final notifier = DeliveryTrackingNotifier(
    connectUseCase: connectUseCase,
    startTrackingUseCase: startTrackingUseCase,
    stopTrackingUseCase: stopTrackingUseCase,
    refreshUseCase: refreshUseCase,
    getShipperUseCase: getShipperUseCase,
    getCurrentDeliveryUseCase: getCurrentDeliveryUseCase,
  );
  
  // Cleanup when provider is disposed
  ref.onDispose(() {
    notifier.dispose();
  });
  
  return notifier;
});

/// Provider để kiểm tra xem có đang tracking hay không
// final isTrackingProvider = Provider<bool>((ref) {
//   final state = ref.watch(deliveryTrackingNotifierProvider);
//   return state.isTracking;
// });

// TODO: Add these back when DTOs are ready
// /// Provider để lấy current tracking entity
// final currentTrackingProvider = Provider<DeliveryTrackingEntity?>((ref) {
//   final state = ref.watch(deliveryTrackingNotifierProvider);
//   return state.currentTracking;
// });

// /// Provider để lấy shipper info
// final shipperInfoProvider = Provider<ShipperEntity?>((ref) {
//   final state = ref.watch(deliveryTrackingNotifierProvider);
//   return state.shipper;
// });

/// Provider để kiểm tra connection status
final trackingConnectionProvider = Provider.autoDispose<bool>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.isConnected;
  // return true;
});

/// Provider để lấy tracking error
// final trackingErrorProvider = Provider<String?>((ref) {
//   final state = ref.watch(deliveryTrackingNotifierProvider);
//   return state.error;
// });
