import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/providers.dart';
import 'shipper_rating_bottom_sheet.dart';
import 'restaurant_rating_bottom_sheet.dart';
import 'cancel_order_bottom_sheet.dart';

/// Widget hiển thị các nút hành động cho đơn hàng
class OrderActionButtons extends ConsumerWidget {
  final OrderEntity order;
  final VoidCallback? onOrderCanceled;

  const OrderActionButtons({
    super.key,
    required this.order,
    this.onOrderCanceled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep the provider alive during async operations
    ref.watch(cancelOrderProvider);
    
    final theme = Theme.of(context);

    // Chỉ hiển thị nút cancel nếu có thể huỷ
    if (!order.canCancel && order.status != OrderStatus.delivered) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hành động',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.w),
            if (order.canCancel)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _handleCancelAction(context, ref),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Hủy đơn hàng'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: EdgeInsets.symmetric(vertical: 12.w),
                  ),
                ),
              ),
              if (order.status == OrderStatus.delivered && order.shipperId != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showRatingBottomSheet(context),
                  icon: const Icon(Icons.star_outline),
                  label: const Text('Đánh giá Shipper'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.w),
                  ),
                ),
              ),
            if (order.status == OrderStatus.delivered)
              Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showRestaurantRatingBottomSheet(context),
                    icon: const Icon(Icons.restaurant_menu),
                    label: const Text('Đánh giá Quán ăn'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.w),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showRatingBottomSheet(BuildContext context) {
    if (order.shipperId == null || order.id == null) return;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ShipperRatingBottomSheet(
        orderId: order.id!,
        shipperId: order.shipperId!,
      ),
    );
  }

  void _showRestaurantRatingBottomSheet(BuildContext context) {
    if (order.restaurantId == null || order.id == null) return;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => RestaurantRatingBottomSheet(
        order: order,
      ),
    );
  }

  Future<void> _handleCancelAction(BuildContext context, WidgetRef ref) async {
    final reason = await CancelOrderBottomSheet.show(context);
    if (reason != null && context.mounted) {
      await _cancelOrder(context, ref, reason);
    }
  }

  Future<void> _cancelOrder(BuildContext context, WidgetRef ref, String reason) async {
    try {
      // Hiển thị loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final orderId = order.id;
      if (orderId == null) {
        throw Exception('Order id is null');
      }

      final result = await ref
          .read(cancelOrderProvider.notifier)
          .cancelOrder(orderId, reason: reason);

      if (context.mounted) {
        Navigator.of(context).pop(); // Đóng loading dialog

        if (result) {
          // Hiển thị thông báo thành công
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã hủy đơn hàng thành công'),
              backgroundColor: Colors.green,
            ),
          );

          // Callback khi hủy thành công
          onOrderCanceled?.call();
        } else {
          // Hiển thị thông báo lỗi
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hủy đơn hàng thất bại'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // Đóng loading dialog

        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi hủy đơn hàng: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
