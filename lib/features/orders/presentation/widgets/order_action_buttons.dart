import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/orders/order_providers.dart';

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
    final theme = Theme.of(context);

    // Chỉ hiển thị nút cancel cho đơn hàng pending
    if (order.status != OrderStatus.pending) {
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
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showCancelDialog(context, ref),
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Hủy đơn hàng'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: EdgeInsets.symmetric(vertical: 12.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xác nhận hủy đơn'),
        content: const Text(
          'Bạn có chắc chắn muốn hủy đơn hàng này không?\n\n'
          'Hành động này không thể hoàn tác.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Không'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await _cancelOrder(context, ref);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hủy đơn'),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelOrder(BuildContext context, WidgetRef ref) async {
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
          .cancelOrder(orderId);

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
