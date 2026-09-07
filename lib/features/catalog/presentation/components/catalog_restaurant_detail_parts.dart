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
      ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        child: AppContentImage(
          imageUrl: restaurant.imageUrl,
          semanticLabel: S.of(context).pilotRestaurantImage(restaurant.name),
          borderRadius: BorderRadius.zero,
        ),
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.35),
              Colors.transparent,
              Colors.black.withValues(alpha: 0.72),
            ],
          ),
        ),
      ),
      Positioned(
        left: AppSpacing.page,
        right: AppSpacing.page,
        bottom: AppSpacing.md,
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
              const SizedBox(height: AppSpacing.xxs),
              Text(
                restaurant.description!,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.sm,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppRadii.container,
          border: Border.all(color: const Color(0xFFEDEFF2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.card),
        child: Column(
          children: [
            _InfoRow(
              icon: Icons.location_on_outlined,
              color: scheme.primary,
              child: Text(
                restaurant.address,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Divider(height: 1, color: Color(0xFFF3F4F6)),
            ),
            _InfoRow(
              icon: Icons.schedule_rounded,
              color: const Color(0xFF757F8A),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      openingHours,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ),
                  if (restaurant.isOpen != null)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: restaurant.isOpen!
                            ? const Color(0xFFE8F8F5)
                            : const Color(0xFFF0F2F5),
                        borderRadius: AppRadii.pillRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          restaurant.isOpen!
                              ? strings.pilotRestaurantOpen
                              : strings.pilotRestaurantClosed,
                          style: TextStyle(
                            color: restaurant.isOpen!
                                ? const Color(0xFF27AE60)
                                : const Color(0xFF757F8A),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadii.container,
            border: Border.all(color: const Color(0xFFEDEFF2), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AppContentImage(
                  imageUrl: item.imageUrl,
                  semanticLabel: strings.pilotRestaurantImage(item.name),
                  width: 88,
                  height: 88,
                  borderRadius: BorderRadius.zero,
                  placeholderIcon: Icons.fastfood_outlined,
                ),
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
                        color: const Color(0xFF1A1D20),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF757F8A),
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
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.quantity > 0) ...[
          Semantics(
            button: true,
            enabled: true,
            label: strings.pilotRestaurantRemoveItem(item.name),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F2F5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                key: Key('menu_decrement_${item.id}'),
                tooltip: strings.pilotRestaurantRemoveItem(item.name),
                padding: EdgeInsets.zero,
                icon: Icon(
                  item.quantity > 1 ? Icons.remove : Icons.delete_outline,
                  size: 16,
                  color: const Color(0xFF555B62),
                ),
                onPressed: () =>
                    onIntent(CatalogRestaurantDetailDecrementRequested(item.id!)),
              ),
            ),
          ),
          Semantics(
            label: '${item.quantity}',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${item.quantity}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
        Semantics(
          button: true,
          enabled: item.canAdd,
          label: strings.pilotRestaurantAddItem(item.name),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              key: Key('menu_increment_${item.id}'),
              tooltip: strings.pilotRestaurantAddItem(item.name),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              onPressed: item.canAdd
                  ? () => onIntent(
                      CatalogRestaurantDetailIncrementRequested(item.id!),
                    )
                  : null,
            ),
          ),
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
    final formattedTotal = '${totalAmount.toStringAsFixed(0)} ₫';
    return AppStickyAction(
      child: AppButton(
        label: isEmpty
            ? strings.pilotRestaurantEmptyCart
            : '${strings.pilotRestaurantViewCartLabel(itemCount)} · '
                  '$formattedTotal',
        semanticLabel: isEmpty
            ? strings.pilotRestaurantEmptyCart
            : '${strings.pilotRestaurantViewCart(itemCount)}, $formattedTotal',
        icon: Icons.shopping_bag_outlined,
        onPressed: isEmpty ? null : onPressed,
        expand: true,
      ),
    );
  }
}
