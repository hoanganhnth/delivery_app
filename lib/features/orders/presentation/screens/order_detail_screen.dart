import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import '../providers/providers.dart';
import '../../../../generated/l10n.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final num orderId;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load order detail when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderDetailProvider.notifier).getOrderById(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailState = ref.watch(orderDetailProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${S.of(context).order} #${widget.orderId}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: theme.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildBody(orderDetailState, theme),
    );
  }

  Widget _buildBody(OrderDetailState orderDetailState, ThemeData theme) {
    if (orderDetailState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderDetailState.errorMessage != null) {
      return _buildErrorWidget(orderDetailState.errorMessage!, theme);
    }

    if (orderDetailState.order == null) {
      return _buildNotFoundWidget(theme);
    }

    final order = orderDetailState.order!;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(orderDetailProvider.notifier).getOrderById(widget.orderId);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(order, theme),
            const SizedBox(height: 16),
            _buildCustomerInfoCard(order, theme),
            const SizedBox(height: 16),
            _buildOrderItemsCard(order, theme),
            const SizedBox(height: 16),
            _buildPaymentCard(order, theme),
            const SizedBox(height: 16),
            if (order.status == OrderStatus.pending) _buildActionButtons(order, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(OrderEntity order, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getStatusIcon(order.status),
                  color: order.status.color,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Trạng thái đơn hàng',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: order.status.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: order.status.color.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                order.status.vietnameseText,
                style: TextStyle(
                  color: order.status.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (order.estimatedDeliveryTime != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Thời gian dự kiến: ${_formatDateTime(order.estimatedDeliveryTime!)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfoCard(OrderEntity order, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin khách hàng',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: Icons.person,
              label: 'Tên khách hàng',
              value: order.customerName,
              theme: theme,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.phone,
              label: 'Số điện thoại',
              value: order.customerPhone,
              theme: theme,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.location_on,
              label: 'Địa chỉ giao hàng',
              value: order.deliveryAddress,
              theme: theme,
            ),
            if (order.notes != null && order.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                icon: Icons.note,
                label: 'Ghi chú',
                value: order.notes!,
                theme: theme,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsCard(OrderEntity order, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chi tiết đơn hàng',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...order.items.map((item) => _buildOrderItem(item, theme)),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_formatCurrency(order.totalAmount)}đ',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderItemEntity item, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.menuItemName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (item.notes != null && item.notes!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Ghi chú: ${item.notes}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'x${item.quantity}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${_formatCurrency(item.totalPrice)}đ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(OrderEntity order, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin thanh toán',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: _getPaymentIcon(order.paymentMethod),
              label: 'Phương thức thanh toán',
              value: order.paymentMethod.vietnameseText,
              theme: theme,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.access_time,
              label: 'Thời gian đặt hàng',
              value: _formatDateTime(order.createdAt ?? DateTime.now()),
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(OrderEntity order, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showCancelOrderDialog(order),
                icon: const Icon(Icons.cancel, size: 20),
                label: Text(S.of(context).cancelOrder),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String errorMessage, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).error,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(orderDetailProvider.notifier).getOrderById(widget.orderId);
              },
              icon: const Icon(Icons.refresh),
              label: Text(S.of(context).tryAgain),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFoundWidget(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Không tìm thấy đơn hàng',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Đơn hàng #${widget.orderId} không tồn tại hoặc đã bị xóa.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelOrderDialog(OrderEntity order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).cancelOrder),
        content: Text(S.of(context).cancelOrderConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          Consumer(
            builder: (context, ref, child) {
              final cancelAsync = ref.watch(cancelOrderProvider);

              return cancelAsync.when(
                data: (success) => TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final result = await ref
                        .read(cancelOrderProvider.notifier)
                        .cancelOrder(order.id!);
                    if (result && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).orderCancelled),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Refresh order detail
                      ref.read(orderDetailProvider.notifier).getOrderById(widget.orderId);
                    }
                  },
                  child: Text(
                    S.of(context).confirm,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                loading: () => const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (error, _) => TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).error),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.schedule;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.preparing:
        return Icons.restaurant;
      case OrderStatus.ready:
        return Icons.shopping_bag;
      case OrderStatus.pickedUp:
        return Icons.local_shipping;
      case OrderStatus.delivering:
        return Icons.delivery_dining;
      case OrderStatus.delivered:
        return Icons.done_all;
      case OrderStatus.cancelled:
        return Icons.cancel;
    }
  }

  IconData _getPaymentIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return Icons.money;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.wallet:
        return Icons.account_balance_wallet;
    }
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
