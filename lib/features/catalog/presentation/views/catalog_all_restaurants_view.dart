import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_home_components.dart';
import 'package:flutter/material.dart';

/// Pure restaurant-index rendering using canonical design system primitives.
class CatalogAllRestaurantsView extends StatelessWidget {
  const CatalogAllRestaurantsView({
    super.key,
    required this.state,
    required this.onIntent,
    this.previewMode = false,
    this.bottomNavigationBar,
    this.onBack,
    this.onCart,
  });

  final CatalogAllRestaurantsViewState state;
  final ValueChanged<CatalogAllRestaurantsIntent> onIntent;
  final bool previewMode;
  final Widget? bottomNavigationBar;
  final VoidCallback? onBack;
  final VoidCallback? onCart;

  @override
  Widget build(BuildContext context) {
    final body = switch ((state.isLoading, state.hasError, state.isEmpty)) {
      (true, _, _) => const AppStateFeedback.loading(
        title: 'Đang tải danh sách nhà hàng',
      ),
      (_, true, _) => AppStateFeedback.error(
        title: 'Không thể tải danh sách nhà hàng',
        message: 'Vui lòng thử lại sau.',
        actionLabel: 'Thử lại',
        onAction: () => onIntent(const CatalogAllRestaurantsRetryRequested()),
      ),
      (_, _, true) => const AppStateFeedback.empty(
        title: 'Chưa có nhà hàng nào',
        message: 'Các nhà hàng mới sẽ xuất hiện ở đây sớm.',
        icon: Icons.storefront_outlined,
      ),
      _ => RefreshIndicator(
        onRefresh: () async =>
            onIntent(const CatalogAllRestaurantsRefreshRequested()),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: state.restaurants.length,
          separatorBuilder: (_, _) => const SizedBox.shrink(),
          itemBuilder: (context, index) {
            final restaurant = state.restaurants[index];
            return CatalogRestaurantCard(
              restaurant: restaurant,
              onTap: () => onIntent(
                CatalogAllRestaurantsRestaurantRequested(restaurant.id),
              ),
            );
          },
        ),
      ),
    };

    if (previewMode) {
      return Scaffold(
        backgroundColor: PreviewUi.canvas(context),
        appBar: PreviewPageHeader(
          title: 'Tất cả nhà hàng',
          onBack:
              onBack ??
              () => onIntent(const CatalogAllRestaurantsBackRequested()),
          onCart: onCart,
          actions: [
            IconButton(
              tooltip: 'Tìm kiếm',
              onPressed: () =>
                  onIntent(const CatalogAllRestaurantsSearchRequested()),
              icon: const Icon(Icons.search, size: 21),
            ),
          ],
        ),
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppTopBar(
        title: 'Tất cả nhà hàng',
        onBack: () => onIntent(const CatalogAllRestaurantsBackRequested()),
        backTooltip: 'Quay lại',
        actions: [
          AppIconButton(
            tooltip: 'Tìm kiếm',
            icon: Icons.search,
            onPressed: () =>
                onIntent(const CatalogAllRestaurantsSearchRequested()),
          ),
        ],
      ),
      body: body,
    );
  }
}
