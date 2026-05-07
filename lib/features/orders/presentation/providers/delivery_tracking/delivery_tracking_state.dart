import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/error/failures.dart';
import '../../../domain/entities/delivery_tracking_entity.dart';
import '../../../domain/entities/shipper_entity.dart';

part 'delivery_tracking_state.freezed.dart';

/// State cho delivery tracking
@freezed
sealed class DeliveryTrackingState with _$DeliveryTrackingState {
  const DeliveryTrackingState._();

  const factory DeliveryTrackingState({
    @Default(false) bool isConnected,
    @Default(false) bool isTracking,
    DeliveryTrackingEntity? currentTracking,
    ShipperEntity? shipper,
    int? currentShipperId, // Theo dõi shipper ID hiện tại để biết khi nào cần fetch lại
    @Default(false) bool isLoadingShipper, // Loading state riêng cho shipper
    List<List<double>>? polylinePoints, // Danh sách toạ độ vẽ đường đi
    Failure? failure,
    @Default(false) bool isLoading,
  }) = _DeliveryTrackingState;

  bool get hasTracking => currentTracking != null;
  bool get hasShipper => shipper != null;
  bool get hasPolyline => polylinePoints != null;
}
