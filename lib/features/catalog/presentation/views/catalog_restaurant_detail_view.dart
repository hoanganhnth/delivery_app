import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/catalog_restaurant_detail_intent.dart';
import '../../application/catalog_restaurant_detail_state.dart';
import '../components/catalog_restaurant_detail_parts.dart';

/// Pure detail rendering; all I/O, cart writes, confirmation and navigation
/// are represented by [CatalogRestaurantDetailIntent]s.
class CatalogRestaurantDetailView extends StatelessWidget {
  const CatalogRestaurantDetailView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CatalogRestaurantDetailViewState state;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) return _loading(context);
    if (state.hasError) return _error(context, state.errorMessage!);
    final restaurant = state.restaurant;
    if (restaurant == null) return _notFound(context);

    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280.w,
            pinned: true,
            backgroundColor: scheme.surface,
            leading: IconButton(
              onPressed: () =>
                  onIntent(const CatalogRestaurantDetailBackRequested()),
              icon: const Icon(Icons.arrow_back),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _Hero(restaurant: restaurant),
            ),
          ),
          SliverToBoxAdapter(child: _Info(restaurant: restaurant)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
              child: Text(
                'Thực đơn',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return CatalogMenuItemCard(
                item: state.menuItems[index],
                onIntent: onIntent,
              );
            }, childCount: state.menuItems.length),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 100.w)),
        ],
      ),
      bottomNavigationBar: CatalogRestaurantCartButton(
        itemCount: state.cartItemsCount,
        totalAmount: state.cartTotalAmount,
        onPressed: () => onIntent(const CatalogRestaurantDetailCartRequested()),
      ),
    );
  }

  Widget _loading(BuildContext context) => Scaffold(
    body: Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );

  Widget _error(BuildContext context, String message) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () => onIntent(const CatalogRestaurantDetailBackRequested()),
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text('Chi tiết nhà hàng'),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(message, textAlign: TextAlign.center),
      ),
    ),
  );

  Widget _notFound(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: () => onIntent(const CatalogRestaurantDetailBackRequested()),
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text('Chi tiết nhà hàng'),
    ),
    body: const Center(child: Text('Không tìm thấy nhà hàng')),
  );
}

class _Hero extends StatelessWidget {
  const _Hero({required this.restaurant});

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        restaurant.imageUrl == null
            ? ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.restaurant, size: 80),
              )
            : Image.network(
                restaurant.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.restaurant, size: 80),
                ),
              ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.75),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.w,
          right: 20.w,
          bottom: 20.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (restaurant.description?.trim().isNotEmpty == true) ...[
                SizedBox(height: 6.w),
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
}

class _Info extends StatelessWidget {
  const _Info({required this.restaurant});

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final openingHours =
        restaurant.openingHour != null && restaurant.closingHour != null
        ? '${restaurant.openingHour} - ${restaurant.closingHour}'
        : 'Giờ mở cửa chưa được cập nhật';
    return Card(
      margin: EdgeInsets.all(16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: scheme.primary),
                SizedBox(width: 12.w),
                Expanded(child: Text(restaurant.address)),
              ],
            ),
            SizedBox(height: 12.w),
            Row(
              children: [
                Icon(Icons.access_time, color: scheme.secondary),
                SizedBox(width: 12.w),
                Expanded(child: Text(openingHours)),
                if (restaurant.isOpen != null)
                  Text(
                    restaurant.isOpen! ? 'Đang mở cửa' : 'Đã đóng cửa',
                    style: TextStyle(
                      color: restaurant.isOpen! ? Colors.green : scheme.outline,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
