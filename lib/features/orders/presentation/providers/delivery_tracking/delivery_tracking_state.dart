import 'package:equatable/equatable.dart';
import '../../../domain/entities/delivery_tracking_entity.dart';
import '../../../domain/entities/shipper_entity.dart';

/// State cho delivery tracking
class DeliveryTrackingState extends Equatable {
  final bool isConnected;
  final bool isTracking;
  final DeliveryTrackingEntity? currentTracking;
  final ShipperEntity? shipper;
  final int? currentShipperId; // Theo dõi shipper ID hiện tại để biết khi nào cần fetch lại
  final bool isLoadingShipper; // Loading state riêng cho shipper
  final List<List<double>>? polylinePoints; // Danh sách toạ độ vẽ đường đi
  final String? error;
  final bool isLoading;

  const DeliveryTrackingState({
    this.isConnected = false,
    this.isTracking = false,
    this.currentTracking,
    this.shipper,
    this.currentShipperId,
    this.isLoadingShipper = false,
    this.polylinePoints,
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
    List<List<double>>? polylinePoints,
    String? error,
    bool? isLoading,
    bool clearError = false,
    bool clearTracking = false,
    bool clearShipper = false,
    bool clearPolyline = false,
  }) {
    return DeliveryTrackingState(
      isConnected: isConnected ?? this.isConnected,
      isTracking: isTracking ?? this.isTracking,
      currentTracking:
          clearTracking ? null : (currentTracking ?? this.currentTracking),
      shipper: clearShipper ? null : (shipper ?? this.shipper),
      currentShipperId:
          clearShipper ? null : (currentShipperId ?? this.currentShipperId),
      isLoadingShipper: isLoadingShipper ?? this.isLoadingShipper,
      polylinePoints:
          clearPolyline ? null : (polylinePoints ?? this.polylinePoints),
      error: clearError ? null : (error ?? this.error),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'DeliveryTrackingState(isConnected: $isConnected, isTracking: $isTracking, hasTracking: ${currentTracking != null}, hasShipper: ${shipper != null}, currentShipperId: $currentShipperId, isLoadingShipper: $isLoadingShipper, hasPolyline: ${polylinePoints != null}, error: $error)';
  }

  @override
  List<Object?> get props => [
        isConnected,
        isTracking,
        currentTracking,
        shipper,
        currentShipperId,
        isLoadingShipper,
        polylinePoints,
        error,
        isLoading
      ];
}
