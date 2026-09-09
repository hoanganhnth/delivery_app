import 'package:delivery_app/core/design_system/components/app_image.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/shared/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../application/catalog_search_state.dart';

class CatalogDishSearchResultTile extends StatelessWidget {
  const CatalogDishSearchResultTile({
    super.key,
    required this.item,
    required this.onTap,
  });
  final CatalogDishSearchViewData item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppContentImage(
                imageUrl: item.imageUrl,
                semanticLabel: item.name,
                width: 86,
                height: 86,
                borderRadius: BorderRadius.circular(3),
                placeholderIcon: Icons.fastfood_outlined,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (item.description?.trim().isNotEmpty == true) ...[
                      const SizedBox(height: 6),
                      Text(
                        item.description!.trim(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (item.price != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        '${NumberFormat('#,###', 'vi_VN').format(item.price)} ₫',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
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

class CatalogRestaurantSearchResultTile extends StatelessWidget {
  const CatalogRestaurantSearchResultTile({
    super.key,
    required this.item,
    required this.onTap,
  });
  final CatalogRestaurantSearchViewData item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => RestaurantCard(
    name: item.name,
    imageUrl: item.imageUrl,
    rating: item.rating ?? 4.8,
    distance: item.distanceKm == null
        ? '1.2 km'
        : '${item.distanceKm!.toStringAsFixed(1)} km',
    deliveryTime: item.deliveryTimeMinutes == null
        ? '20–30 phút'
        : '${item.deliveryTimeMinutes} phút',
    badgeLabel: 'Yêu thích',
    promotionLabels: const ['Freeship Xtra', 'Giảm 15.000đ'],
    metadataSeparator: ' | ',
    onTap: onTap,
  );
}
