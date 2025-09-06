import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/presentation/screens/home_screen.dart';
import 'package:flutter/widgets.dart';

class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({super.key, required this.featuredRestaurants});

  final List<RestaurantEntity> featuredRestaurants;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: featuredRestaurants.length,
        itemBuilder: (context, index) {
          final restaurant = featuredRestaurants[index];
          return Container(
            width: 160,
            margin: EdgeInsets.only(
              right: index < featuredRestaurants.length - 1 ? 12 : 0,
            ),
            child: GestureDetector(
              onTap: () => context.pushToRestaurantDetails(restaurant.id),
              child: FeaturedRestaurantCard(restaurant: restaurant),
            ),
          );
        },
      ),
    );
  }
}
