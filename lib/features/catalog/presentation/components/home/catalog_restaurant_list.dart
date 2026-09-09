import 'package:delivery_app/features/restaurants/presentation/widgets/shared/restaurant_card.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CatalogRestaurantList extends StatelessWidget {
  const CatalogRestaurantList({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CatalogHomeViewState state;
  final ValueChanged<CatalogHomeIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    if (state.isLoading) {
      return AppStateFeedback.loading(title: strings.loading);
    }
    if (state.hasError) {
      return AppStateFeedback.error(
        title: strings.error,
        message: state.errorMessage,
        actionLabel: strings.retry,
        onAction: () => onIntent(const CatalogHomeLoadRequested()),
      );
    }
    if (state.restaurants.isEmpty) {
      return AppStateFeedback.empty(
        title: strings.pilotHomeNoRestaurants,
        message: strings.pilotHomeNoRestaurantsMessage,
      );
    }
    return Column(
      children: [
        for (final restaurant in state.restaurants)
          Padding(
            padding: EdgeInsets.zero,
            child: CatalogRestaurantCard(
              restaurant: restaurant,
              onTap: () =>
                  onIntent(CatalogHomeRestaurantRequested(restaurant.id)),
            ),
          ),
      ],
    );
  }
}

class CatalogRestaurantCard extends StatelessWidget {
  const CatalogRestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  final CatalogRestaurantViewData restaurant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => RestaurantCard(
    name: restaurant.name,
    imageUrl: restaurant.imageUrl,
    // Temporary display defaults approved for Home preview parity. Do not put
    // these values into entities, API payloads, sorting or checkout calculations.
    rating: restaurant.rating ?? 4.8,
    badgeLabel: Localizations.localeOf(context).languageCode == 'vi'
        ? 'Yêu thích'
        : 'Preferred',
    category: restaurant.category,
    deliveryTime: restaurant.deliveryTimeMinutes == null
        ? '20–30 ${S.of(context).min}'
        : '${restaurant.deliveryTimeMinutes} ${S.of(context).min}',
    distance: restaurant.distanceKm == null
        ? '1.2 km'
        : '${restaurant.distanceKm!.toStringAsFixed(1)} km',
    deliveryFee: restaurant.deliveryFee == null
        ? null
        : restaurant.deliveryFee == 0
        ? S.of(context).freeDelivery
        : '${restaurant.deliveryFee!.toStringAsFixed(0)} ₫',
    isFreeDelivery: restaurant.deliveryFee == 0,
    onTap: onTap,
  );
}
