import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/core/widgets/glass_app_bar.dart';
import 'package:delivery_app/features/home/presentation/widgets/amber_bottom_nav_bar.dart';
import 'package:delivery_app/features/home/presentation/widgets/amber_search_bar.dart';
import 'package:delivery_app/features/home/presentation/widgets/category_pill.dart';
import 'package:delivery_app/features/home/presentation/widgets/flash_sale_section.dart';
import 'package:delivery_app/features/home/presentation/widgets/restaurant_card.dart';
import 'package:delivery_app/features/livestream/presentation/widgets/livestream_home_section.dart';
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
  int _selectedNavIndex = 0;
  int _selectedCategoryIndex = 0;
  
  // Amber Hearth design tokens
  final List<CategoryItem> _categories = [
    CategoryItem(icon: Icons.restaurant_menu, label: 'Tất cả', isActive: true),
    CategoryItem(icon: Icons.local_pizza, label: 'Pizza'),
    CategoryItem(icon: Icons.rice_bowl, label: 'Cơm'),
    CategoryItem(icon: Icons.local_cafe, label: 'Cà phê'),
    CategoryItem(icon: Icons.cake, label: 'Bánh ngọt'),
    CategoryItem(icon: Icons.ramen_dining, label: 'Mì phở'),
    CategoryItem(icon: Icons.fastfood, label: 'Fast food'),
    CategoryItem(icon: Icons.local_drink, label: 'Đồ uống'),
  ];

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
    
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Glass App Bar
            SliverToBoxAdapter(
              child: _buildHeader(context),
            ),
            
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 16.w),
                child: AmberSearchBar(
                  placeholder: 'Bạn muốn ăn gì hôm nay?',
                  onSearch: (query) {
                    // TODO: Navigate to search results
                    debugPrint('Search: $query');
                  },
                ),
              ),
            ),
            
            // Categories horizontal scroll
            SliverToBoxAdapter(
              child: _buildCategoriesSection(),
            ),
            
            // Flash Sale Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: FlashSaleSection(
                  hours: 5,
                  minutes: 32,
                  seconds: 15,
                  items: [
                    FlashSaleItem(
                      name: 'Combo Burger Deluxe',
                      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
                      originalPrice: '129.000đ',
                      salePrice: '79.000đ',
                      discountBadge: '-40%',
                    ),
                    FlashSaleItem(
                      name: 'Pizza 4 Cheese',
                      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400',
                      originalPrice: '199.000đ',
                      salePrice: '99.000đ',
                      discountBadge: '-50%',
                    ),
                    FlashSaleItem(
                      name: 'Sushi Combo',
                      imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
                      originalPrice: '249.000đ',
                      salePrice: '149.000đ',
                      discountBadge: '-40%',
                    ),
                  ],
                  onShopNow: () {
                    // TODO: Navigate to flash sale page
                  },
                ),
              ),
            ),
            
            // Featured livestreams section
            const SliverToBoxAdapter(
              child: LivestreamHomeSection(),
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
            SliverToBoxAdapter(
              child: SizedBox(height: 100.w),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AmberBottomNavBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() => _selectedNavIndex = index);
          _handleNavigation(index, context);
        },
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: context.colors.primary,
                      size: 20.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Giao đến',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: context.colors.textSecondary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: context.colors.textSecondary,
                      size: 18.w,
                    ),
                  ],
                ),
                SizedBox(height: 2.w),
                Text(
                  '123 Nguyễn Văn Linh, Q.7',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Notification button
          GlassActionButton(
            icon: Icons.notifications_outlined,
            onPressed: () {
              // TODO: Open notifications
            },
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

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 12.w),
          child: Text(
            'Danh mục',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: context.colors.textPrimary,
            ),
          ),
        ),
        SizedBox(
          height: 100.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = index == _selectedCategoryIndex;
              
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: CategoryPill(
                  icon: category.icon,
                  label: category.label,
                  isActive: isSelected,
                  onTap: () {
                    setState(() => _selectedCategoryIndex = index);
                    // TODO: Filter restaurants by category
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    VoidCallback? onSeeAll,
  }) {
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
              color: context.colors.textPrimary,
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
                  color: context.colors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRestaurantsList(dynamic restaurantsState) {
    if (restaurantsState.isLoading) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(
              color: context.colors.primary,
            ),
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
                color: context.colors.textSecondary,
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
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final restaurant = restaurantsState.restaurants[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 16.w),
              child: RestaurantCard(
                name: restaurant.name ?? 'Nhà hàng',
                imageUrl: restaurant.imageUrl ?? 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
                rating: restaurant.rating ?? 4.5,
                deliveryTime: '${restaurant.deliveryTime ?? 25}-${(restaurant.deliveryTime ?? 25) + 10} min',
                category: restaurant.category ?? 'Đa dạng',
                priceLevel: '\$\$',
                distance: '${(restaurant.distance ?? 1.5).toStringAsFixed(1)} km',
                deliveryFee: restaurant.deliveryFee == 0 ? 'Miễn phí giao hàng' : '${restaurant.deliveryFee?.toStringAsFixed(0) ?? "15"}k',
                isFreeDelivery: restaurant.deliveryFee == 0,
                onTap: () => context.pushToRestaurantDetails(restaurant.id.toString()),
              ),
            );
          },
          childCount: restaurantsState.restaurants.length,
        ),
      ),
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        context.pushToRestaurants();
        break;
      case 2:
        context.pushCart();
        break;
      case 3:
        context.pushProfile();
        break;
    }
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
