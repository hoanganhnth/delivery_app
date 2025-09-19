import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nhà hàng nổi bật',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
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

        SizedBox(height: 12.w),
        SizedBox(
          height: 200.w,
          child: restaurantsState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : restaurantsState.hasError
              ? Center(
                  child: Text(
                    'Lỗi: ${restaurantsState.errorMessage}',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: restaurantsState.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurantsState.restaurants[index];
                    return Container(
                      width: 160.w,
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
