import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/feature_restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/restaurant_providers.dart';

class RestaurantHomePage extends ConsumerWidget {
  const RestaurantHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsState = ref.watch(restaurantsNotifierProvider);

    return Column(
      children: [
        if (restaurantsState.restaurants.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nhà hàng nổi bật',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        SizedBox(
          height: 200,
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
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: restaurantsState.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurantsState.restaurants[index];
                    return Container(
                      width: 160,
                      margin: EdgeInsets.only(
                        right: index < restaurantsState.restaurants.length - 1
                            ? 12
                            : 0,
                      ),
                      child: GestureDetector(
                        onTap: () => context.pushToRestaurantDetails(
                          restaurant.id.toString(),
                        ),
                        child: FeaturedRestaurantCard(restaurant: restaurant),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
