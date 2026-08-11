import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/catalog_restaurant_detail_intent.dart';
import '../../application/catalog_restaurant_detail_state.dart';

class CatalogMenuItemCard extends StatelessWidget {
  const CatalogMenuItemCard({
    super.key,
    required this.item,
    required this.onIntent,
  });

  final CatalogMenuItemViewData item;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final statusText = switch (item.availability) {
      CatalogMenuAvailability.soldOut => 'Hết hàng',
      CatalogMenuAvailability.unavailable => 'Không khả dụng',
      CatalogMenuAvailability.available => null,
    };
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      child: Opacity(
        opacity: item.isAvailable ? 1 : 0.6,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              _MenuImage(imageUrl: item.imageUrl),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.w),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.hasFlashSale)
                              Text(
                                '${item.catalogPrice.toStringAsFixed(0)}đ',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                            Text(
                              '${item.displayedPrice.toStringAsFixed(0)}đ',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: scheme.primary,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (statusText != null)
                          _StatusBadge(text: statusText)
                        else
                          _QuantityControl(item: item, onIntent: onIntent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuImage extends StatelessWidget {
  const _MenuImage({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 80.w,
        height: 80.w,
        child: imageUrl == null
            ? ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.fastfood),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.fastfood),
                ),
              ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outline,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({required this.item, required this.onIntent});

  final CatalogMenuItemViewData item;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: scheme.primary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.quantity > 0)
            IconButton(
              key: Key('menu_decrement_${item.id}'),
              onPressed: () =>
                  onIntent(CatalogRestaurantDetailDecrementRequested(item.id!)),
              icon: Icon(
                item.quantity > 1 ? Icons.remove : Icons.delete_outline,
                size: 16,
                color: item.quantity > 1 ? scheme.primary : scheme.error,
              ),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              padding: EdgeInsets.zero,
            ),
          if (item.quantity > 0)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text('${item.quantity}'),
            ),
          IconButton(
            key: Key('menu_increment_${item.id}'),
            onPressed: item.canAdd
                ? () => onIntent(
                    CatalogRestaurantDetailIncrementRequested(item.id!),
                  )
                : null,
            icon: Icon(Icons.add, size: 16, color: scheme.primary),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class CatalogRestaurantCartButton extends StatelessWidget {
  const CatalogRestaurantCartButton({
    super.key,
    required this.itemCount,
    required this.totalAmount,
    required this.onPressed,
  });

  final int itemCount;
  final double totalAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isEmpty = itemCount == 0;
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 16.w),
        child: ElevatedButton(
          onPressed: isEmpty ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag_outlined),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  isEmpty
                      ? 'Chưa có món trong giỏ'
                      : 'Xem giỏ hàng ($itemCount)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isEmpty) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.onPrimary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('${totalAmount.toStringAsFixed(0)}đ'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
