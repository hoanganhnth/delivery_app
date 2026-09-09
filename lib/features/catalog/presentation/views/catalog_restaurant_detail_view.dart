import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_restaurant_detail_parts.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_restaurant_detail_preview_components.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Pure detail rendering; all I/O, cart writes, confirmation and navigation
/// are represented by [CatalogRestaurantDetailIntent]s.
class CatalogRestaurantDetailView extends StatelessWidget {
  const CatalogRestaurantDetailView({
    super.key,
    required this.state,
    required this.onIntent,
    this.onItemOpen,
    this.previewMode = false,
    this.deliveryAddressLabel,
    this.onManageAddress,
    this.onOpenVoucher,
  });

  final CatalogRestaurantDetailViewState state;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;
  final ValueChanged<CatalogMenuItemViewData>? onItemOpen;
  final bool previewMode;
  final String? deliveryAddressLabel;
  final VoidCallback? onManageAddress;
  final VoidCallback? onOpenVoucher;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    if (state.isLoading) {
      return Scaffold(body: AppStateFeedback.loading(title: strings.loading));
    }
    if (state.hasError) {
      return _TerminalScaffold(
        title: strings.pilotRestaurantDetailsTitle,
        onBack: _back,
        child: AppStateFeedback.error(
          title: strings.error,
          message: state.errorMessage,
        ),
      );
    }
    final restaurant = state.restaurant;
    if (restaurant == null) {
      return _TerminalScaffold(
        title: strings.pilotRestaurantDetailsTitle,
        onBack: _back,
        child: AppStateFeedback.empty(title: strings.pilotRestaurantNotFound),
      );
    }

    if (previewMode) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: CatalogRestaurantPreviewHeader(
          title: restaurant.name,
          cartItemCount: state.cartItemsCount,
          onBack: _back,
          onCart: () => onIntent(const CatalogRestaurantDetailCartRequested()),
        ),
        body: CatalogRestaurantPreviewBody(
          restaurant: restaurant,
          menuItems: state.menuItems,
          cartItemCount: state.cartItemsCount,
          cartTotalAmount: state.cartTotalAmount,
          deliveryAddressLabel: deliveryAddressLabel,
          onManageAddress: onManageAddress,
          onOpenVoucher: onOpenVoucher,
          onIntent: onIntent,
          onItemOpen: (item) {
            if (onItemOpen != null) onItemOpen!(item);
          },
        ),
        bottomNavigationBar:
            state.isCartEmpty
                ? null
                : CatalogRestaurantPreviewCartButton(
                  itemCount: state.cartItemsCount,
                  totalAmount: state.cartTotalAmount,
                  onPressed:
                      () => onIntent(
                        const CatalogRestaurantDetailCartRequested(),
                      ),
                ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppTopBar(title: restaurant.name, onBack: _back),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 180,
              child: CatalogRestaurantHero(restaurant: restaurant),
            ),
          ),
          SliverToBoxAdapter(
            child: CatalogRestaurantInfo(restaurant: restaurant),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              0,
              AppSpacing.page,
              AppSpacing.xs,
            ),
            sliver: SliverToBoxAdapter(
              child: AppSectionHeading(title: strings.pilotRestaurantMenu),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => CatalogMenuItemCard(
                item: state.menuItems[index],
                onIntent: onIntent,
                onOpen:
                    onItemOpen == null
                        ? null
                        : () => onItemOpen!(state.menuItems[index]),
              ),
              childCount: state.menuItems.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
        ],
      ),
      bottomNavigationBar: CatalogRestaurantCartButton(
        itemCount: state.cartItemsCount,
        totalAmount: state.cartTotalAmount,
        onPressed: () => onIntent(const CatalogRestaurantDetailCartRequested()),
      ),
    );
  }

  void _back() => onIntent(const CatalogRestaurantDetailBackRequested());
}

class _TerminalScaffold extends StatelessWidget {
  const _TerminalScaffold({
    required this.title,
    required this.onBack,
    required this.child,
  });

  final String title;
  final VoidCallback onBack;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppTopBar(title: title, onBack: onBack), body: child);
}
