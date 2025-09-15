import '../../domain/entities/delivery_tracking_entity.dart' hide ShipperEntity;
import '../../domain/entities/shipper_entity.dart';

/// State cho delivery tracking
class DeliveryTrackingState {
  final bool isConnected;
  final bool isTracking;
  final DeliveryTrackingEntity? currentTracking;
  final ShipperEntity? shipper;
  final int? currentShipperId; // Theo dõi shipper ID hiện tại để biết khi nào cần fetch lại
  final bool isLoadingShipper; // Loading state riêng cho shipper
  final String? error;
  final bool isLoading;

  const DeliveryTrackingState({
    this.isConnected = false,
    this.isTracking = false,
    this.currentTracking,
    this.shipper,
    this.currentShipperId,
    this.isLoadingShipper = false,
    this.error,
    this.isLoading = false,
  });

  DeliveryTrackingState copyWith({
    bool? isConnected,
    bool? isTracking,
    DeliveryTrackingEntity? currentTracking,
    ShipperEntity? shipper,
    int? currentShipperId,
    bool? isLoadingShipper,
    String? error,
    bool? isLoading,
    bool clearError = false,
    bool clearTracking = false,
    bool clearShipper = false,
  }) {
    return DeliveryTrackingState(
      isConnected: isConnected ?? this.isConnected,
      isTracking: isTracking ?? this.isTracking,
      currentTracking: clearTracking ? null : (currentTracking ?? this.currentTracking),
      shipper: clearShipper ? null : (shipper ?? this.shipper),
      currentShipperId: clearShipper ? null : (currentShipperId ?? this.currentShipperId),
      isLoadingShipper: isLoadingShipper ?? this.isLoadingShipper,
      error: clearError ? null : (error ?? this.error),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'DeliveryTrackingState(isConnected: $isConnected, isTracking: $isTracking, hasTracking: ${currentTracking != null}, hasShipper: ${shipper != null}, currentShipperId: $currentShipperId, isLoadingShipper: $isLoadingShipper, error: $error)';
  }
}
