import 'package:equatable/equatable.dart';

enum OrderTrackingPhase {
  loading,
  findingDriver,
  awaitingDriverConfirmation,
  driverAssigned,
  pickedUp,
  delivering,
  delivered,
  cancelled,
  driverUnavailable,
  unavailable,
}

final class OrderTrackingViewState extends Equatable {
  const OrderTrackingViewState({
    this.isLoading = false,
    this.isConnected = false,
    this.isTracking = false,
    this.phase = OrderTrackingPhase.unavailable,
    this.errorMessage,
  });

  final bool isLoading;
  final bool isConnected;
  final bool isTracking;
  final OrderTrackingPhase phase;
  final String? errorMessage;

  bool get hasError => errorMessage != null;
  bool get isTerminal => switch (phase) {
    OrderTrackingPhase.delivered ||
    OrderTrackingPhase.cancelled ||
    OrderTrackingPhase.driverUnavailable => true,
    _ => false,
  };

  OrderTrackingViewState copyWith({
    bool? isLoading,
    bool? isConnected,
    bool? isTracking,
    OrderTrackingPhase? phase,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OrderTrackingViewState(
      isLoading: isLoading ?? this.isLoading,
      isConnected: isConnected ?? this.isConnected,
      isTracking: isTracking ?? this.isTracking,
      phase: phase ?? this.phase,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isConnected,
    isTracking,
    phase,
    errorMessage,
  ];
}
