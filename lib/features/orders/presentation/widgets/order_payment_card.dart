import 'package:flutter/material.dart';
import '../../domain/entities/order_entity.dart';

/// Widget hiển thị thông tin thanh toán
class OrderPaymentCard extends StatelessWidget {
  final OrderEntity order;

  const OrderPaymentCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getPaymentIcon(order.paymentMethod),
                  color: theme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Thông tin thanh toán',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildPaymentRow(
              context,
              'Phương thức thanh toán',
              order.paymentMethod.vietnameseText,
            ),
            const Divider(height: 20),
            _buildPriceRow(
              context,
              'Tổng tiền món ăn',
              _calculateSubtotal(),
              false,
            ),
            const SizedBox(height: 8),
            _buildPriceRow(
              context,
              'Phí giao hàng',
              _getDeliveryFee(),
              false,
            ),
            const Divider(height: 20),
            _buildPriceRow(
              context,
              'Tổng cộng',
              order.totalAmount,
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(
    BuildContext context,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(
    BuildContext context,
    String label,
    double amount,
    bool isTotal,
  ) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal 
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        Text(
          _formatCurrency(amount),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? theme.primaryColor : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  IconData _getPaymentIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cod:
        return Icons.money;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.wallet:
        return Icons.wallet;
    }
  }

  double _calculateSubtotal() {
    return order.items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double _getDeliveryFee() {
    // Mock delivery fee - in real app this would come from order data
    return order.totalAmount * 0.1; // 10% delivery fee as example
  }

  String _formatCurrency(double amount) {
    return '${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    )}đ';
  }
}
