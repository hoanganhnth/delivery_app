import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/components/app_feedback.dart';
import 'package:delivery_app/core/design_system/foundations/app_radii.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:flutter/material.dart';

import '../../application/catalog_search_intent.dart';
import '../../application/catalog_search_state.dart';
import '../components/catalog_search_result_tiles.dart';

/// Pure search rendering using canonical design system foundations.
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: AppSpacing.page,
        title: Container(
          height: 44,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: AppRadii.control,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            children: [
              Icon(Icons.search, color: scheme.onSurfaceVariant, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: TextField(
                  key: const Key('catalog_search_input'),
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Tìm món ăn, quán ăn...',
                    border: InputBorder.none,
                    isDense: true,
                    hintStyle: TextStyle(
                      color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                  onChanged: (value) =>
                      widget.onIntent(CatalogSearchQueryChanged(value)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          AppIconButton(
            key: const Key('catalog_search_clear'),
            tooltip: 'Xóa tìm kiếm',
            icon: Icons.clear,
            onPressed: () {
              _controller.clear();
              widget.onIntent(const CatalogSearchCleared());
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _SearchTab(
                  title: 'Món ăn',
                  tab: CatalogSearchTab.dishes,
                  selected: widget.state.tab,
                  onTap: widget.onIntent,
                ),
                _SearchTab(
                  title: 'Quán ăn',
                  tab: CatalogSearchTab.restaurants,
                  selected: widget.state.tab,
                  onTap: widget.onIntent,
                ),
              ],
            ),
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

    return Semantics(
      selected: isSelected,
      button: true,
      label: title,
      child: InkWell(
        onTap: () => onTap(CatalogSearchTabSelected(tab)),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.page,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? scheme.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
            ),
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
        child: AppStateFeedback.empty(
          title: state.tab == CatalogSearchTab.dishes
              ? 'Nhập tên món ăn để tìm kiếm'
              : 'Nhập tên nhà hàng để tìm kiếm',
          message: 'Khám phá hàng ngàn món ăn ngon và nhà hàng phong phú.',
          icon: Icons.search,
        ),
      );
    }
    if (state.isSearching) {
      return const Center(
        child: AppStateFeedback.loading(title: 'Đang tìm kiếm...'),
      );
    }
    if (state.hasVisibleError) {
      return Center(
        child: AppStateFeedback.error(
          title: state.tab == CatalogSearchTab.dishes
              ? 'Không thể tải kết quả món ăn'
              : 'Không thể tải kết quả nhà hàng',
          message: 'Vui lòng kiểm tra kết nối mạng và thử lại.',
          actionLabel: 'Thử lại',
          onAction: () =>
              onIntent(CatalogSearchQueryChanged(state.query)),
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
      return const Center(
        child: AppStateFeedback.empty(
          title: 'Không tìm thấy món ăn',
          message: 'Hãy thử tìm bằng từ khóa khác hoặc kiểm tra lại chính tả.',
          icon: Icons.restaurant_menu,
        ),
      );
    }
    return ListView.separated(
      itemCount: dishes.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
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
      return const Center(
        child: AppStateFeedback.empty(
          title: 'Không tìm thấy nhà hàng',
          message: 'Hãy thử tìm với tên nhà hàng hoặc địa điểm khác.',
          icon: Icons.storefront_outlined,
        ),
      );
    }
    return ListView.separated(
      itemCount: restaurants.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
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
