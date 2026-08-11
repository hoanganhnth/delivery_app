import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/application/list/restaurants_notifier.dart';
import 'package:delivery_app/features/restaurants/application/list/restaurants_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'catalog_all_restaurants_effect.dart';
import 'catalog_all_restaurants_intent.dart';
import 'catalog_all_restaurants_state.dart';
import 'catalog_home_state.dart';

final catalogAllRestaurantsViewModelProvider =
    NotifierProvider.autoDispose<
      CatalogAllRestaurantsViewModel,
      CatalogAllRestaurantsViewState
    >(CatalogAllRestaurantsViewModel.new);

/// Catalog-owned interaction layer for the customer-visible restaurant index.
class CatalogAllRestaurantsViewModel
    extends Notifier<CatalogAllRestaurantsViewState> {
  int _nextEffectId = 0;

  @override
  CatalogAllRestaurantsViewState build() {
    final restaurants = ref.read(restaurantsProvider);
    ref.listen<RestaurantsState>(restaurantsProvider, (_, next) {
      if (ref.mounted) state = _fromRestaurants(next, effects: state.effects);
    });
    return _fromRestaurants(restaurants);
  }

  Future<void> dispatch(CatalogAllRestaurantsIntent intent) async {
    switch (intent) {
      case CatalogAllRestaurantsLoadRequested():
        if (state.restaurants.isEmpty && !state.isLoading) await _load();
      case CatalogAllRestaurantsRefreshRequested() ||
          CatalogAllRestaurantsRetryRequested():
        await _load();
      case CatalogAllRestaurantsBackRequested():
        _emit(const CatalogAllRestaurantsNavigateBack());
      case CatalogAllRestaurantsSearchRequested():
        _emit(const CatalogAllRestaurantsNavigateToSearch());
      case CatalogAllRestaurantsRestaurantRequested(:final restaurantId):
        if (restaurantId > 0) {
          _emit(CatalogAllRestaurantsNavigateToDetail(restaurantId));
        }
      case CatalogAllRestaurantsEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _load() =>
      ref.read(restaurantsProvider.notifier).loadRestaurants();

  CatalogAllRestaurantsViewState _fromRestaurants(
    RestaurantsState source, {
    List<UiEffectEnvelope<CatalogAllRestaurantsEffect>> effects = const [],
  }) => CatalogAllRestaurantsViewState(
    restaurants: source.restaurants.map(_toViewData).toList(growable: false),
    isLoading: source.isLoading,
    errorMessage: source.errorMessage,
    effects: effects,
  );

  CatalogRestaurantViewData _toViewData(RestaurantEntity restaurant) =>
      CatalogRestaurantViewData(
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

  void _emit(CatalogAllRestaurantsEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
