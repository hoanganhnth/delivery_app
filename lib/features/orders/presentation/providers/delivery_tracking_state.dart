import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/shipper_location_entity.dart';

/// State cho delivery tracking
class DeliveryTrackingState {
  final bool isConnected;
  final bool isTracking;
  final DeliveryTrackingEntity? currentTracking;
  final ShipperEntity? shipper;
  final ShipperLocationEntity? shipperLocation; // Vị trí real-time của shipper
  final String? error;
  final bool isLoading;

  const DeliveryTrackingState({
    this.isConnected = false,
    this.isTracking = false,
    this.currentTracking,
    this.shipper,
    this.shipperLocation,
    this.error,
    this.isLoading = false,
  });

  DeliveryTrackingState copyWith({
    bool? isConnected,
    bool? isTracking,
    DeliveryTrackingEntity? currentTracking,
    ShipperEntity? shipper,
    ShipperLocationEntity? shipperLocation,
    String? error,
    bool? isLoading,
    bool clearError = false,
    bool clearTracking = false,
    bool clearShipperLocation = false,
  }) {
    return DeliveryTrackingState(
      isConnected: isConnected ?? this.isConnected,
      isTracking: isTracking ?? this.isTracking,
      currentTracking: clearTracking ? null : (currentTracking ?? this.currentTracking),
      shipper: shipper ?? this.shipper,
      shipperLocation: clearShipperLocation ? null : (shipperLocation ?? this.shipperLocation),
      error: clearError ? null : (error ?? this.error),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'DeliveryTrackingState(isConnected: $isConnected, isTracking: $isTracking, hasTracking: ${currentTracking != null}, hasShipper: ${shipper != null}, hasShipperLocation: ${shipperLocation != null}, error: $error)';
  }
}
