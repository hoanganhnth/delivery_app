// import 'package:delivery_app/features/orders/presentation/widgets/delivery_tracking_map_widget.dart'; // Unused - sử dụng optimized widget
import 'package:delivery_app/features/orders/presentation/providers/shipper_location_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/orders/presentation/widgets/optimized_delivery_tracking_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/providers.dart';

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
            .read(deliveryTrackingNotifierProvider.notifier)
            .startTrackingOrderSafe(widget.order.id!);
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
    final trackingState = ref.watch(deliveryTrackingNotifierProvider);
    final isConnected = ref.watch(trackingConnectionProvider);

    // ✅ Listen to delivery tracking changes to auto-start shipper tracking
    ref.listen<DeliveryTrackingState>(deliveryTrackingNotifierProvider, (
      prev,
      next,
    ) {
      // Tự động start shipper tracking khi có delivery data mới
      if (next.currentTracking != null &&
          prev?.currentTracking?.shipperId != next.currentTracking?.shipperId) {
        final shipperId = next.currentTracking!.shipperId;
        if (shipperId != null) {
          ref
              .read(shipperLocationNotifierProvider.notifier)
              .startTrackingShipper(shipperId);
        }
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
                      'Theo dõi giao hàng',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Spacer(),
                    _buildConnectionStatus(
                      isConnected,
                      trackingState.isLoading,
                    ),
                  ],
                ),

                SizedBox(height: 16.w),

                // Error message
                if (trackingState.error != null)
                  _buildErrorMessage(trackingState.error!),

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

        // Map widget với dữ liệu thật từ deliveryTrackingNotifierProvider
        _buildRealMapWidget(),

        SizedBox(height: 16.w),
      ],
    );
  }

  Widget _buildConnectionStatus(bool isConnected, bool isLoading) {
    Color statusColor = isConnected ? Colors.green : Colors.red;
    String statusText = isConnected ? 'Kết nối' : 'Mất kết nối';
    IconData statusIcon = isConnected ? Icons.wifi : Icons.wifi_off;

    if (isLoading) {
      statusColor = Colors.orange;
      statusText = 'Đang kết nối...';
      statusIcon = Icons.sync;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 14),
          SizedBox(width: 4.w),
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              error,
              style: TextStyle(color: Colors.red.shade800, fontSize: 14.sp),
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(deliveryTrackingNotifierProvider.notifier).clearError();
            },
            icon: Icon(Icons.close, color: Colors.red.shade600, size: 20),
          ),
        ],
      ),
    );
  }

  /// Build map widget với dữ liệu thật từ deliveryTrackingNotifierProvider
  Widget _buildRealMapWidget() {
    final trackingState = ref.read(deliveryTrackingNotifierProvider);

    // Kiểm tra có dữ liệu tracking không
    if (trackingState.currentTracking == null) {
      return _buildNoTrackingDataCard();
    }

    final currentTracking = trackingState.currentTracking!;

    return OptimizedDeliveryTrackingMapWidget(
      deliveryTracking: currentTracking,
      shipper: trackingState
          .shipper, // Sử dụng trực tiếp shipper từ state (cùng entity type)
      useFakeMovement: false, // Sử dụng real data từ providers
    );
  }

  /// Widget hiển thị khi chưa có dữ liệu tracking
  Widget _buildNoTrackingDataCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_searching, size: 64, color: Colors.grey[400]),
              SizedBox(height: 16.w),
              Text(
                'Chưa có thông tin theo dõi',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.w),
              Text(
                'Shipper chưa bắt đầu giao hàng cho đơn này',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.w),
              ElevatedButton.icon(
                onPressed: () {
                  // Refresh để thử lấy lại dữ liệu tracking
                  ref
                      .read(deliveryTrackingNotifierProvider.notifier)
                      .startTrackingOrderSafe(widget.order.id!);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Thử lại'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
