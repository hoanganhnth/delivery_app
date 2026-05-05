import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/search/presentation/providers/search_providers.dart';

class DishSearchResults extends ConsumerWidget {
  const DishSearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchAsync = ref.watch(searchDishesResultsProvider);
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      return const Center(child: Text('Type to search dishes...'));
    }

    return searchAsync.when(
      data: (dishes) {
        if (dishes.isEmpty) {
          return const Center(child: Text('No dishes found.'));
        }
        return ListView.builder(
          itemCount: dishes.length,
          itemBuilder: (context, index) {
            final dish = dishes[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: dish.imageUrl != null ? NetworkImage(dish.imageUrl!) : null,
                child: dish.imageUrl == null ? const Icon(Icons.fastfood) : null,
              ),
              title: Text(dish.name),
              subtitle: Text(dish.description ?? ''),
              trailing: Text('\$${dish.price ?? 0.0}'),
              onTap: () {
                // Navigate to dish details
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
