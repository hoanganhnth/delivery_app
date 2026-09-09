import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_home_components.dart';
import 'package:delivery_app/core/design_system/components/preview_page_shell.dart';
import 'package:flutter/material.dart';
import '../components/home/home_style.dart';
import '../components/home/home_restaurants_section.dart';
import '../components/home/home_banner_carousel.dart';
import '../components/home/home_suggested_dishes.dart';
import '../components/home/home_offer_strip.dart';
import '../../application/home_suggested_dish.dart';

/// Pure rendering for the catalog landing tab. Navigation and restaurant I/O
/// are represented exclusively by [CatalogHomeIntent]s.
class CatalogHomeView extends StatefulWidget {
  const CatalogHomeView({
    super.key,
    required this.state,
    required this.onIntent,
    this.flashSaleBanner,
    this.livestreamBanner,
    this.deliveryAddress,
    this.suggestedDishes = const [],
  });

  final CatalogHomeViewState state;
  final ValueChanged<CatalogHomeIntent> onIntent;
  final Widget? flashSaleBanner;
  final Widget? livestreamBanner;
  final String? deliveryAddress;
  final List<HomeSuggestedDish> suggestedDishes;

  @override
  State<CatalogHomeView> createState() => _CatalogHomeViewState();
}

class _CatalogHomeViewState extends State<CatalogHomeView> {
  String _category = 'Tất cả';
  final _restaurantsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PreviewTypography(
      child: Scaffold(
        backgroundColor: HomeStyle.canvas(context),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CatalogHomeHeader(
                  onIntent: widget.onIntent,
                  deliveryAddress:
                      widget.deliveryAddress ?? widget.state.deliveryAddress,
                ),
              ),
              SliverToBoxAdapter(
                child: CatalogHomeSearchLauncher(onIntent: widget.onIntent),
              ),
              const SliverToBoxAdapter(child: HomeBannerCarousel()),
              SliverToBoxAdapter(
                child: HomeServiceGrid(
                  onCategorySelected: (value) {
                    setState(() => _category = value);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final context = _restaurantsKey.currentContext;
                      if (mounted && context != null) {
                        Scrollable.ensureVisible(context);
                      }
                    });
                  },
                ),
              ),
              const SliverToBoxAdapter(child: HomeOfferStrip()),
              const SliverToBoxAdapter(
                child: SizedBox(height: HomeStyle.sectionGap),
              ),
              SliverToBoxAdapter(
                child: HomeSuggestedDishes(
                  dishes: widget.suggestedDishes,
                  onRestaurantSelected: (id) =>
                      widget.onIntent(CatalogHomeRestaurantRequested(id)),
                  onSeeAll: () => widget.onIntent(
                    const CatalogHomeAllRestaurantsRequested(),
                  ),
                ),
              ),
              if (widget.flashSaleBanner != null)
                SliverToBoxAdapter(child: widget.flashSaleBanner),
              const SliverToBoxAdapter(
                child: SizedBox(height: HomeStyle.sectionGap),
              ),
              SliverToBoxAdapter(
                child: HomeRestaurantsSection(
                  key: _restaurantsKey,
                  state: widget.state,
                  category: _category,
                  onClearCategory: () => setState(() => _category = 'Tất cả'),
                  onIntent: widget.onIntent,
                ),
              ),
              if (widget.livestreamBanner != null)
                SliverToBoxAdapter(child: widget.livestreamBanner),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
