import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/restaurant_home_page.dart';
import 'package:flutter/material.dart';
import '../../../restaurants/presentation/mock/mock_restaurant_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final featuredRestaurants = MockRestaurantService.getMockRestaurants().take(3).toList();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'DeliverFood',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[600]),
                  const SizedBox(width: 12),
                  Text(
                    'Tìm món ăn, quán ăn...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 160,
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
                  const Positioned(
                    left: 20,
                    top: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giao hàng miễn phí',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Cho đơn hàng đầu tiên',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Sử dụng mã: FREESHIP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Featured restaurants section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nhà hàng nổi bật',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pushToRestaurants(),
                    child: const Text(
                      'Xem tất cả',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Featured restaurants horizontal list
            RestaurantHomePage(featuredRestaurants: featuredRestaurants),
            
            const SizedBox(height: 24),
            
            // Categories section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Danh mục',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Categories grid
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
            
            const SizedBox(height: 20),
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}


