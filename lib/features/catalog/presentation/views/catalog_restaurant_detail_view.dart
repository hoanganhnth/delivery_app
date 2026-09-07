import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_restaurant_detail_parts.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Pure detail rendering; all I/O, cart writes, confirmation and navigation
/// are represented by [CatalogRestaurantDetailIntent]s.
class CatalogRestaurantDetailView extends StatelessWidget {
  const CatalogRestaurantDetailView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CatalogRestaurantDetailViewState state;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;

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

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 264,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: AppIconButton(
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                icon: Icons.arrow_back,
                hasBackground: true,
                backgroundColor: Colors.white.withValues(alpha: 0.92),
                onPressed: _back,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: CatalogRestaurantHero(restaurant: restaurant),
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppTopBar(title: title, onBack: onBack),
    body: child,
  );
}
