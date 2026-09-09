import 'package:delivery_app/features/orders/application/order_detail_intent.dart';
import 'package:delivery_app/features/orders/application/order_detail_state.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

const _orderDetailPreviewAccent = Color(0xFFEE4D2D);

class OrderDetailPreviewHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const OrderDetailPreviewHeader({
    super.key,
    required this.orderId,
    required this.onBack,
    required this.onCart,
  });

  final int orderId;
  final VoidCallback onBack;
  final VoidCallback onCart;

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
    leading: IconButton(
      key: const Key('order_detail_back'),
      tooltip: 'Quay lại',
      onPressed: onBack,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.arrow_back, color: _orderDetailPreviewAccent),
    ),
    title: Text(
      'Chi tiết đơn hàng',
      style: TextStyle(
        color: PreviewUi.text(context),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        key: const Key('order_detail_cart_action'),
        tooltip: 'Giỏ hàng',
        onPressed: onCart,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.shopping_bag_outlined, size: 22),
      ),
      const SizedBox(width: 4),
    ],
  );
}

class OrderDetailPreviewBody extends StatelessWidget {
  const OrderDetailPreviewBody({
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
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasError) {
      return _OrderDetailPreviewMessage(
        title: 'Không thể tải thông tin đơn hàng.',
        actionLabel: 'Thử lại',
        onAction: () => onIntent(const OrderDetailRetryRequested()),
      );
    }
    if (order == null) {
      return _OrderDetailPreviewMessage(
        title: 'Chưa có đơn này',
        message: 'Hãy tạo một đơn để xem chi tiết tại đây.',
        actionLabel: 'Quay lại',
        onAction: () => onIntent(const OrderDetailBackRequested()),
      );
    }
    return RefreshIndicator(
      onRefresh: () async => onIntent(const OrderDetailRefreshRequested()),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          OrderDetailPreviewStatus(order: order),
          if (order.canTrackingRealtime) ...[
            const SizedBox(height: 8),
            tracking,
          ],
          const SizedBox(height: 8),
          OrderDetailPreviewSummary(order: order),
          const SizedBox(height: 8),
          OrderDetailPreviewAddress(order: order),
          if (order.canCancel)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
              child: OutlinedButton(
                key: const Key('order_detail_cancel'),
                onPressed: state.isActionInProgress
                    ? null
                    : () => onIntent(const OrderDetailCancelRequested()),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _orderDetailPreviewAccent,
                  side: const BorderSide(color: _orderDetailPreviewAccent),
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: const Text('Hủy đơn hàng'),
              ),
            ),
          if (!order.canCancel) const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class OrderDetailPreviewStatus extends StatelessWidget {
  const OrderDetailPreviewStatus({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final (label, message, icon) = switch (order.status) {
      OrderStatus.pending => (
        'Chờ xác nhận',
        'Quán đang tiếp nhận đơn hàng của bạn.',
        Icons.delivery_dining,
      ),
      OrderStatus.delivering => (
        'Đang giao',
        'Tài xế đang mang món ngon đến bạn.',
        Icons.delivery_dining,
      ),
      OrderStatus.delivered => (
        'Đã giao',
        'Chúc bạn ngon miệng!',
        Icons.check_circle,
      ),
      OrderStatus.cancelled => (
        'Đã hủy',
        'Đơn hàng đã được hủy.',
        Icons.cancel,
      ),
      OrderStatus.shipperNotFound => (
        'Không tìm được shipper',
        'Đơn hàng chưa thể tiếp tục giao.',
        Icons.cancel,
      ),
    };
    return Container(
      color: PreviewUi.accentSurface(context, alpha: .07),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        children: [
          Icon(icon, size: 48, color: _orderDetailPreviewAccent),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PreviewUi.accent,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: PreviewUi.text(context)),
          ),
        ],
      ),
    );
  }
}

class OrderDetailPreviewSummary extends StatelessWidget {
  const OrderDetailPreviewSummary({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) => _OrderDetailPreviewSection(
    title: order.restaurantName ?? 'Nhà hàng',
    child: Column(
      children: [
        for (final item in order.items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${item.quantity}× ${item.menuItemName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  _money(item.totalPrice),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Tổng thanh toán',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                _money(order.totalAmount),
                style: const TextStyle(
                  color: _orderDetailPreviewAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Thanh toán khi nhận hàng',
            style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
          ),
        ),
      ],
    ),
  );
}

class OrderDetailPreviewAddress extends StatelessWidget {
  const OrderDetailPreviewAddress({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) => _OrderDetailPreviewSection(
    title: 'Địa chỉ nhận hàng',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${order.customerName} · ${order.customerPhone}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Text(order.deliveryAddress, style: const TextStyle(fontSize: 12)),
        if (order.notes?.trim().isNotEmpty == true) ...[
          const SizedBox(height: 7),
          Text(
            'Ghi chú: ${order.notes}',
            style: TextStyle(fontSize: 11, color: PreviewUi.muted(context)),
          ),
        ],
        const SizedBox(height: 6),
        Text(
          'Đơn #${order.id}',
          style: TextStyle(fontSize: 10, color: PreviewUi.muted(context)),
        ),
      ],
    ),
  );
}

class _OrderDetailPreviewSection extends StatelessWidget {
  const _OrderDetailPreviewSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    color: PreviewUi.surface(context),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

class _OrderDetailPreviewMessage extends StatelessWidget {
  const _OrderDetailPreviewMessage({
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
                backgroundColor: _orderDetailPreviewAccent,
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

String _money(num value) => '${value.toStringAsFixed(0)}đ';
