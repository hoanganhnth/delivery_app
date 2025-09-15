import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/socket/providers/socket_providers.dart';
import '../../data/repositories/delivery_tracking_repository_impl.dart';
import '../../domain/usecases/tracking_usecases.dart';
// TODO: Add back when DTOs are ready
// import '../../domain/entities/delivery_tracking_entity.dart';
import 'delivery_tracking_notifier.dart';
import 'delivery_tracking_state.dart';

/// Delivery Tracking Repository Provider
final deliveryTrackingRepositoryProvider = Provider((ref) {
  final stompService = ref.watch(deliveryTrackingStompServiceProvider);
  return DeliveryTrackingRepositoryImpl(stompService);
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

/// Delivery Tracking Notifier Provider
final deliveryTrackingNotifierProvider = StateNotifierProvider<DeliveryTrackingNotifier, DeliveryTrackingState>((ref) {
  final connectUseCase = ref.watch(connectDeliveryTrackingUseCaseProvider);
  final startTrackingUseCase = ref.watch(startDeliveryTrackingUseCaseProvider);
  final stopTrackingUseCase = ref.watch(stopDeliveryTrackingUseCaseProvider);
  final refreshUseCase = ref.watch(refreshDeliveryTrackingUseCaseProvider);
  
  // Clean Architecture: Notifier only depends on UseCases, not Repository
  return DeliveryTrackingNotifier(
    connectUseCase: connectUseCase,
    startTrackingUseCase: startTrackingUseCase,
    stopTrackingUseCase: stopTrackingUseCase,
    refreshUseCase: refreshUseCase,
  );
});

/// Provider để kiểm tra xem có đang tracking hay không
final isTrackingProvider = Provider<bool>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.isTracking;
});

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
final trackingConnectionProvider = Provider<bool>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.isConnected;
});

/// Provider để lấy tracking error
final trackingErrorProvider = Provider<String?>((ref) {
  final state = ref.watch(deliveryTrackingNotifierProvider);
  return state.error;
});
