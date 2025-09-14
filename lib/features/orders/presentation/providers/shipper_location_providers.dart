import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/socket/providers/tracking_service_providers.dart';
import '../../domain/usecases/tracking_usecases.dart';
import 'shipper_location_notifier.dart';
import 'shipper_location_state.dart';

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
final shipperLocationNotifierProvider = StateNotifierProvider<ShipperLocationNotifier, ShipperLocationState>((ref) {
  // final startTrackingUseCase = ref.watch(startShipperTrackingUseCaseProvider);
  final stopTrackingUseCase = ref.watch(stopShipperTrackingUseCaseProvider);
  final trackShipperUseCase = ref.watch(trackShipperLocationUseCaseProvider);
  
  return ShipperLocationNotifier(
    // startTrackingUseCase: startTrackingUseCase,
    stopTrackingUseCase: stopTrackingUseCase,
    trackShipperUseCase: trackShipperUseCase,
  );
});

/// Convenience providers for easy access in UI
final currentShipperLocationProvider = Provider<ShipperLocationState>((ref) {
  return ref.watch(shipperLocationNotifierProvider);
});

final isTrackingShipperProvider = Provider<bool>((ref) {
  return ref.watch(shipperLocationNotifierProvider.select((state) => state.isTracking));
});
