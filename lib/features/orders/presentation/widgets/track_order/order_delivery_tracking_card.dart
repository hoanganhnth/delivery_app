import 'package:delivery_app/generated/l10n.dart';
import 'tracking_connection_status_badge.dart';
import 'tracking_error_message.dart';
import 'tracking_real_map_widget.dart';
// import 'package:delivery_app/features/orders/presentation/widgets/delivery_tracking_map_widget.dart'; // Unused - sử dụng optimized widget
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_status.dart';
import 'package:delivery_app/features/orders/presentation/providers/providers.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';

/// Widget hiển thị delivery tracking trong order detail
class OrderDeliveryTrackingCard extends ConsumerStatefulWidget {
  final OrderEntity order;

  const OrderDeliveryTrackingCard({super.key, required this.order});

  @override
  ConsumerState<OrderDeliveryTrackingCard> createState() =>
      _OrderDeliveryTrackingCardState();
}

class _OrderDeliveryTrackingCardState
    extends ConsumerState<OrderDeliveryTrackingCard> {
  @override
  void initState() {
    super.initState();
    // Start tracking when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.order.id != null) {
        await ref
            .read(deliveryTrackingProvider.notifier)
            .startTrackingOrderSafe(
              widget.order.id!,
              trackingRealtime: widget.order.canTrackingRealtime,
            );
      }
    });
  }

  @override
  void dispose() {
    // Stop tracking when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackingState = ref.watch(deliveryTrackingProvider);
    final connectionAsync = ref.watch(trackingConnectionProvider);

    /// ✅ Lắng nghe delivery stream - khi DELIVERED thì ẩn map và refresh order detail
    ref.listen<DeliveryTrackingState>(deliveryTrackingProvider, (prev, next) {
      final prevStatus = prev?.currentTracking?.status;
      final nextStatus = next.currentTracking?.status;

      // Khi shipper mới nhận đơn → bắt đầu track vị trí
      if (next.currentTracking != null &&
          prev?.currentTracking?.shipperId != next.currentTracking?.shipperId) {
        final shipperId = next.currentTracking!.shipperId;
        if (shipperId != null) {
          ref
              .read(shipperLocationProvider.notifier)
              .startTrackingShipper(shipperId);
        }
      }

      // ✅ Khi giao hàng thành công → refresh order detail và stop tracking
      if (prevStatus != DeliveryStatus.delivered &&
          nextStatus == DeliveryStatus.delivered) {
        AppLogger.i(
          '✅ Delivery DELIVERED - refreshing order detail and stopping tracking',
        );
        if (widget.order.id != null) {
          ref.invalidate(orderDetailProvider(widget.order.id!));
          ref.invalidate(deliveryTrackingProvider);
        }
        ref.read(deliveryTrackingProvider.notifier).stopTrackingOrder();
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Delivery tracking header
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      color: Colors.green[600],
                      size: 24,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      S.of(context).trackDelivery,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ref.colors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    TrackingConnectionStatusBadge(
                      isConnected: connectionAsync.when(
                        data: (connected) => connected,
                        loading: () => false,
                        error: (_, __) => false,
                      ),
                      isLoading: trackingState.isLoading,
                    ),
                  ],
                ),

                SizedBox(height: 16.w),

                // Error message
                if (trackingState.failure != null)
                  TrackingErrorMessage(
                    error: trackingState.failure!.message,
                    onClear: () {
                      ref.read(deliveryTrackingProvider.notifier).clearError();
                    },
                  ),

                // TODO: Add back when DTOs are ready
                // Shipper info when available
                // if (shipperInfo != null) ...[
                //   SizedBox(height: 16.w),
                //   _buildShipperInfo(shipperInfo),
                // ],
              ],
            ),
          ),
        ),

        SizedBox(height: 16.w),

        TrackingRealMapWidget(
          orderId: widget.order.id ?? 0,
          canTrackingRealtime: widget.order.canTrackingRealtime,
        ),

        SizedBox(height: 16.w),
      ],
    );
  }

}
