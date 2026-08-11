import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_status.dart';
import 'package:delivery_app/features/orders/application/state/tracking/delivery_tracking_notifier.dart';
import 'optimized_delivery_tracking_map_adapter.dart';
import '../widgets/track_order/tracking_delivered_card.dart';
import '../widgets/track_order/tracking_finding_shipper_card.dart';
import '../widgets/track_order/tracking_no_data_card.dart';

class TrackingRealMapWidget extends ConsumerWidget {
  final int orderId;
  final bool canTrackingRealtime;
  final VoidCallback? onRetry;

  const TrackingRealMapWidget({
    super.key,
    required this.orderId,
    required this.canTrackingRealtime,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingState = ref.watch(deliveryTrackingProvider);

    // Kiểm tra có dữ liệu tracking không
    if (trackingState.currentTracking == null) {
      return TrackingNoDataCard(
        orderId: orderId,
        canTrackingRealtime: canTrackingRealtime,
        onRetry: onRetry,
      );
    }

    final currentTracking = trackingState.currentTracking!;

    // ✅ Ẩn bản đồ khi đã giao thành công
    if (currentTracking.status == DeliveryStatus.delivered) {
      return const TrackingDeliveredCard();
    }

    // Chỉ hiển thị bản đồ khi đã có shipper nhận đơn
    if (currentTracking.shipperId == null ||
        currentTracking.status == DeliveryStatus.pending ||
        currentTracking.status == DeliveryStatus.findingShipper ||
        currentTracking.status == DeliveryStatus.waitShipperConfirm ||
        currentTracking.status == DeliveryStatus.shipperNotFound) {
      return const TrackingFindingShipperCard();
    }

    return OptimizedDeliveryTrackingMapWidget(
      deliveryTracking: currentTracking,
    );
  }
}
