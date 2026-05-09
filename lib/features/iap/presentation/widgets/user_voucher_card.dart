import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/generated/l10n.dart';

class UserVoucherCard extends ConsumerWidget {
  final ConsumableEntity voucher;

  const UserVoucherCard({
    super.key,
    required this.voucher,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final isExpired = voucher.isExpired;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isExpired ? Colors.grey[200] : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Voucher Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isExpired
                    ? Colors.grey[400]
                    : ref.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  voucher.type.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Voucher Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.product.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isExpired ? Colors.grey : null,
                    ),
                  ),
                  if (voucher.code != null)
                    Text(
                      '${s.iapCode}: ${voucher.code}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ref.colors.textSecondary,
                      ),
                    ),
                  if (voucher.expiryDate != null)
                    Text(
                      isExpired
                          ? s.iapExpired
                          : s.iapExpires(_formatDate(voucher.expiryDate!)),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isExpired ? Colors.red : ref.colors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),

            // Value
            Text(
              voucher.type == ConsumableType.discountVoucher
                  ? '${voucher.value.toInt()}% ${s.iapOff}'
                  : '-\$${voucher.value.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isExpired ? Colors.grey : ref.colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
