import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/presentation/providers/providers.dart';
import '../order_detail/restaurant_rating_bottom_sheet.dart';
import '../order_detail/cancel_order_bottom_sheet.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/cart/presentation/providers/state/cart_notifier.dart';
import '../../utils/reorder_cart_items.dart';

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

    // Nếu đang giao hàng nhưng chưa có shipper hoặc chưa thể huỷ, không hiển thị gì (trừ khi là đã huỷ/delivered)
    if (!order.canCancel && order.status == OrderStatus.delivering) {
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
            if (order.status == OrderStatus.delivered ||
                order.status == OrderStatus.cancelled)
              Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _handleReorder(context, ref),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Đặt lại đơn này'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
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

  void _showRestaurantRatingBottomSheet(BuildContext context) {
    if (order.restaurantId == null || order.id == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => RestaurantRatingBottomSheet(order: order),
    );
  }

  Future<void> _handleCancelAction(BuildContext context, WidgetRef ref) async {
    final reason = await CancelOrderBottomSheet.show(context);
    if (reason != null && context.mounted) {
      await _cancelOrder(context, ref, reason);
    }
  }

  Future<void> _cancelOrder(
    BuildContext context,
    WidgetRef ref,
    String reason,
  ) async {
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
          const SnackBar(
            content: Text('Không thể hủy đơn hàng. Vui lòng thử lại.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleReorder(BuildContext context, WidgetRef ref) async {
    try {
      final items = buildReorderCartItems(order);
      final cartNotifier = ref.read(cartProvider.notifier);
      await cartNotifier.clearCart();
      for (final item in items) {
        await cartNotifier.addItem(item);
      }
      if (!context.mounted) return;
      context.pushCart();
    } on FormatException {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể đặt lại đơn này.')),
      );
    }
  }
}
