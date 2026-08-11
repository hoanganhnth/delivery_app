import 'package:flutter/material.dart';

import '../../application/catalog_search_intent.dart';
import '../../application/catalog_search_state.dart';
import '../components/catalog_search_result_tiles.dart';

/// Pure search rendering. It manages only the TextEditingController needed for
/// paint/focus; query, debouncing, API work and navigation stay outside it.
class CatalogSearchView extends StatefulWidget {
  const CatalogSearchView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CatalogSearchViewState state;
  final ValueChanged<CatalogSearchIntent> onIntent;

  @override
  State<CatalogSearchView> createState() => _CatalogSearchViewState();
}

class _CatalogSearchViewState extends State<CatalogSearchView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.state.query);
  }

  @override
  void didUpdateWidget(covariant CatalogSearchView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_controller.text == widget.state.query) return;
    _controller.value = _controller.value.copyWith(
      text: widget.state.query,
      selection: TextSelection.collapsed(offset: widget.state.query.length),
      composing: TextRange.empty,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          key: const Key('catalog_search_input'),
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search dishes, restaurants...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: scheme.outline),
          ),
          onChanged: (value) =>
              widget.onIntent(CatalogSearchQueryChanged(value)),
        ),
        actions: [
          IconButton(
            key: const Key('catalog_search_clear'),
            icon: const Icon(Icons.clear),
            onPressed: () => widget.onIntent(const CatalogSearchCleared()),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SearchTab(
                title: 'Dishes',
                tab: CatalogSearchTab.dishes,
                selected: widget.state.tab,
                onTap: widget.onIntent,
              ),
              _SearchTab(
                title: 'Restaurants',
                tab: CatalogSearchTab.restaurants,
                selected: widget.state.tab,
                onTap: widget.onIntent,
              ),
            ],
          ),
        ),
      ),
      body: _SearchResults(state: widget.state, onIntent: widget.onIntent),
    );
  }
}

class _SearchTab extends StatelessWidget {
  const _SearchTab({
    required this.title,
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final CatalogSearchTab tab;
  final CatalogSearchTab selected;
  final ValueChanged<CatalogSearchIntent> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = tab == selected;
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => onTap(CatalogSearchTabSelected(tab)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? scheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? scheme.primary : scheme.outline,
          ),
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.state, required this.onIntent});

  final CatalogSearchViewState state;
  final ValueChanged<CatalogSearchIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (state.isQueryEmpty) {
      return Center(
        child: Text(
          state.tab == CatalogSearchTab.dishes
              ? 'Nhập tên món ăn để tìm kiếm'
              : 'Nhập tên nhà hàng để tìm kiếm',
        ),
      );
    }
    if (state.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasVisibleError) {
      return Center(
        child: Text(
          state.tab == CatalogSearchTab.dishes
              ? 'Không thể tải kết quả món ăn'
              : 'Không thể tải kết quả nhà hàng',
        ),
      );
    }
    return switch (state.tab) {
      CatalogSearchTab.dishes => _DishResults(
        dishes: state.dishes,
        onIntent: onIntent,
      ),
      CatalogSearchTab.restaurants => _RestaurantResults(
        restaurants: state.restaurants,
        onIntent: onIntent,
      ),
    };
  }
}

class _DishResults extends StatelessWidget {
  const _DishResults({required this.dishes, required this.onIntent});

  final List<CatalogDishSearchViewData> dishes;
  final ValueChanged<CatalogSearchIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (dishes.isEmpty) {
      return const Center(child: Text('Không tìm thấy món ăn'));
    }
    return ListView.builder(
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];
        return CatalogDishSearchResultTile(
          item: dish,
          onTap: dish.canOpenRestaurant
              ? () => onIntent(CatalogSearchDishSelected(dish.restaurantId!))
              : null,
        );
      },
    );
  }
}

class _RestaurantResults extends StatelessWidget {
  const _RestaurantResults({required this.restaurants, required this.onIntent});

  final List<CatalogRestaurantSearchViewData> restaurants;
  final ValueChanged<CatalogSearchIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return const Center(child: Text('Không tìm thấy nhà hàng'));
    }
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return CatalogRestaurantSearchResultTile(
          item: restaurant,
          onTap: () => onIntent(CatalogSearchRestaurantSelected(restaurant.id)),
        );
      },
    );
  }
}
