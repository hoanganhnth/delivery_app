import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/menu_item_card.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/restaurant_hero_section.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/restaurant_info_section.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/restaurant_menu_header.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/restaurant_cart_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../providers/providers.dart';
import '../../../cart/presentation/providers/providers.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final num restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  
  // Amber Hearth design tokens  
  @override
  void initState() {
    super.initState();
    // Load restaurant detail when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(restaurantDetailProvider.notifier)
          .loadRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(restaurantDetailProvider);
    final restaurant = detailState.restaurant;
    final menuItems = detailState.menuItems;
    final cartItemsCount = ref.watch(cartItemsCountProvider);
    final cartTotalAmount = ref.watch(cartTotalAmountProvider);
    final isCartEmpty = ref.watch(isCartEmptyProvider);

    if (detailState.isLoading) {
      return Scaffold(
        backgroundColor: ref.colors.background,
        body: Center(
          child: CircularProgressIndicator(color: ref.colors.primary),
        ),
      );
    }

    if (detailState.hasError) {
      return Scaffold(
        backgroundColor: ref.colors.background,
        appBar: _buildErrorAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 64.w),
              SizedBox(height: 16.w),
              Text(
                'Lỗi: ${detailState.errorMessage}',
                style: TextStyle(color: Colors.red, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (restaurant == null) {
      return Scaffold(
        backgroundColor: ref.colors.background,
        appBar: _buildErrorAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant, color: Colors.grey, size: 64.w),
              SizedBox(height: 16.w),
              Text(
                'Không tìm thấy nhà hàng',
                style: TextStyle(
                  color: ref.colors.textSecondary,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ref.colors.background,
      body: CustomScrollView(
        slivers: [
          // Hero image with glass overlay
          RestaurantHeroSection(restaurant: restaurant),
          
          // Restaurant info section
          RestaurantInfoSection(restaurant: restaurant),

          // Menu section header
          const RestaurantMenuHeader(),

          // Menu items list
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final menuItem = menuItems[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.w),
                    child: MenuItemCard(
                      menuItem: menuItem,
                      restaurantName: restaurant.name,
                    ),
                  );
                },
                childCount: menuItems.length,
              ),
            ),
          ),

          // Bottom padding for cart button
          SliverToBoxAdapter(child: SizedBox(height: 100.w)),
        ],
      ),

      // Floating cart button
      bottomNavigationBar: RestaurantCartButton(
        isCartEmpty: isCartEmpty,
        cartItemsCount: cartItemsCount,
        cartTotalAmount: cartTotalAmount,
      ),
    );
  }

  PreferredSizeWidget _buildErrorAppBar() {
    return GlassAppBar(
      titleText: 'Chi tiết nhà hàng',
      leading: GlassBackButton(onPressed: () => context.pop()),
    );
  }
}
