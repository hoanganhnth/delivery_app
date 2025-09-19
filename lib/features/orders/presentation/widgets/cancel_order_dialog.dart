import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/providers.dart';
import '../../../../generated/l10n.dart';

/// Dialog xác nhận hủy đơn hàng
class CancelOrderDialog extends ConsumerWidget {
  final OrderEntity order;
  final VoidCallback? onSuccess;

  const CancelOrderDialog({
    super.key,
    required this.order,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cancelAsync = ref.watch(cancelOrderProvider);

    return AlertDialog(
      title: Text(S.of(context).cancelOrder),
      content: Text(S.of(context).cancelOrderConfirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(S.of(context).cancel),
        ),
        cancelAsync.when(
          data: (success) => TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final result = await ref
                  .read(cancelOrderProvider.notifier)
                  .cancelOrder(order.id!);
              if (result && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).orderCancelled),
                    backgroundColor: Colors.green,
                  ),
                );
                onSuccess?.call();
              }
            },
            child: Text(
              S.of(context).confirm,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          loading: () => SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (error, _) => TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).error),
          ),
        ),
      ],
    );
  }

  /// Static method để show dialog
  static void show(
    BuildContext context,
    OrderEntity order, {
    VoidCallback? onSuccess,
  }) {
    showDialog(
      context: context,
      builder: (context) => CancelOrderDialog(
        order: order,
        onSuccess: onSuccess,
      ),
    );
  }
}
