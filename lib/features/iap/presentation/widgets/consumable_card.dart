import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/generated/l10n.dart';

class ConsumableCard extends ConsumerWidget {
  final ConsumableEntity product;
  final bool isLoading;
  final VoidCallback onBuy;

  const ConsumableCard({
    super.key,
    required this.product,
    required this.isLoading,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: ref.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  product.type.icon,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.product.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.product.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ref.colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+${product.value.toInt()} ${product.type.displayName}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ref.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Price & Buy Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.product.price,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ref.colors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isLoading ? null : onBuy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ref.colors.primary,
                    foregroundColor: ref.colors.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(s.iapBuy),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
