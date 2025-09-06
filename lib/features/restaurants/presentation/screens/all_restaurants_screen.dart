import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/restaurant_entity.dart';
import '../providers/restaurant_providers.dart';

class AllRestaurantsScreen extends ConsumerStatefulWidget {
  const AllRestaurantsScreen({super.key});

  @override
  ConsumerState<AllRestaurantsScreen> createState() => _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends ConsumerState<AllRestaurantsScreen> {
  @override
  void initState() {
    super.initState();
    // Load all restaurants when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(restaurantsNotifierProvider.notifier).loadRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsState = ref.watch(restaurantsNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Tất cả nhà hàng',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('Tất cả', true),
                const SizedBox(width: 8),
                _buildFilterChip('Giao nhanh', false),
                const SizedBox(width: 8),
                _buildFilterChip('Khuyến mãi', false),
                const SizedBox(width: 8),
                _buildFilterChip('Đánh giá cao', false),
                const SizedBox(width: 8),
                _buildFilterChip('Gần tôi', false),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Restaurants list
          Expanded(
            child: restaurantsState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : restaurantsState.hasError
                ? Center(
                    child: Text(
                      'Lỗi: ${restaurantsState.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: restaurantsState.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurantsState.restaurants[index];
                      return GestureDetector(
                        onTap: () => context.go('/restaurants/${restaurant.id}'),
                        child: RestaurantListCard(restaurant: restaurant),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {},
      selectedColor: Colors.orange.withValues(alpha: 0.2),
      backgroundColor: Colors.grey[100],
      labelStyle: TextStyle(
        color: isSelected ? Colors.orange : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.orange : Colors.grey[300]!,
        ),
      ),
    );
  }
}

class RestaurantListCard extends StatelessWidget {
  final RestaurantEntity restaurant;
  
  const RestaurantListCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant image
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: restaurant.image != null 
                ? DecorationImage(
                    image: NetworkImage(restaurant.image!),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {},
                  )
                : null,
              color: restaurant.image == null ? Colors.grey[300] : null,
            ),
            child: Stack(
              children: [
                if (restaurant.image == null)
                  const Center(
                    child: Icon(Icons.restaurant, size: 60, color: Colors.grey),
                  ),
                
                // Discount badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'GIẢM 30%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      iconSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Restaurant info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                if (restaurant.description != null)
                  Text(
                    restaurant.description!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        restaurant.address,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.orange[700]),
                    const SizedBox(width: 2),
                    const Text(
                      '4.5',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '(200+)',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 2),
                    const Text(
                      '20-30 phút',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.delivery_dining, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 2),
                    const Text(
                      'Miễn phí',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
