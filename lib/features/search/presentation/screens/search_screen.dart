import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/search/presentation/providers/search_providers.dart';
import 'package:delivery_app/features/search/presentation/widgets/dish_search_results.dart';
import 'package:delivery_app/features/search/presentation/widgets/restaurant_search_results.dart';
import 'package:delivery_app/features/search/presentation/widgets/shipper_search_results.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(searchFilterTabProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search dishes, restaurants...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).setQuery(value);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              ref.read(searchQueryProvider.notifier).setQuery('');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTab(context, ref, 'Dishes', 0, tabIndex),
              _buildTab(context, ref, 'Restaurants', 1, tabIndex),
              _buildTab(context, ref, 'Shippers', 2, tabIndex),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: tabIndex,
        children: const [
          DishSearchResults(),
          RestaurantSearchResults(),
          ShipperSearchResults(),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, WidgetRef ref, String title, int index, int currentIndex) {
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => ref.read(searchFilterTabProvider.notifier).setTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
