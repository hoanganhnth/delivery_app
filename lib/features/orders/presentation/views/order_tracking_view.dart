import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/orders/application/order_tracking_intent.dart';
import 'package:delivery_app/features/orders/application/order_tracking_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Pure tracking shell. The supplied map child is a platform adapter only;
/// this view never owns polling, sockets or imperative map state.
class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({
    super.key,
    required this.state,
    required this.map,
    required this.onIntent,
  });

  final OrderTrackingViewState state;
  final Widget map;
  final ValueChanged<OrderTrackingIntent> onIntent;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.card),
          child: Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).trackDelivery,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      _phaseText(state.phase),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _ConnectionBadge(state: state),
            ],
          ),
        ),
      ),
      if (state.hasError) ...[
        const SizedBox(height: AppSpacing.sm),
        Card(
          margin: EdgeInsets.zero,
          color: Theme.of(context).colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(state.errorMessage!)),
                TextButton(
                  onPressed: () =>
                      onIntent(const OrderTrackingRetryRequested()),
                  child: const Text('Thử lại'),
                ),
                IconButton(
                  tooltip: 'Đóng',
                  onPressed: () =>
                      onIntent(const OrderTrackingErrorDismissed()),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
      ],
      const SizedBox(height: AppSpacing.sm),
      map,
      const SizedBox(height: AppSpacing.sm),
    ],
  );

  String _phaseText(OrderTrackingPhase phase) => switch (phase) {
    OrderTrackingPhase.loading => 'Đang tải thông tin giao hàng',
    OrderTrackingPhase.findingDriver => 'Đang tìm shipper',
    OrderTrackingPhase.awaitingDriverConfirmation =>
      'Đang chờ shipper nhận đơn',
    OrderTrackingPhase.driverAssigned => 'Shipper đang đến điểm lấy hàng',
    OrderTrackingPhase.pickedUp => 'Shipper đã lấy hàng',
    OrderTrackingPhase.delivering => 'Đơn hàng đang được giao',
    OrderTrackingPhase.delivered => 'Đơn hàng đã giao thành công',
    OrderTrackingPhase.cancelled => 'Giao hàng đã bị hủy',
    OrderTrackingPhase.driverUnavailable => 'Không tìm được shipper',
    OrderTrackingPhase.unavailable => 'Chưa có thông tin giao hàng',
  };
}

class _ConnectionBadge extends StatelessWidget {
  const _ConnectionBadge({required this.state});

  final OrderTrackingViewState state;

  @override
  Widget build(BuildContext context) {
    final (label, color) = state.isLoading
        ? ('Đang tải', Colors.orange)
        : state.isConnected
        ? ('Đã kết nối', Colors.green)
        : ('Chưa kết nối', Colors.grey);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: AppRadii.pillRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
