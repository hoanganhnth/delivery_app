import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPriceRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isTotal;

  const OrderPriceRow({
    super.key,
    required this.label,
    required this.amount,
    required this.isTotal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final NumberFormat currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    
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
          currencyFormat.format(amount),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? theme.primaryColor : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
