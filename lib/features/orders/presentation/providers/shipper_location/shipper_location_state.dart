import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/error/failures.dart';
import '../../../domain/entities/shipper_location_entity.dart';

part 'shipper_location_state.freezed.dart';

@freezed
sealed class ShipperLocationState with _$ShipperLocationState {
  const ShipperLocationState._();

  const factory ShipperLocationState({
    @Default(false) bool isLoading,
    @Default(false) bool isTracking,
    @Default(false) bool isConnected,
    ShipperLocationEntity? currentLocation,
    int? trackingShipperId,
    Failure? failure,
  }) = _ShipperLocationState;

  /// Convenience getters
  bool get hasError => failure != null;
  bool get hasLocation => currentLocation != null;
  bool get canTrack => isConnected && !isLoading;
}
