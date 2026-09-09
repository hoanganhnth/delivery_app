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
      map,
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.card),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.two_wheeler_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 22,
              ),
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
                      color: PreviewUi.text(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _phaseText(state.phase),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: PreviewUi.muted(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(child: _ConnectionBadge(state: state)),
          ],
        ),
      ),
      if (state.hasError) ...[
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFDEDEC),
            borderRadius: AppRadii.control,
            border: Border.all(color: const Color(0xFFFADBD8), width: 1),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Color(0xFFE74C3C),
                size: 20,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(
                    color: Color(0xFFC0392B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => onIntent(const OrderTrackingRetryRequested()),
                child: const Text(
                  'Thử lại',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE74C3C),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Đóng',
                onPressed: () => onIntent(const OrderTrackingErrorDismissed()),
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: Color(0xFF757F8A),
                ),
              ),
            ],
          ),
        ),
      ],
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
    final (label, bg, fg) = state.isLoading
        ? ('Đang tải', const Color(0xFFFFF7EC), const Color(0xFFE67E22))
        : state.isConnected
        ? ('Đã kết nối', const Color(0xFFE8F8F5), const Color(0xFF27AE60))
        : ('Chưa kết nối', const Color(0xFFF0F2F5), const Color(0xFF757F8A));
    return Container(
      decoration: BoxDecoration(color: bg, borderRadius: AppRadii.pillRadius),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        label,
        style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}
