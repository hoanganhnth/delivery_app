import '../../../domain/entities/shipper_location_entity.dart';

class ShipperLocationState {
  final bool isLoading;
  final bool isTracking;
  final bool isConnected;
  final ShipperLocationEntity? currentLocation;
  final int? trackingShipperId;
  final String? error;

  const ShipperLocationState({
    this.isLoading = false,
    this.isTracking = false,
    this.isConnected = false,
    this.currentLocation,
    this.trackingShipperId,
    this.error,
  });

  /// Convenience getters
  bool get hasError => error != null;
  bool get hasLocation => currentLocation != null;
  bool get canTrack => isConnected && !isLoading;

  /// Copy with method
  ShipperLocationState copyWith({
    bool? isLoading,
    bool? isTracking,
    bool? isConnected,
    ShipperLocationEntity? currentLocation,
    int? trackingShipperId,
    String? error,
    bool clearError = false,
    bool clearLocation = false,
  }) {
    return ShipperLocationState(
      isLoading: isLoading ?? this.isLoading,
      isTracking: isTracking ?? this.isTracking,
      isConnected: isConnected ?? this.isConnected,
      currentLocation: clearLocation ? null : (currentLocation ?? this.currentLocation),
      trackingShipperId: trackingShipperId ?? this.trackingShipperId,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
