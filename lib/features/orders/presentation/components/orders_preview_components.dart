import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/orders/application/orders_list_intent.dart';
import 'package:delivery_app/features/orders/application/orders_list_state.dart';
import 'package:flutter/material.dart';

const _ordersPreviewAccent = Color(0xFFEE4D2D);

class OrdersPreviewHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const OrdersPreviewHeader({
    super.key,
    required this.onCart,
    this.onBack,
    this.onRefundHistory,
    this.itemCount = 0,
  });

  final VoidCallback? onBack;
  final VoidCallback onCart;
  final VoidCallback? onRefundHistory;
  final int itemCount;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 50,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: PreviewUi.surface(context),
    leadingWidth: 44,
    leading: onBack == null
        ? const SizedBox(width: 44)
        : IconButton(
            key: const Key('orders_back'),
            tooltip: 'Quay lại',
            onPressed: onBack,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back, color: _ordersPreviewAccent),
          ),
    title: Text(
      'Đơn hàng',
      style: TextStyle(
        color: PreviewUi.text(context),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      if (onRefundHistory != null)
        IconButton(
          key: const Key('orders_refund_history'),
          tooltip: 'Lịch sử hoàn tiền',
          onPressed: onRefundHistory,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.receipt_long_outlined, size: 20),
        ),
      SizedBox(
        width: 44,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            IconButton(
              key: const Key('orders_cart_action'),
              tooltip: 'Giỏ hàng',
              onPressed: onCart,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.shopping_bag_outlined, size: 22),
            ),
            if (itemCount > 0)
              Positioned(
                right: 1,
                top: 4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _ordersPreviewAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    itemCount > 99 ? '99+' : '$itemCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class OrdersPreviewBody extends StatelessWidget {
  const OrdersPreviewBody({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final OrdersListViewState state;
  final ValueChanged<OrdersListIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasError) {
      return _OrdersPreviewMessage(
        title: 'Không thể tải danh sách đơn hàng.',
        actionLabel: 'Thử lại',
        onAction: () => onIntent(const OrdersListRetryRequested()),
      );
    }
    final showingHistory = state.filter == OrdersListFilter.history;
    final orders = showingHistory
        ? state.items.where((item) => !item.isActive).toList(growable: false)
        : state.items.where((item) => item.isActive).toList(growable: false);
    return Column(
      children: [
        _OrdersPreviewTabs(
          showingHistory: showingHistory,
          onSelect: (history) => onIntent(
            OrdersListFilterChanged(
              history ? OrdersListFilter.history : OrdersListFilter.active,
            ),
          ),
        ),
        Expanded(
          child: orders.isEmpty
              ? _OrdersPreviewMessage(
                  title: 'Chưa có đơn hàng',
                  message: 'Đặt món yêu thích và theo dõi đơn tại đây.',
                  actionLabel: 'Khám phá món ngon',
                  onAction: () => onIntent(const OrdersListBackRequested()),
                )
              : RefreshIndicator(
                  onRefresh: () async =>
                      onIntent(const OrdersListRefreshRequested()),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: orders.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) => OrdersPreviewCard(
                      order: orders[index],
                      onTap: () => onIntent(
                        OrdersListDetailsRequested(orders[index].id),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _OrdersPreviewTabs extends StatelessWidget {
  const _OrdersPreviewTabs({
    required this.showingHistory,
    required this.onSelect,
  });

  final bool showingHistory;
  final ValueChanged<bool> onSelect;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: PreviewUi.surface(context),
      border: Border(bottom: BorderSide(color: PreviewUi.divider(context))),
    ),
    child: Row(
      children: [
        _OrdersPreviewTab(
          label: 'Đang đến',
          selected: !showingHistory,
          onTap: () => onSelect(false),
        ),
        _OrdersPreviewTab(
          label: 'Lịch sử',
          selected: showingHistory,
          onTap: () => onSelect(true),
        ),
      ],
    ),
  );
}

class _OrdersPreviewTab extends StatelessWidget {
  const _OrdersPreviewTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? _ordersPreviewAccent : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _ordersPreviewAccent : PreviewUi.muted(context),
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}

class OrdersPreviewCard extends StatelessWidget {
  const OrdersPreviewCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  final OrdersListItemViewData order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: PreviewUi.surface(context),
    child: InkWell(
      key: Key('order_card_${order.id}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: PreviewUi.muted(context),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 9),
            Text(
              order.statusLabel,
              style: TextStyle(
                color: _statusColor(order.statusTone),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                AppContentImage(
                  imageUrl: _mockOrderImage(order.id),
                  semanticLabel: 'Món trong đơn ${order.id}',
                  width: 62,
                  height: 62,
                  borderRadius: BorderRadius.circular(3),
                  placeholderIcon: Icons.fastfood_outlined,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Món ăn trong đơn',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${order.itemCount} món',
                        style: TextStyle(
                          fontSize: 10,
                          color: PreviewUi.muted(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _money(order.totalAmount),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Đơn #${order.id}',
              style: TextStyle(fontSize: 10, color: PreviewUi.muted(context)),
            ),
          ],
        ),
      ),
    ),
  );
}

class _OrdersPreviewMessage extends StatelessWidget {
  const _OrdersPreviewMessage({
    required this.title,
    required this.actionLabel,
    required this.onAction,
    this.message,
  });

  final String title;
  final String? message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.receipt_long, size: 55, color: Color(0xFFDCCBC2)),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
            ),
          ],
          const SizedBox(height: 22),
          SizedBox(
            width: 220,
            height: 44,
            child: FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: _ordersPreviewAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Text(actionLabel),
            ),
          ),
        ],
      ),
    ),
  );
}

Color _statusColor(OrdersListStatusTone tone) => switch (tone) {
  OrdersListStatusTone.pending => const Color(0xFFE67E22),
  OrdersListStatusTone.delivering => const Color(0xFF00A38C),
  OrdersListStatusTone.delivered => const Color(0xFF28956A),
  OrdersListStatusTone.cancelled => const Color(0xFFE74C3C),
  OrdersListStatusTone.noDriver => const Color(0xFFD35400),
};

String _mockOrderImage(int id) {
  const images = [
    'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2023111914492527567/photo/menueditor_item_c3d3f9b6b3564c77936cb73431bfdc0b_1700405329714594563.webp',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=240&q=80',
    'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=240&q=80',
  ];
  return images[id.abs() % images.length];
}

String _money(num value) => '${value.toStringAsFixed(0)}đ';
