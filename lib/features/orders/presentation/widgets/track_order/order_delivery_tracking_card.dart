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
  late final DeliveryTracking _deliveryTrackingNotifier;
  ShipperLocation? _shipperLocationNotifier;
  bool _startedDeliveryTracking = false;
  bool _startedShipperTracking = false;

  @override
  void initState() {
    super.initState();
    _deliveryTrackingNotifier = ref.read(deliveryTrackingProvider.notifier);
    // Start tracking when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final orderId = widget.order.id;
      if (orderId != null && orderId > 0) {
        _startedDeliveryTracking = true;
        await _deliveryTrackingNotifier.startTrackingOrderSafe(
          orderId,
          trackingRealtime: widget.order.canTrackingRealtime,
        );
      }
    });
  }

  @override
  void dispose() {
    if (_startedDeliveryTracking) {
      _deliveryTrackingNotifier.cancelTrackingLease();
    }
    if (_startedShipperTracking && _shipperLocationNotifier != null) {
      _shipperLocationNotifier!.cancelTrackingLease();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderId = widget.order.id;
    if (orderId == null || orderId <= 0) {
      return const TrackingErrorMessage(
        error: 'Không thể theo dõi đơn hàng này.',
      );
    }

    final trackingState = ref.watch(deliveryTrackingProvider);

    /// ✅ Lắng nghe delivery stream - khi DELIVERED thì ẩn map và refresh order detail
    ref.listen<DeliveryTrackingState>(deliveryTrackingProvider, (prev, next) {
      final prevStatus = prev?.currentTracking?.status;
      final nextStatus = next.currentTracking?.status;

      // Khi shipper mới nhận đơn → bắt đầu track vị trí
      if (next.currentTracking != null &&
          prev?.currentTracking?.shipperId != next.currentTracking?.shipperId) {
        final shipperId = next.currentTracking!.shipperId;
        final deliveryId = next.currentTracking!.id;
        if (shipperId != null && deliveryId > 0) {
          _startedShipperTracking = true;
          _shipperLocationNotifier ??= ref.read(
            shipperLocationProvider.notifier,
          );
          _shipperLocationNotifier!.startTrackingShipper(shipperId, deliveryId);
        }
      }

      // ✅ Khi giao hàng thành công → refresh order detail và stop tracking
      if (prevStatus != DeliveryStatus.delivered &&
          nextStatus == DeliveryStatus.delivered) {
        AppLogger.i(
          '✅ Delivery DELIVERED - refreshing order detail and stopping tracking',
        );
        ref.invalidate(orderDetailProvider(orderId));
        ref.invalidate(deliveryTrackingProvider);
        _deliveryTrackingNotifier.stopTrackingOrder();
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
                    Expanded(
                      child: Text(
                        S.of(context).trackDelivery,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ref.colors.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    TrackingConnectionStatusBadge(
                      isConnected: trackingState.hasTracking,
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
              ],
            ),
          ),
        ),

        SizedBox(height: 16.w),

        TrackingRealMapWidget(
          orderId: orderId,
          canTrackingRealtime: widget.order.canTrackingRealtime,
        ),

        SizedBox(height: 16.w),
      ],
    );
  }
}
