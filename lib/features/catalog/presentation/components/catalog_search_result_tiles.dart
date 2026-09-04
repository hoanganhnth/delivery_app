import 'package:delivery_app/core/design_system/components/app_image.dart';
import 'package:delivery_app/core/design_system/foundations/app_radii.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
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
    final scheme = theme.colorScheme;

    return ListTile(
      leading: AppContentImage(
        imageUrl: item.imageUrl,
        semanticLabel: item.name,
        width: 48,
        height: 48,
        borderRadius: AppRadii.control,
        placeholderIcon: Icons.fastfood_outlined,
      ),
      title: Text(
        item.name,
        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: item.description?.trim().isNotEmpty == true
          ? Text(
              item.description!.trim(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: item.price == null
          ? null
          : Text(
              '${NumberFormat('#,###', 'vi_VN').format(item.price)} ₫',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
      onTap: onTap,
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListTile(
      leading: AppContentImage(
        imageUrl: item.imageUrl,
        semanticLabel: item.name,
        width: 48,
        height: 48,
        borderRadius: AppRadii.control,
        placeholderIcon: Icons.storefront_outlined,
      ),
      title: Text(
        item.name,
        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
      ),
      subtitle: item.cuisine?.trim().isNotEmpty == true
          ? Text(
              item.cuisine!.trim(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: item.rating == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, color: scheme.primary, size: 18),
                const SizedBox(width: AppSpacing.xxs),
                Text(
                  item.rating!.toStringAsFixed(1),
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
      onTap: onTap,
    );
  }
}
