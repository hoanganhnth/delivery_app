import 'dart:async';

import 'package:delivery_app/features/orders/application/order_tracking_intent.dart';
import 'package:delivery_app/features/orders/application/order_tracking_state.dart';
import 'package:delivery_app/features/orders/application/order_tracking_view_model.dart';
import 'package:delivery_app/features/orders/presentation/views/order_tracking_view.dart';
import 'package:delivery_app/features/orders/presentation/platform/tracking_real_map_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lifecycle adapter for one order's delivery and shipper tracking lease.
class OrderTrackingPage extends ConsumerStatefulWidget {
  const OrderTrackingPage({
    super.key,
    required this.orderId,
    required this.trackingRealtime,
  });

  final int orderId;
  final bool trackingRealtime;

  @override
  ConsumerState<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends ConsumerState<OrderTrackingPage> {
  late final OrderTrackingTarget _target = OrderTrackingTarget(
    orderId: widget.orderId,
    trackingRealtime: widget.trackingRealtime,
  );
  late final NotifierProvider<OrderTrackingViewModel, OrderTrackingViewState>
  _provider = orderTrackingViewModelProvider(_target);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(_provider.notifier)
            .dispatch(const OrderTrackingStartRequested()),
      );
    });
  }

  @override
  Widget build(BuildContext context) => OrderTrackingView(
    state: ref.watch(_provider),
    map: TrackingRealMapWidget(
      orderId: widget.orderId,
      canTrackingRealtime: widget.trackingRealtime,
      onRetry: () => unawaited(
        ref
            .read(_provider.notifier)
            .dispatch(const OrderTrackingRetryRequested()),
      ),
    ),
    onIntent: (intent) =>
        unawaited(ref.read(_provider.notifier).dispatch(intent)),
  );
}
