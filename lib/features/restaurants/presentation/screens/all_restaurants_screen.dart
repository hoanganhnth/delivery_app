import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/restaurant_list_card.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class AllRestaurantsScreen extends ConsumerStatefulWidget {
  const AllRestaurantsScreen({super.key});

  @override
  ConsumerState<AllRestaurantsScreen> createState() =>
      _AllRestaurantsScreenState();
}

class _AllRestaurantsScreenState extends ConsumerState<AllRestaurantsScreen> {
  @override
  void initState() {
    super.initState();
    // Load all restaurants when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(restaurantsProvider.notifier).loadRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsState = ref.watch(restaurantsProvider);
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          s.restaurantsAllTitle,
          style: const TextStyle(
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
            onPressed: () => context.push(AppRoutes.search),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: restaurantsState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : restaurantsState.hasError
          ? Center(
              child: Text(
                s.restaurantsError(restaurantsState.errorMessage ?? ''),
                style: const TextStyle(color: Colors.red),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: restaurantsState.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurantsState.restaurants[index];
                return GestureDetector(
                  onTap: () =>
                      context.pushToRestaurantDetails(restaurant.id.toString()),
                  child: RestaurantListCard(restaurant: restaurant),
                );
              },
            ),
    );
  }
}
