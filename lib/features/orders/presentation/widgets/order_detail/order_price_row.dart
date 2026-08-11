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
    final NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(width: 8),
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
