import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/shared/restaurant_card.dart';

import '../../application/catalog_home_intent.dart';
import '../../application/catalog_home_state.dart';

/// Pure rendering for the catalog landing tab. Navigation and restaurant I/O
/// are represented exclusively by [CatalogHomeIntent]s.
class CatalogHomeView extends StatelessWidget {
  const CatalogHomeView({
    super.key,
    required this.state,
    required this.onIntent,
    this.flashSaleBanner,
  });

  final CatalogHomeViewState state;
  final ValueChanged<CatalogHomeIntent> onIntent;
  final Widget? flashSaleBanner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Header(onIntent: onIntent)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 16.w),
              child: AmberSearchBar(
                placeholder: 'Bạn muốn ăn gì hôm nay?',
                showButton: false,
                onTap: () => onIntent(const CatalogHomeSearchRequested()),
              ),
            ),
          ),
          if (flashSaleBanner != null)
            SliverToBoxAdapter(child: flashSaleBanner),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Nhà hàng nổi bật',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed:
                        () => onIntent(
                          const CatalogHomeAllRestaurantsRequested(),
                        ),
                    child: const Text('Xem tất cả'),
                  ),
                ],
              ),
            ),
          ),
          _RestaurantContent(state: state, onIntent: onIntent, scheme: scheme),
          SliverToBoxAdapter(child: SizedBox(height: 140.w)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onIntent});

  final ValueChanged<CatalogHomeIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 8.w),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => onIntent(const CatalogHomeAddressRequested()),
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: scheme.primary,
                        size: 20.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Giao đến',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: scheme.onSurfaceVariant,
                        size: 18.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    'Chọn địa chỉ giao hàng',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          GlassActionButton(
            icon: Icons.notifications_outlined,
            onPressed:
                () => onIntent(const CatalogHomeNotificationsRequested()),
          ),
          SizedBox(width: 8.w),
          GlassActionButton(
            icon: Icons.shopping_cart_outlined,
            onPressed: () => onIntent(const CatalogHomeCartRequested()),
          ),
        ],
      ),
    );
  }
}

class _RestaurantContent extends StatelessWidget {
  const _RestaurantContent({
    required this.state,
    required this.onIntent,
    required this.scheme,
  });

  final CatalogHomeViewState state;
  final ValueChanged<CatalogHomeIntent> onIntent;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: CircularProgressIndicator(color: scheme.primary),
          ),
        ),
      );
    }
    if (state.hasError) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              children: [
                Icon(Icons.error_outline, color: scheme.error, size: 48.w),
                SizedBox(height: 12.w),
                Text(
                  'Lỗi: ${state.errorMessage}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: scheme.error),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (state.restaurants.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Text(
              'Không có nhà hàng nào',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final restaurant = state.restaurants[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: RestaurantCard(
              name: restaurant.name,
              imageUrl: restaurant.imageUrl,
              rating: restaurant.rating,
              deliveryTime:
                  restaurant.deliveryTimeMinutes == null
                      ? null
                      : '${restaurant.deliveryTimeMinutes} phút',
              category: restaurant.category,
              distance:
                  restaurant.distanceKm == null
                      ? null
                      : '${restaurant.distanceKm!.toStringAsFixed(1)} km',
              deliveryFee: _deliveryFee(restaurant.deliveryFee),
              isFreeDelivery: restaurant.deliveryFee == 0,
              onTap:
                  () => onIntent(CatalogHomeRestaurantRequested(restaurant.id)),
            ),
          );
        }, childCount: state.restaurants.length),
      ),
    );
  }

  String? _deliveryFee(double? fee) {
    if (fee == null) return null;
    if (fee == 0) return 'Miễn phí giao hàng';
    return '${fee.toStringAsFixed(0)}đ';
  }
}
