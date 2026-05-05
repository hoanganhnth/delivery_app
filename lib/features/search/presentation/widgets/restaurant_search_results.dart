import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/search/presentation/providers/search_providers.dart';

class RestaurantSearchResults extends ConsumerWidget {
  const RestaurantSearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchAsync = ref.watch(searchRestaurantsResultsProvider);
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      return const Center(child: Text('Type to search restaurants...'));
    }

    return searchAsync.when(
      data: (restaurants) {
        if (restaurants.isEmpty) {
          return const Center(child: Text('No restaurants found.'));
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
                    ? DecorationImage(image: NetworkImage(restaurant.imageUrl!), fit: BoxFit.cover)
                    : null,
                  color: Colors.grey[300],
                ),
                child: restaurant.imageUrl == null ? const Icon(Icons.store) : null,
              ),
              title: Text(restaurant.name),
              subtitle: Text(restaurant.cuisine ?? 'Various cuisines'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text('${restaurant.rating ?? 0.0}'),
                ],
              ),
              onTap: () {
                // Navigate to restaurant details
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
