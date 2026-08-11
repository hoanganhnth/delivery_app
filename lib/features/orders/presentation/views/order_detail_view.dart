import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/orders/application/order_detail_intent.dart';
import 'package:delivery_app/features/orders/application/order_detail_state.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/presentation/components/refund_status_case_card.dart';
import 'package:delivery_app/features/orders/presentation/widgets/order_detail/order_customer_info_card.dart';
import 'package:delivery_app/features/orders/presentation/widgets/order_detail/order_payment_card.dart';
import 'package:delivery_app/features/orders/presentation/widgets/shared/order_progress_bar.dart';
import 'package:delivery_app/features/orders/presentation/widgets/track_order/delivery_timeline.dart';
import 'package:flutter/material.dart';

/// Pure detail screen. Its inputs contain every observable state and it only
/// emits typed intents; data loading, navigation and mutations live in the
/// page/ViewModel boundary.
class OrderDetailView extends StatelessWidget {
  const OrderDetailView({
    super.key,
    required this.orderId,
    required this.state,
    required this.tracking,
    required this.onIntent,
  });

  final int orderId;
  final OrderDetailViewState state;
  final Widget tracking;
  final ValueChanged<OrderDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final order = state.order;
    return Scaffold(
      appBar: AppBar(
        title: Text('Đơn hàng #$orderId'),
        leading: IconButton(
          tooltip: 'Quay lại',
          onPressed: () => onIntent(const OrderDetailBackRequested()),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: switch ((state.isLoading, state.hasError, order)) {
        (true, _, _) => const Center(child: CircularProgressIndicator()),
        (_, true, _) => _DetailMessage(
          icon: Icons.error_outline,
          title: 'Không thể tải thông tin đơn hàng.',
          actionLabel: 'Thử lại',
          onAction: () => onIntent(const OrderDetailRetryRequested()),
        ),
        (_, _, null) => _DetailMessage(
          icon: Icons.search_off,
          title: 'Không tìm thấy đơn hàng.',
          message: 'Đơn hàng này có thể đã bị xóa hoặc không tồn tại.',
          actionLabel: 'Quay lại',
          onAction: () => onIntent(const OrderDetailBackRequested()),
        ),
        (_, _, final currentOrder?) => RefreshIndicator(
          onRefresh: () async => onIntent(const OrderDetailRefreshRequested()),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OrderStatusCard(order: currentOrder),
                const SizedBox(height: AppSpacing.md),
                if (currentOrder.status != OrderStatus.cancelled &&
                    currentOrder.status != OrderStatus.shipperNotFound) ...[
                  _TimelineCard(
                    order: currentOrder,
                    rawTrackingStatus: state.trackingRawStatus,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (currentOrder.canTrackingRealtime) ...[
                  tracking,
                  const SizedBox(height: AppSpacing.md),
                ],
                _OrderItemsCard(order: currentOrder),
                const SizedBox(height: AppSpacing.md),
                OrderCustomerInfoCard(order: currentOrder),
                const SizedBox(height: AppSpacing.md),
                OrderPaymentCard(order: currentOrder),
                const SizedBox(height: AppSpacing.md),
                _RefundStatus(
                  state: state,
                  onRetry: () =>
                      onIntent(const OrderDetailRefundRetryRequested()),
                ),
                const SizedBox(height: AppSpacing.md),
                _OrderActions(
                  order: currentOrder,
                  isSubmitting: state.isActionInProgress,
                  onIntent: onIntent,
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      },
    );
  }
}

class _OrderStatusCard extends StatelessWidget {
  const _OrderStatusCard({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (title, progress) = switch (order.status) {
      OrderStatus.pending => ('Đang chờ xác nhận', 0.33),
      OrderStatus.delivering => ('Đơn hàng đang được giao', 0.66),
      OrderStatus.shipperNotFound => ('Không tìm được shipper', 0.0),
      OrderStatus.delivered => ('Đã giao thành công', 1.0),
      OrderStatus.cancelled => ('Đơn hàng đã hủy', 0.0),
    };
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    if (order.estimatedDeliveryTime != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Dự kiến ${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(order.estimatedDeliveryTime!))}',
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ],
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  borderRadius: AppRadii.control,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  child: Text(
                    '#${order.id}',
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (order.status != OrderStatus.cancelled &&
              order.status != OrderStatus.shipperNotFound) ...[
            const SizedBox(height: AppSpacing.md),
            OrderProgressBar(progress: progress),
          ],
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.order, required this.rawTrackingStatus});

  final OrderEntity order;
  final String? rawTrackingStatus;

  @override
  Widget build(BuildContext context) => AppSurfaceCard(
    child: DeliveryTimeline(
      status: order.status,
      rawBackendStatus: rawTrackingStatus ?? order.rawBackendStatus,
    ),
  );
}

class _OrderItemsCard extends StatelessWidget {
  const _OrderItemsCard({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chi tiết đơn hàng',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final item in order.items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  Expanded(
                    child: Text('${item.quantity}x ${item.menuItemName}'),
                  ),
                  Text(
                    '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          const Divider(height: AppSpacing.lg),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Tổng cộng',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              Text(
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: scheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RefundStatus extends StatelessWidget {
  const _RefundStatus({required this.state, required this.onRetry});

  final OrderDetailViewState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.isRefundLoading ||
        state.refundCase == null && !state.hasRefundError) {
      return const SizedBox.shrink();
    }
    if (state.refundCase != null) {
      return RefundStatusCaseCard(refundCase: state.refundCase!);
    }
    return AppSurfaceCard(
      child: Row(
        children: [
          const Icon(Icons.info_outline),
          const SizedBox(width: AppSpacing.sm),
          const Expanded(child: Text('Không thể tải trạng thái hoàn tiền.')),
          TextButton(onPressed: onRetry, child: const Text('Thử lại')),
        ],
      ),
    );
  }
}

class _OrderActions extends StatelessWidget {
  const _OrderActions({
    required this.order,
    required this.isSubmitting,
    required this.onIntent,
  });

  final OrderEntity order;
  final bool isSubmitting;
  final ValueChanged<OrderDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final canReorder =
        order.status == OrderStatus.delivered ||
        order.status == OrderStatus.cancelled;
    final canRate = order.status == OrderStatus.delivered;
    final hidesActions =
        order.status == OrderStatus.shipperNotFound ||
        (!order.canCancel && order.status == OrderStatus.delivering);
    if (hidesActions) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hành động',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          if (order.canCancel) ...[
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: isSubmitting
                    ? null
                    : () => onIntent(const OrderDetailCancelRequested()),
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Hủy đơn hàng'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: scheme.error,
                  side: BorderSide(color: scheme.error),
                ),
              ),
            ),
          ],
          if (canRate) ...[
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isSubmitting
                    ? null
                    : () => onIntent(const OrderDetailRatingRequested()),
                icon: const Icon(Icons.restaurant_menu),
                label: const Text('Đánh giá Quán ăn'),
              ),
            ),
          ],
          if (canReorder) ...[
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: isSubmitting
                    ? null
                    : () => onIntent(const OrderDetailReorderRequested()),
                icon: const Icon(Icons.refresh),
                label: const Text('Đặt lại đơn này'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailMessage extends StatelessWidget {
  const _DetailMessage({
    required this.icon,
    required this.title,
    this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56),
          const SizedBox(height: AppSpacing.md),
          Text(title, textAlign: TextAlign.center),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(message!, textAlign: TextAlign.center),
          ],
          const SizedBox(height: AppSpacing.md),
          FilledButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    ),
  );
}
