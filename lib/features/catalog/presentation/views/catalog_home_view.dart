import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_home_components.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Pure rendering for the catalog landing tab. Navigation and restaurant I/O
/// are represented exclusively by [CatalogHomeIntent]s.
class CatalogHomeView extends StatelessWidget {
  const CatalogHomeView({
    super.key,
    required this.state,
    required this.onIntent,
    this.flashSaleBanner,
  });

  final CatalogHomeViewState state;
  final ValueChanged<CatalogHomeIntent> onIntent;
  final Widget? flashSaleBanner;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CatalogHomeHeader(onIntent: onIntent),
            ),
            SliverToBoxAdapter(
              child: CatalogHomeSearchLauncher(onIntent: onIntent),
            ),
            if (flashSaleBanner != null)
              SliverToBoxAdapter(child: flashSaleBanner),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.page,
                AppSpacing.md,
                AppSpacing.page,
                AppSpacing.sm,
              ),
              sliver: SliverToBoxAdapter(
                child: AppSectionHeading(
                  title: strings.pilotHomeFeatured,
                  actionLabel: strings.pilotHomeSeeAll,
                  onAction: () =>
                      onIntent(const CatalogHomeAllRestaurantsRequested()),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
              sliver: SliverToBoxAdapter(
                child: CatalogRestaurantList(state: state, onIntent: onIntent),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}
