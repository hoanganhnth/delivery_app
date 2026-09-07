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

class HomeServiceGrid extends StatelessWidget {
  const HomeServiceGrid({super.key, required this.onIntent});

  final ValueChanged<CatalogHomeIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.xs,
        AppSpacing.page,
        AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ServiceTile(
            icon: Icons.lunch_dining_rounded,
            label: 'Đồ ăn',
            backgroundColor: const Color(0xFFFFF4E5),
            iconColor: const Color(0xFFE67E22),
            onTap: () => onIntent(const CatalogHomeAllRestaurantsRequested()),
          ),
          _ServiceTile(
            icon: Icons.shopping_basket_rounded,
            label: 'Đi chợ',
            backgroundColor: const Color(0xFFE8F8F5),
            iconColor: const Color(0xFF27AE60),
            onTap: () => onIntent(const CatalogHomeAllRestaurantsRequested()),
          ),
          _ServiceTile(
            icon: Icons.electric_moped_rounded,
            label: 'Hỏa tốc',
            backgroundColor: const Color(0xFFE6FAF7),
            iconColor: const Color(0xFF00A38C),
            onTap: () => onIntent(const CatalogHomeAllRestaurantsRequested()),
          ),
          _ServiceTile(
            icon: Icons.local_offer_rounded,
            label: 'Ưu đãi',
            backgroundColor: const Color(0xFFFDEDEC),
            iconColor: const Color(0xFFE74C3C),
            onTap: () => onIntent(const CatalogHomeVouchersRequested()),
          ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
    return Container(
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
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadii.container,
        child: InkWell(
          borderRadius: AppRadii.container,
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: AppContentImage(
                  imageUrl: restaurant.imageUrl,
                  semanticLabel: strings.pilotRestaurantImage(restaurant.name),
                  height: 154,
                  width: double.infinity,
                  borderRadius: BorderRadius.zero,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1D20),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (restaurant.rating != null)
                          _Meta(
                            icon: Icons.star_rounded,
                            label: restaurant.rating!.toStringAsFixed(1),
                            color: const Color(0xFFF39C12),
                          ),
                        if (restaurant.deliveryTimeMinutes != null)
                          _Meta(
                            icon: Icons.schedule_rounded,
                            label:
                                '${restaurant.deliveryTimeMinutes} ${strings.min}',
                          ),
                        if (restaurant.distanceKm != null)
                          _Meta(
                            icon: Icons.near_me_rounded,
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
                            icon: Icons.delivery_dining_rounded,
                            label:
                                '${restaurant.deliveryFee!.toStringAsFixed(0)} ₫',
                          ),
                      ],
                    ),
                    if (restaurant.category?.trim().isNotEmpty == true) ...[
                      const SizedBox(height: 6),
                      Text(
                        restaurant.category!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF757F8A),
                          fontWeight: FontWeight.w500,
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
        color: color ?? const Color(0xFF757F8A),
      ),
      const SizedBox(width: AppSpacing.xxs),
      Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: const Color(0xFF555B62),
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class HomeLivestreamBanner extends StatelessWidget {
  const HomeLivestreamBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.page,
        AppSpacing.xs,
        AppSpacing.page,
        AppSpacing.xs,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B2A47), Color(0xFF2C3E50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A38C).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF00A38C).withValues(alpha: 0.5),
                        ),
                      ),
                      child: const Icon(
                        Icons.live_tv_rounded,
                        color: Color(0xFF00D2B4),
                        size: 28,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Livestream Ẩm Thực & Săn Deal',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Xem trực tiếp & nhận voucher độc quyền',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00A38C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Xem ngay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
