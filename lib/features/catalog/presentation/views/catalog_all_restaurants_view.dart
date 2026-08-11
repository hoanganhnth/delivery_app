import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Pure restaurant-index rendering. All route changes and loads are intents.
class CatalogAllRestaurantsView extends StatelessWidget {
  const CatalogAllRestaurantsView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CatalogAllRestaurantsViewState state;
  final ValueChanged<CatalogAllRestaurantsIntent> onIntent;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Tất cả nhà hàng'),
      leading: IconButton(
        tooltip: 'Quay lại',
        onPressed: () => onIntent(const CatalogAllRestaurantsBackRequested()),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          tooltip: 'Tìm kiếm',
          onPressed: () =>
              onIntent(const CatalogAllRestaurantsSearchRequested()),
          icon: const Icon(Icons.search),
        ),
      ],
    ),
    body: switch ((state.isLoading, state.hasError, state.isEmpty)) {
      (true, _, _) => const Center(child: CircularProgressIndicator()),
      (_, true, _) => _AllRestaurantsMessage(
        icon: Icons.error_outline,
        message: 'Không thể tải danh sách nhà hàng. Vui lòng thử lại.',
        actionLabel: 'Thử lại',
        onAction: () => onIntent(const CatalogAllRestaurantsRetryRequested()),
      ),
      (_, _, true) => const _AllRestaurantsMessage(
        icon: Icons.storefront_outlined,
        message: 'Chưa có nhà hàng nào.',
      ),
      _ => RefreshIndicator(
        onRefresh: () async =>
            onIntent(const CatalogAllRestaurantsRefreshRequested()),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: state.restaurants.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final restaurant = state.restaurants[index];
            return _RestaurantIndexCard(
              restaurant: restaurant,
              onTap: () => onIntent(
                CatalogAllRestaurantsRestaurantRequested(restaurant.id),
              ),
            );
          },
        ),
      ),
    },
  );
}

class _RestaurantIndexCard extends StatelessWidget {
  const _RestaurantIndexCard({required this.restaurant, required this.onTap});

  final CatalogRestaurantViewData restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AppSurfaceCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: AppRadii.card,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 168,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: restaurant.imageUrl == null
                    ? ColoredBox(
                        color: scheme.surfaceContainerHighest,
                        child: const Icon(Icons.restaurant, size: 56),
                      )
                    : Image.network(
                        restaurant.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => ColoredBox(
                          color: scheme.surfaceContainerHighest,
                          child: const Icon(Icons.restaurant, size: 56),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (restaurant.description?.trim().isNotEmpty == true) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      restaurant.description!.trim(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ],
                  if (restaurant.address?.trim().isNotEmpty == true) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            restaurant.address!.trim(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.xs,
                    children: [
                      if (restaurant.rating != null)
                        _RestaurantFact(
                          icon: Icons.star,
                          iconColor: Colors.orange,
                          label: restaurant.reviewCount == null
                              ? restaurant.rating!.toStringAsFixed(1)
                              : '${restaurant.rating!.toStringAsFixed(1)} (${restaurant.reviewCount})',
                        ),
                      if (restaurant.deliveryTimeMinutes != null)
                        _RestaurantFact(
                          icon: Icons.access_time_outlined,
                          label: '${restaurant.deliveryTimeMinutes} phút',
                        ),
                      if (restaurant.deliveryFee != null)
                        _RestaurantFact(
                          icon: Icons.delivery_dining_outlined,
                          label: restaurant.deliveryFee == 0
                              ? 'Miễn phí giao hàng'
                              : '${NumberFormat('#,###', 'vi_VN').format(restaurant.deliveryFee)}đ',
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RestaurantFact extends StatelessWidget {
  const _RestaurantFact({
    required this.icon,
    required this.label,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        size: 16,
        color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      const SizedBox(width: AppSpacing.xxs),
      Text(label),
    ],
  );
}

class _AllRestaurantsMessage extends StatelessWidget {
  const _AllRestaurantsMessage({
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48),
          const SizedBox(height: AppSpacing.md),
          Text(message, textAlign: TextAlign.center),
          if (onAction != null) ...[
            const SizedBox(height: AppSpacing.md),
            FilledButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    ),
  );
}
