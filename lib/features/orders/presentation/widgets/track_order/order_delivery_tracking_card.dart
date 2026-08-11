import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/presentation/pages/order_tracking_page.dart';
import 'package:flutter/material.dart';

import 'tracking_error_message.dart';

/// Compatibility entry point. The typed tracking page now owns polling and
/// socket leases; this widget remains only for callers still passing an order.
class OrderDeliveryTrackingCard extends StatelessWidget {
  const OrderDeliveryTrackingCard({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final orderId = order.id;
    if (orderId == null || orderId <= 0) {
      return const TrackingErrorMessage(
        error: 'Không thể theo dõi đơn hàng này.',
      );
    }
    return OrderTrackingPage(
      orderId: orderId,
      trackingRealtime: order.canTrackingRealtime,
    );
  }
}
