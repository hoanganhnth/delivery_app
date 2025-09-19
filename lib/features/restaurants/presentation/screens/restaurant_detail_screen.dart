import 'package:delivery_app/core/widgets/app_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/menu_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/restaurant_providers.dart';
import '../../../cart/presentation/providers/cart_providers.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final num restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load restaurant detail when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(restaurantDetailNotifierProvider.notifier)
          .loadRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(restaurantDetailNotifierProvider);
    final restaurant = detailState.restaurant;
    final menuItems = detailState.menuItems;
    final cartItemsCount = ref.watch(cartItemsCountProvider);
    final cartTotalAmount = ref.watch(cartTotalAmountProvider);
    final isCartEmpty = ref.watch(isCartEmptyProvider);

    if (detailState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (detailState.hasError) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            'Lỗi: ${detailState.errorMessage}',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (restaurant == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: const Center(child: Text('Không tìm thấy nhà hàng')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with restaurant image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.orange,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.share, color: Colors.white),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  restaurant.image != null
                      ? AppImage(
                          path: restaurant.image!,
                          fit: BoxFit.cover,
                          errorWidget: Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.restaurant,
                              size: 80,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.restaurant,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),

                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),

                  // Restaurant info overlay
                  Positioned(
                    bottom: 16.w,
                    left: 16.w,
                    right: 16.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (restaurant.description != null) ...[
                          SizedBox(height: 4.w),
                          Text(
                            restaurant.description!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                        SizedBox(height: 8.w),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.orange[300],
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '4.5 (200+ đánh giá)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '20-30 phút • Miễn phí ship',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Restaurant details
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Restaurant info card
                  Container(
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                restaurant.address,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.w),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Mở cửa: 8:00 - 22:00',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.w,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Đang mở cửa',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Promo banner
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: Colors.orange[700],
                          size: 20,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Giảm 30% cho đơn hàng đầu tiên - Tối đa 50K',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.w),

                  // Menu section header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Text(
                          'Thực đơn',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu items list
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final menuItem = menuItems[index];
              return MenuItemCard(
                menuItem: menuItem,
                restaurantName: restaurant.name,
              );
            }, childCount: menuItems.length),
          ),

          // Bottom padding for cart button
          SliverToBoxAdapter(child: SizedBox(height: 100.w)),
        ],
      ),

      // Floating cart button
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom > 0
              ? MediaQuery.of(context).padding.bottom
              : 16,
          left: 16.w,
          right: 16.w,
          top: 8.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isCartEmpty ? null : () {
            // Navigate to cart screen
            context.push('/cart');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isCartEmpty ? Colors.grey : Colors.orange,
            padding: EdgeInsets.symmetric(vertical: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isCartEmpty
              ? Text(
                  'Chưa có món nào trong giỏ hàng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  'Xem giỏ hàng ($cartItemsCount) • ${cartTotalAmount.toStringAsFixed(0)}đ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
