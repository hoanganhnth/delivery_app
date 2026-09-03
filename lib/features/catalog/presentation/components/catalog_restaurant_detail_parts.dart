import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CatalogRestaurantHero extends StatelessWidget {
  const CatalogRestaurantHero({super.key, required this.restaurant});

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      AppContentImage(
        imageUrl: restaurant.imageUrl,
        semanticLabel: S.of(context).pilotRestaurantImage(restaurant.name),
        borderRadius: BorderRadius.zero,
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.76)],
          ),
        ),
      ),
      Positioned(
        left: AppSpacing.page,
        right: AppSpacing.page,
        bottom: AppSpacing.lg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (restaurant.description?.trim().isNotEmpty == true) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                restaurant.description!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    ],
  );
}

class CatalogRestaurantInfo extends StatelessWidget {
  const CatalogRestaurantInfo({super.key, required this.restaurant});

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final openingHours =
        restaurant.openingHour != null && restaurant.closingHour != null
        ? '${restaurant.openingHour} – ${restaurant.closingHour}'
        : strings.pilotRestaurantOpeningUnknown;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.page),
      child: AppSurfaceCard(
        child: Column(
          children: [
            _InfoRow(
              icon: Icons.location_on_outlined,
              color: scheme.primary,
              child: Text(restaurant.address),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Divider(),
            ),
            _InfoRow(
              icon: Icons.schedule,
              color: scheme.secondary,
              child: Row(
                children: [
                  Expanded(child: Text(openingHours)),
                  if (restaurant.isOpen != null)
                    AppBadge(
                      label: restaurant.isOpen!
                          ? strings.pilotRestaurantOpen
                          : strings.pilotRestaurantClosed,
                      tone: restaurant.isOpen!
                          ? AppBadgeTone.success
                          : AppBadgeTone.neutral,
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

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.color,
    required this.child,
  });

  final IconData icon;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color, size: 20),
      const SizedBox(width: AppSpacing.sm),
      Expanded(child: child),
    ],
  );
}

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
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final statusText = switch (item.availability) {
      CatalogMenuAvailability.soldOut => strings.outOfStock,
      CatalogMenuAvailability.unavailable => strings.unavailable,
      CatalogMenuAvailability.available => null,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.xs,
      ),
      child: Opacity(
        opacity: item.isAvailable ? 1 : 0.62,
        child: AppSurfaceCard(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppContentImage(
                imageUrl: item.imageUrl,
                semanticLabel: strings.pilotRestaurantImage(item.name),
                width: 88,
                height: 88,
                borderRadius: AppRadii.control,
                placeholderIcon: Icons.fastfood_outlined,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: _MenuPrice(item: item)),
                        if (statusText != null)
                          AppBadge(
                            label: statusText,
                            tone: AppBadgeTone.warning,
                          )
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

class _MenuPrice extends StatelessWidget {
  const _MenuPrice({required this.item});

  final CatalogMenuItemViewData item;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (item.hasFlashSale)
        Text(
          '${item.catalogPrice.toStringAsFixed(0)} ₫',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      Text(
        '${item.displayedPrice.toStringAsFixed(0)} ₫',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    ],
  );
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({required this.item, required this.onIntent});

  final CatalogMenuItemViewData item;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.quantity > 0) ...[
          AppIconButton(
            key: Key('menu_decrement_${item.id}'),
            tooltip: strings.pilotRestaurantRemoveItem(item.name),
            icon: item.quantity > 1 ? Icons.remove : Icons.delete_outline,
            onPressed: () =>
                onIntent(CatalogRestaurantDetailDecrementRequested(item.id!)),
          ),
          Semantics(
            label: '${item.quantity}',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              child: Text(
                '${item.quantity}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
        AppIconButton(
          key: Key('menu_increment_${item.id}'),
          tooltip: strings.pilotRestaurantAddItem(item.name),
          icon: Icons.add,
          onPressed: item.canAdd
              ? () => onIntent(
                  CatalogRestaurantDetailIncrementRequested(item.id!),
                )
              : null,
        ),
      ],
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
    final strings = S.of(context);
    final isEmpty = itemCount == 0;
    return AppStickyAction(
      child: AppButton(
        label: isEmpty
            ? strings.pilotRestaurantEmptyCart
            : strings.pilotRestaurantViewCartLabel(itemCount),
        semanticLabel: isEmpty
            ? strings.pilotRestaurantEmptyCart
            : strings.pilotRestaurantViewCart(itemCount),
        icon: Icons.shopping_bag_outlined,
        onPressed: isEmpty ? null : onPressed,
        expand: true,
      ),
    );
  }
}
