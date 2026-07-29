import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/shared/restaurant_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../../restaurants/presentation/providers/providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load featured restaurants when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(restaurantsProvider.notifier).loadFeaturedRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsState = ref.watch(restaurantsProvider);

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          // Glass App Bar
          SliverToBoxAdapter(child: _buildHeader(context)),

          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 16.w),
              child: AmberSearchBar(
                placeholder: 'Bạn muốn ăn gì hôm nay?',
                showButton: false,
                onTap: () => context.push(AppRoutes.search),
              ),
            ),
          ),

          // Featured restaurants section header
          SliverToBoxAdapter(
            child: _buildSectionHeader(
              title: 'Nhà hàng nổi bật',
              onSeeAll: () => context.pushToRestaurants(),
            ),
          ),

          // Featured restaurants list
          _buildRestaurantsList(restaurantsState),

          // Bottom padding for nav bar
          SliverToBoxAdapter(child: SizedBox(height: 140.w)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 8.w),
      child: Row(
        children: [
          // Location
          Expanded(
            child: InkWell(
              onTap: () => context.pushAddressList(),
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: ref.colors.primary,
                        size: 20.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Giao đến',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ref.colors.textSecondary,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: ref.colors.textSecondary,
                        size: 18.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.w),
                  Text(
                    'Chọn địa chỉ giao hàng',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ref.colors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          // Notification button
          GlassActionButton(
            icon: Icons.notifications_outlined,
            onPressed: () => context.push(AppRoutes.notifications),
          ),

          SizedBox(width: 8.w),

          // Cart button
          GlassActionButton(
            icon: Icons.shopping_cart_outlined,
            onPressed: () => context.pushCart(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required String title, VoidCallback? onSeeAll}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ref.colors.textPrimary,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'Xem tất cả',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: ref.colors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRestaurantsList(RestaurantsState restaurantsState) {
    if (restaurantsState.isLoading || restaurantsState.isFeaturedLoading) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: CircularProgressIndicator(color: ref.colors.primary),
          ),
        ),
      );
    }

    if (restaurantsState.hasError) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 48.w),
                SizedBox(height: 12.w),
                Text(
                  'Lỗi: ${restaurantsState.errorMessage}',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (restaurantsState.restaurants.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Text(
              'Không có nhà hàng nào',
              style: TextStyle(
                color: ref.colors.textSecondary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final restaurant = restaurantsState.restaurants[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: RestaurantCard(
              name: restaurant.name,
              imageUrl: restaurant.image,
              rating: restaurant.rating,
              deliveryTime: restaurant.deliveryTime == null
                  ? null
                  : '${restaurant.deliveryTime} phút',
              category: restaurant.category,
              distance: restaurant.distance == null
                  ? null
                  : '${restaurant.distance!.toStringAsFixed(1)} km',
              deliveryFee: restaurant.deliveryFee == null
                  ? null
                  : restaurant.deliveryFee == 0
                  ? 'Miễn phí giao hàng'
                  : '${restaurant.deliveryFee!.toStringAsFixed(0)}đ',
              isFreeDelivery:
                  restaurant.deliveryFee != null && restaurant.deliveryFee == 0,
              onTap: () =>
                  context.pushToRestaurantDetails(restaurant.id.toString()),
            ),
          );
        }, childCount: restaurantsState.restaurants.length),
      ),
    );
  }
}

/// Model for category items
class CategoryItem {
  final IconData icon;
  final String label;
  final bool isActive;

  CategoryItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });
}
