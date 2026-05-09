import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'order_payment_row.dart';
import 'order_price_row.dart';

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
        padding: EdgeInsets.all(16.w),
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
                SizedBox(width: 8.w),
                Text(
                  S.of(context).paymentInfo,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.w),
            OrderPaymentRow(
              label: S.of(context).paymentMethodText,
              value: order.paymentMethod.vietnameseText,
            ),
            Divider(height: 20.w),
            OrderPriceRow(
              label: S.of(context).subtotal,
              amount: _calculateSubtotal(),
              isTotal: false,
            ),
            SizedBox(height: 8.w),
            OrderPriceRow(
              label: S.of(context).deliveryFee,
              amount: _getDeliveryFee(),
              isTotal: false,
            ),
            Divider(height: 20.w),
            OrderPriceRow(
              label: S.of(context).total,
              amount: order.totalAmount,
              isTotal: true,
            ),
          ],
        ),
      ),
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
}
