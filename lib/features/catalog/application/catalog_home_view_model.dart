import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/application/list/restaurants_notifier.dart';
import 'package:delivery_app/features/restaurants/application/list/restaurants_state.dart';

import 'catalog_home_effect.dart';
import 'catalog_home_intent.dart';
import 'catalog_home_state.dart';

final catalogHomeViewModelProvider =
    NotifierProvider<CatalogHomeViewModel, CatalogHomeViewState>(
      CatalogHomeViewModel.new,
    );

/// Transitional ViewModel for the catalog landing page.
///
/// It maps the legacy restaurant notifier into catalog presentation data. The
/// next catalog slice will replace this notifier seam with a catalog-owned
/// repository port without changing the view or its intent contract.
class CatalogHomeViewModel extends Notifier<CatalogHomeViewState> {
  int _nextEffectId = 0;

  @override
  CatalogHomeViewState build() {
    final restaurants = ref.read(restaurantsProvider);
    ref.listen<RestaurantsState>(restaurantsProvider, (_, next) {
      if (!ref.mounted) return;
      state = _fromRestaurants(next, effects: state.effects);
    });
    return _fromRestaurants(restaurants);
  }

  Future<void> dispatch(CatalogHomeIntent intent) async {
    switch (intent) {
      case CatalogHomeLoadRequested():
        await ref.read(restaurantsProvider.notifier).loadFeaturedRestaurants();
      case CatalogHomeSearchRequested():
        _emit(const CatalogHomeNavigateToSearch());
      case CatalogHomeAllRestaurantsRequested():
        _emit(const CatalogHomeNavigateToAllRestaurants());
      case CatalogHomeAddressRequested():
        _emit(const CatalogHomeNavigateToAddresses());
      case CatalogHomeNotificationsRequested():
        _emit(const CatalogHomeNavigateToNotifications());
      case CatalogHomeCartRequested():
        _emit(const CatalogHomeNavigateToCart());
      case CatalogHomeRestaurantRequested(:final restaurantId):
        _emit(CatalogHomeNavigateToRestaurant(restaurantId));
      case CatalogHomeEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  CatalogHomeViewState _fromRestaurants(
    RestaurantsState restaurants, {
    List<UiEffectEnvelope<CatalogHomeEffect>> effects = const [],
  }) {
    return CatalogHomeViewState(
      restaurants: restaurants.restaurants
          .map(_toViewData)
          .toList(growable: false),
      isLoading: restaurants.isLoading || restaurants.isFeaturedLoading,
      errorMessage: restaurants.errorMessage,
      effects: effects,
    );
  }

  CatalogRestaurantViewData _toViewData(RestaurantEntity restaurant) {
    return CatalogRestaurantViewData(
      id: restaurant.id,
      name: restaurant.name,
      imageUrl: restaurant.image,
      description: restaurant.description,
      address: restaurant.address,
      rating: restaurant.rating,
      reviewCount: restaurant.reviewCount,
      deliveryTimeMinutes: restaurant.deliveryTime,
      category: restaurant.category,
      distanceKm: restaurant.distance,
      deliveryFee: restaurant.deliveryFee,
    );
  }

  void _emit(CatalogHomeEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
