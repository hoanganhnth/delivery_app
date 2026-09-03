import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/core/widgets/inputs/amber_search_bar.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CatalogHomeHeader extends StatelessWidget {
  const CatalogHomeHeader({
    super.key,
    required this.onIntent,
    this.deliveryAddress,
  });

  final ValueChanged<CatalogHomeIntent> onIntent;
  final String? deliveryAddress;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final address = deliveryAddress?.trim();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.sm,
        AppSpacing.page,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              button: true,
              label:
                  '${strings.pilotHomeDeliverTo}, ${address?.isNotEmpty == true ? address : strings.pilotHomeSelectAddress}',
              child: InkWell(
                onTap: () => onIntent(const CatalogHomeAddressRequested()),
                borderRadius: AppRadii.control,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: scheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Text(
                            strings.pilotHomeDeliverTo,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: scheme.onSurfaceVariant,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        address?.isNotEmpty == true
                            ? address!
                            : strings.pilotHomeSelectAddress,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          AppIconButton(
            tooltip: strings.pilotHomeOpenNotifications,
            icon: Icons.notifications_outlined,
            onPressed: () =>
                onIntent(const CatalogHomeNotificationsRequested()),
          ),
          const SizedBox(width: AppSpacing.xxs),
          AppIconButton(
            tooltip: strings.pilotHomeOpenCart,
            icon: Icons.shopping_cart_outlined,
            onPressed: () => onIntent(const CatalogHomeCartRequested()),
          ),
        ],
      ),
    );
  }
}

class CatalogHomeSearchLauncher extends StatelessWidget {
  const CatalogHomeSearchLauncher({super.key, required this.onIntent});

  final ValueChanged<CatalogHomeIntent> onIntent;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.page,
      AppSpacing.xxs,
      AppSpacing.page,
      AppSpacing.md,
    ),
    child: AmberSearchBar(
      placeholder: S.of(context).pilotHomeSearchHint,
      showButton: false,
      onTap: () => onIntent(const CatalogHomeSearchRequested()),
    ),
  );
}

class CatalogRestaurantList extends StatelessWidget {
  const CatalogRestaurantList({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CatalogHomeViewState state;
  final ValueChanged<CatalogHomeIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    if (state.isLoading) {
      return AppStateFeedback.loading(title: strings.loading);
    }
    if (state.hasError) {
      return AppStateFeedback.error(
        title: strings.error,
        message: state.errorMessage,
      );
    }
    if (state.restaurants.isEmpty) {
      return AppStateFeedback.empty(
        title: strings.pilotHomeNoRestaurants,
        message: strings.pilotHomeNoRestaurantsMessage,
      );
    }
    return Column(
      children: [
        for (final restaurant in state.restaurants)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: CatalogRestaurantCard(
              restaurant: restaurant,
              onTap: () =>
                  onIntent(CatalogHomeRestaurantRequested(restaurant.id)),
            ),
          ),
      ],
    );
  }
}

class CatalogRestaurantCard extends StatelessWidget {
  const CatalogRestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  final CatalogRestaurantViewData restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    return AppSurfaceCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      semanticLabel: restaurant.name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppContentImage(
            imageUrl: restaurant.imageUrl,
            semanticLabel: strings.pilotRestaurantImage(restaurant.name),
            height: 152,
            width: double.infinity,
            borderRadius: BorderRadius.zero,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (restaurant.rating != null)
                      _Meta(
                        icon: Icons.star_rounded,
                        label: restaurant.rating!.toStringAsFixed(1),
                        color: scheme.primary,
                      ),
                    if (restaurant.deliveryTimeMinutes != null)
                      _Meta(
                        icon: Icons.schedule,
                        label:
                            '${restaurant.deliveryTimeMinutes} ${strings.min}',
                      ),
                    if (restaurant.distanceKm != null)
                      _Meta(
                        icon: Icons.near_me_outlined,
                        label:
                            '${restaurant.distanceKm!.toStringAsFixed(1)} km',
                      ),
                    if (restaurant.deliveryFee == 0)
                      AppBadge(
                        label: strings.freeDelivery,
                        tone: AppBadgeTone.success,
                      )
                    else if (restaurant.deliveryFee != null)
                      _Meta(
                        icon: Icons.delivery_dining_outlined,
                        label:
                            '${restaurant.deliveryFee!.toStringAsFixed(0)} ₫',
                      ),
                  ],
                ),
                if (restaurant.category?.trim().isNotEmpty == true) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    restaurant.category!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        size: 16,
        color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      const SizedBox(width: AppSpacing.xxs),
      Text(label, style: Theme.of(context).textTheme.labelMedium),
    ],
  );
}
