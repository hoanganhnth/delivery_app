import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/orders/application/orders_list_intent.dart';
import 'package:delivery_app/features/orders/application/orders_list_state.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';
import '../components/orders_preview_components.dart';

/// Pure orders-history rendering. It emits typed intents only.
class OrdersListView extends StatelessWidget {
  const OrdersListView({
    super.key,
    required this.state,
    required this.onIntent,
    this.showBackButton = true,
    this.previewMode = false,
    this.bottomNavigationBar,
    this.onBack,
    this.onCart,
    this.onRefundHistory,
    this.cartItemCount = 0,
  });

  final OrdersListViewState state;
  final ValueChanged<OrdersListIntent> onIntent;
  final bool showBackButton;
  final bool previewMode;
  final Widget? bottomNavigationBar;
  final VoidCallback? onBack;
  final VoidCallback? onCart;
  final VoidCallback? onRefundHistory;
  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    if (previewMode) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: OrdersPreviewHeader(
          itemCount: cartItemCount,
          onBack: showBackButton ? onBack : null,
          onCart: onCart ?? () {},
          onRefundHistory: onRefundHistory,
        ),
        body: OrdersPreviewBody(state: state, onIntent: onIntent),
        bottomNavigationBar: bottomNavigationBar,
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          S.of(context).orders,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: !showBackButton
            ? null
            : IconButton(
                key: const Key('orders_back'),
                icon: const Icon(Icons.arrow_back),
                onPressed: () => onIntent(const OrdersListBackRequested()),
              ),
        actions: [
          IconButton(
            key: const Key('orders_refund_history'),
            tooltip: 'Lịch sử hoàn tiền',
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => onIntent(const OrdersListRefundHistoryRequested()),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OrdersFilterBar(filter: state.filter, onIntent: onIntent),
          const SizedBox(height: AppSpacing.xs),
          Expanded(child: _body(context)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasError) {
      return _OrdersTerminalState(
        icon: Icons.error_outline,
        title: 'Không thể tải danh sách đơn hàng. Vui lòng thử lại.',
        actionLabel: 'Thử lại',
        onAction: () => onIntent(const OrdersListRetryRequested()),
      );
    }
    if (state.isEmpty) {
      return _OrdersTerminalState(
        icon: Icons.receipt_long_outlined,
        title: 'Chưa có đơn hàng nào.',
        actionLabel: 'Quay lại',
        onAction: () => onIntent(const OrdersListBackRequested()),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => onIntent(const OrdersListRefreshRequested()),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.extentAfter < 200) {
            onIntent(const OrdersListLoadMoreRequested());
          }
          return false;
        },
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: state.filteredItems.length + (state.isLoadingMore ? 1 : 0),
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            if (index == state.filteredItems.length) {
              return const Padding(
                padding: EdgeInsets.all(AppSpacing.sm),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final order = state.filteredItems[index];
            return _OrderListCard(
              order: order,
              isActionRunning: state.actionOrderId == order.id,
              onIntent: onIntent,
            );
          },
        ),
      ),
    );
  }
}

class _OrdersFilterBar extends StatelessWidget {
  const _OrdersFilterBar({required this.filter, required this.onIntent});

  final OrdersListFilter filter;
  final ValueChanged<OrdersListIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _FilterPillTab(
                label: 'Tất cả',
                selected: filter == OrdersListFilter.all,
                onTap: () => onIntent(
                  const OrdersListFilterChanged(OrdersListFilter.all),
                ),
              ),
            ),
            Expanded(
              child: _FilterPillTab(
                label: 'Đang xử lý',
                selected: filter == OrdersListFilter.active,
                onTap: () => onIntent(
                  const OrdersListFilterChanged(OrdersListFilter.active),
                ),
              ),
            ),
            Expanded(
              child: _FilterPillTab(
                label: 'Hoàn thành',
                selected: filter == OrdersListFilter.completed,
                onTap: () => onIntent(
                  const OrdersListFilterChanged(OrdersListFilter.completed),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterPillTab extends StatelessWidget {
  const _FilterPillTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? scheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? scheme.primary : scheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderListCard extends StatelessWidget {
  const _OrderListCard({
    required this.order,
    required this.isActionRunning,
    required this.onIntent,
  });

  final OrdersListItemViewData order;
  final bool isActionRunning;
  final ValueChanged<OrdersListIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(color: scheme.surface),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: Key('order_card_${order.id}'),
          onTap: isActionRunning
              ? null
              : () => onIntent(OrdersListDetailsRequested(order.id)),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${S.of(context).order} #${order.id}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.restaurant_rounded,
                        color: scheme.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.restaurantName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_dateLabel(order.createdAt)} · ${order.itemCount} món',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF757F8A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(Icons.chevron_right, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                _StatusBadge(tone: order.statusTone, label: order.statusLabel),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF3F4F6),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tổng thanh toán',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: const Color(0xFF8C939D),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${order.totalAmount.toStringAsFixed(0)} ₫',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF1A1D20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isActionRunning)
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (order.canCancel)
                            OutlinedButton(
                              key: Key('order_cancel_${order.id}'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                side: const BorderSide(
                                  color: Color(0xFFE0E2E6),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: AppRadii.pillRadius,
                                ),
                              ),
                              onPressed: () =>
                                  onIntent(OrdersListCancelRequested(order.id)),
                              child: Text(
                                'Hủy đơn',
                                style: TextStyle(
                                  color: scheme.error,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (order.canReorder)
                            OutlinedButton.icon(
                              key: Key('order_reorder_${order.id}'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                side: BorderSide(
                                  color: scheme.primary.withValues(alpha: 0.5),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: AppRadii.pillRadius,
                                ),
                              ),
                              onPressed: () => onIntent(
                                OrdersListReorderRequested(order.id),
                              ),
                              icon: Icon(
                                Icons.refresh_rounded,
                                size: 15,
                                color: scheme.primary,
                              ),
                              label: Text(
                                'Đặt lại',
                                style: TextStyle(
                                  color: scheme.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _dateLabel(DateTime? value) {
    if (value == null) return 'Chưa rõ thời gian';
    return '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.tone, required this.label});

  final OrdersListStatusTone tone;
  final String label;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (tone) {
      OrdersListStatusTone.pending => (
        const Color(0xFFFFF7EC),
        const Color(0xFFE67E22),
      ),
      OrdersListStatusTone.delivering => (
        const Color(0xFFE6FAF7),
        const Color(0xFF00A38C),
      ),
      OrdersListStatusTone.delivered => (
        const Color(0xFFE8F8F5),
        const Color(0xFF27AE60),
      ),
      OrdersListStatusTone.cancelled => (
        const Color(0xFFFDEDEC),
        const Color(0xFFE74C3C),
      ),
      OrdersListStatusTone.noDriver => (
        const Color(0xFFFEF5E7),
        const Color(0xFFD35400),
      ),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.pillRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _OrdersTerminalState extends StatelessWidget {
  const _OrdersTerminalState({
    required this.icon,
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: AppSpacing.lg),
          Text(title, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    ),
  );
}
