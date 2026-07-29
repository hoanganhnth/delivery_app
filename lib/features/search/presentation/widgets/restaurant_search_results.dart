import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/search/presentation/providers/search_providers.dart';

class RestaurantSearchResults extends ConsumerWidget {
  const RestaurantSearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchAsync = ref.watch(searchRestaurantsResultsProvider);
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      return const Center(child: Text('Nhập tên nhà hàng để tìm kiếm'));
    }

    return searchAsync.when(
      data: (restaurants) {
        if (restaurants.isEmpty) {
          return const Center(child: Text('Không tìm thấy nhà hàng'));
        }
        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: restaurant.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(restaurant.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey[300],
                ),
                child: restaurant.imageUrl == null
                    ? const Icon(Icons.store)
                    : null,
              ),
              title: Text(restaurant.name),
              subtitle: restaurant.cuisine?.trim().isNotEmpty == true
                  ? Text(restaurant.cuisine!.trim())
                  : null,
              trailing: restaurant.rating == null
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        const SizedBox(width: 4),
                        Text(restaurant.rating!.toStringAsFixed(1)),
                      ],
                    ),
              onTap: () => context.pushToRestaurantDetails(restaurant.id),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) =>
          const Center(child: Text('Không thể tải kết quả nhà hàng')),
    );
  }
}
