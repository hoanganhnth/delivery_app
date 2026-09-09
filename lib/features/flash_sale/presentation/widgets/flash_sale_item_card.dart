import 'package:flutter/material.dart';

import '../../domain/entities/flash_sale_item_entity.dart';

class FlashSaleItemCard extends StatelessWidget {
  const FlashSaleItemCard({super.key, required this.item, required this.onTap});

  final FlashSaleItemEntity item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 164,
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: scheme.surface,
        margin: const EdgeInsets.only(right: 12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: Key('flash_sale_item_${item.id}'),
          onTap: item.isSoldOut ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 76,
                  width: double.infinity,
                  child: item.imageUrl?.isNotEmpty == true
                      ? Image.network(
                          item.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => _placeholder(scheme),
                        )
                      : _placeholder(scheme),
                ),
                const SizedBox(height: 8),
                Text(
                  item.displayName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.flashSalePrice.toStringAsFixed(0)}đ',
                  style: TextStyle(
                    color: scheme.error,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '${item.originalPrice.toStringAsFixed(0)}đ',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: item.progress,
                  minHeight: 6,
                  color: scheme.error,
                  backgroundColor: scheme.errorContainer,
                ),
                const SizedBox(height: 3),
                Text(
                  item.isSoldOut
                      ? 'Đã bán hết'
                      : 'Còn ${item.remainingQuantity} suất',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholder(ColorScheme scheme) => ColoredBox(
    color: scheme.surfaceContainerHighest,
    child: Icon(Icons.local_offer_outlined, color: scheme.primary),
  );
}
