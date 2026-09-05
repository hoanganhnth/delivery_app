import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/orders/application/orders_list_intent.dart';
import 'package:delivery_app/features/orders/application/orders_list_state.dart';
import 'package:flutter/material.dart';

/// Pure orders-history rendering. It emits typed intents only.
class OrdersListView extends StatelessWidget {
  const OrdersListView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final OrdersListViewState state;
  final ValueChanged<OrdersListIntent> onIntent;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
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
        const Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.page,
            AppSpacing.lg,
            AppSpacing.page,
            AppSpacing.xs,
          ),
          child: Text(
            'Đơn hàng của bạn',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          child: Text(
            'Theo dõi các món ăn đang giao và lịch sử đặt hàng.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _OrdersFilterBar(filter: state.filter, onIntent: onIntent),
        const SizedBox(height: AppSpacing.xs),
        Expanded(child: _body(context)),
      ],
    ),
  );

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
          padding: const EdgeInsets.all(AppSpacing.page),
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
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
    child: Row(
      children: [
        _FilterChip(
          label: 'Tất cả',
          selected: filter == OrdersListFilter.all,
          onTap: () =>
              onIntent(const OrdersListFilterChanged(OrdersListFilter.all)),
        ),
        const SizedBox(width: AppSpacing.xs),
        _FilterChip(
          label: 'Đang xử lý',
          selected: filter == OrdersListFilter.active,
          onTap: () =>
              onIntent(const OrdersListFilterChanged(OrdersListFilter.active)),
        ),
        const SizedBox(width: AppSpacing.xs),
        _FilterChip(
          label: 'Hoàn thành',
          selected: filter == OrdersListFilter.completed,
          onTap: () => onIntent(
            const OrdersListFilterChanged(OrdersListFilter.completed),
          ),
        ),
      ],
    ),
  );
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ChoiceChip(
    label: Text(label),
    selected: selected,
    onSelected: (_) => onTap(),
  );
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
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: Key('order_card_${order.id}'),
        onTap: isActionRunning
            ? null
            : () => onIntent(OrdersListDetailsRequested(order.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.card),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      order.restaurantName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _StatusBadge(
                    tone: order.statusTone,
                    label: order.statusLabel,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                '${_dateLabel(order.createdAt)} · ${order.itemCount} ${order.itemCount == 1 ? 'món' : 'món'}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${order.totalAmount.toStringAsFixed(0)} ₫',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  if (isActionRunning)
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else ...[
                    if (order.canCancel)
                      TextButton(
                        key: Key('order_cancel_${order.id}'),
                        onPressed: () =>
                            onIntent(OrdersListCancelRequested(order.id)),
                        child: const Text('Hủy đơn'),
                      ),
                    if (order.canReorder)
                      TextButton.icon(
                        key: Key('order_reorder_${order.id}'),
                        onPressed: () =>
                            onIntent(OrdersListReorderRequested(order.id)),
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Đặt lại'),
                      ),
                  ],
                ],
              ),
            ],
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
    final scheme = Theme.of(context).colorScheme;
    final (background, foreground) = switch (tone) {
      OrdersListStatusTone.pending => (
        scheme.secondaryContainer,
        scheme.onSecondaryContainer,
      ),
      OrdersListStatusTone.delivering => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      OrdersListStatusTone.delivered => (
        Colors.green.shade100,
        Colors.green.shade900,
      ),
      OrdersListStatusTone.cancelled => (
        scheme.errorContainer,
        scheme.onErrorContainer,
      ),
      OrdersListStatusTone.noDriver => (
        Colors.deepOrange.shade100,
        Colors.deepOrange.shade900,
      ),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.pillRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: foreground,
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
