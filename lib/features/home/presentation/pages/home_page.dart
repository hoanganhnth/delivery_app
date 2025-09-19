import 'package:delivery_app/features/restaurants/presentation/widgets/restaurant_home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../generated/l10n.dart';
import '../../../restaurants/presentation/providers/restaurant_providers.dart';

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
      ref.read(restaurantsNotifierProvider.notifier).loadFeaturedRestaurants();
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          S.of(context).deliverFood,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[600]),
                  SizedBox(width: 12.w),
                  Text(
                    'Tìm món ăn, quán ăn...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
            
            // Banner
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              height: 160.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.orange.shade400, Colors.orange.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 20.w,
                    top: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giao hàng miễn phí',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          'Cho đơn hàng đầu tiên',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 12.w),
                        Text(
                          'Sử dụng mã: FREESHIP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.w),
            
            // Featured restaurants section
          
            
            // Featured restaurants horizontal list
            const RestaurantHomePage(),
            
            SizedBox(height: 24.w),
            
            // Categories section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Danh mục',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: 12.w),
            
            // Categories grid
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _buildCategoryItem(Icons.local_pizza, 'Pizza', Colors.red),
                _buildCategoryItem(Icons.rice_bowl, 'Cơm', Colors.brown),
                _buildCategoryItem(Icons.local_cafe, 'Cà phê', Colors.orange),
                _buildCategoryItem(Icons.cake, 'Bánh ngọt', Colors.pink),
                _buildCategoryItem(Icons.ramen_dining, 'Mì phở', Colors.yellow),
                _buildCategoryItem(Icons.fastfood, 'Fast food', Colors.blue),
                _buildCategoryItem(Icons.local_drink, 'Đồ uống', Colors.green),
                _buildCategoryItem(Icons.more_horiz, 'Thêm', Colors.grey),
              ],
            ),
            
            SizedBox(height: 20.w),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(height: 8.w),
        Text(
          title,
          style: TextStyle(fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}


