import 'dart:async';

import 'package:delivery_app/features/orders/domain/entities/delivery_status.dart';
import 'package:delivery_app/features/orders/application/state/tracking/delivery_tracking_notifier.dart';
import 'package:delivery_app/features/orders/application/state/tracking/delivery_tracking_state.dart';
import 'package:delivery_app/features/orders/application/state/orders/order_detail_notifier.dart';
import 'package:delivery_app/features/orders/application/state/tracking/shipper_location_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_tracking_intent.dart';
import 'order_tracking_state.dart';

final orderTrackingViewModelProvider = NotifierProvider.autoDispose
    .family<
      OrderTrackingViewModel,
      OrderTrackingViewState,
      OrderTrackingTarget
    >((target) => OrderTrackingViewModel(target));

final class OrderTrackingTarget {
  const OrderTrackingTarget({
    required this.orderId,
    required this.trackingRealtime,
  });

  final int orderId;
  final bool trackingRealtime;

  @override
  bool operator ==(Object other) =>
      other is OrderTrackingTarget &&
      other.orderId == orderId &&
      other.trackingRealtime == trackingRealtime;

  @override
  int get hashCode => Object.hash(orderId, trackingRealtime);
}

/// Owns the delivery polling/socket lease for a single detail-page host.
///
/// Mapbox remains a platform adapter, but it only observes the notifier state;
/// it cannot start, stop or mutate tracking lifecycle anymore.
class OrderTrackingViewModel extends Notifier<OrderTrackingViewState> {
  OrderTrackingViewModel(this._target);

  final OrderTrackingTarget _target;
  late final DeliveryTracking _deliveryTrackingNotifier;
  late final ShipperLocation _shipperLocationNotifier;
  int? _activeDeliveryId;
  bool _hasStarted = false;
  bool _hasReleasedLease = false;

  @override
  OrderTrackingViewState build() {
    // Cache dependencies while the provider is active. `ref` cannot be used
    // from an `onDispose` callback, but releasing this page's leases must be
    // guaranteed as soon as its only view is removed.
    _deliveryTrackingNotifier = ref.read(deliveryTrackingProvider.notifier);
    _shipperLocationNotifier = ref.read(shipperLocationProvider.notifier);
    final initial = ref.read(deliveryTrackingProvider);
    ref.listen<DeliveryTrackingState>(deliveryTrackingProvider, (
      previous,
      next,
    ) {
      _handleDeliveryChange(previous, next);
      if (ref.mounted) state = _fromDelivery(next);
    });
    ref.onDispose(_releaseLease);
    return _fromDelivery(initial);
  }

  Future<void> dispatch(OrderTrackingIntent intent) async {
    switch (intent) {
      case OrderTrackingStartRequested():
        await _start();
      case OrderTrackingRetryRequested():
        await _retry();
      case OrderTrackingErrorDismissed():
        _deliveryTrackingNotifier.clearError();
      case OrderTrackingStopRequested():
        _releaseLease();
    }
  }

  Future<void> _start() async {
    if (_target.orderId <= 0 || _hasReleasedLease || _hasStarted) return;
    _hasStarted = true;
    await _deliveryTrackingNotifier.startTrackingOrderSafe(
      _target.orderId,
      trackingRealtime: _target.trackingRealtime,
    );
  }

  Future<void> _retry() async {
    if (_target.orderId <= 0 || _hasReleasedLease) return;
    await _deliveryTrackingNotifier.startTrackingOrderSafe(
      _target.orderId,
      trackingRealtime: _target.trackingRealtime,
    );
  }

  void _handleDeliveryChange(
    DeliveryTrackingState? previous,
    DeliveryTrackingState next,
  ) {
    final previousDelivery = previous?.currentTracking;
    final delivery = next.currentTracking;
    if (delivery == null || delivery.orderId != _target.orderId) return;

    if (delivery.shipperId != null &&
        delivery.id > 0 &&
        delivery.id != _activeDeliveryId) {
      _activeDeliveryId = delivery.id;
      unawaited(
        _shipperLocationNotifier.startTrackingShipper(
          delivery.shipperId!,
          delivery.id,
        ),
      );
    }

    final previousStatus = previousDelivery?.status;
    final isTerminal =
        delivery.status == DeliveryStatus.delivered ||
        delivery.status == DeliveryStatus.cancelled ||
        delivery.status == DeliveryStatus.shipperNotFound;
    if (previousStatus == delivery.status || !isTerminal) {
      return;
    }
    ref.invalidate(orderDetailProvider(_target.orderId));
    if (delivery.status == DeliveryStatus.delivered ||
        delivery.status == DeliveryStatus.cancelled ||
        delivery.status == DeliveryStatus.shipperNotFound) {
      _releaseTerminalTracking();
    }
  }

  void _releaseTerminalTracking() {
    if (_hasReleasedLease) return;
    _hasReleasedLease = true;
    unawaited(_deliveryTrackingNotifier.stopTrackingOrder());
    _shipperLocationNotifier.cancelTrackingLease();
  }

  void _releaseLease() {
    if (_hasReleasedLease) return;
    _hasReleasedLease = true;
    if (_hasStarted) {
      _deliveryTrackingNotifier.cancelTrackingLease();
    }
    if (_activeDeliveryId != null) {
      _shipperLocationNotifier.cancelTrackingLease();
    }
  }

  OrderTrackingViewState _fromDelivery(DeliveryTrackingState tracking) {
    final delivery = tracking.currentTracking;
    return OrderTrackingViewState(
      isLoading: tracking.isLoading,
      isConnected: tracking.isConnected,
      isTracking: tracking.isTracking,
      phase: delivery == null
          ? (tracking.isLoading
                ? OrderTrackingPhase.loading
                : OrderTrackingPhase.unavailable)
          : switch (delivery.status) {
              DeliveryStatus.pending ||
              DeliveryStatus.findingShipper => OrderTrackingPhase.findingDriver,
              DeliveryStatus.waitShipperConfirm =>
                OrderTrackingPhase.awaitingDriverConfirmation,
              DeliveryStatus.assigned => OrderTrackingPhase.driverAssigned,
              DeliveryStatus.pickedUp => OrderTrackingPhase.pickedUp,
              DeliveryStatus.delivering => OrderTrackingPhase.delivering,
              DeliveryStatus.delivered => OrderTrackingPhase.delivered,
              DeliveryStatus.cancelled => OrderTrackingPhase.cancelled,
              DeliveryStatus.shipperNotFound =>
                OrderTrackingPhase.driverUnavailable,
            },
      errorMessage: tracking.failure?.message,
    );
  }
}
