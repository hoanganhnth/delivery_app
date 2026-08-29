import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
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
  bool _loading = false;

  @override
  CatalogAllRestaurantsViewState build() => const CatalogAllRestaurantsViewState();

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

  Future<void> _load() async {
    if (_loading) return;
    _loading = true;
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await ref.read(catalogBrowsePortProvider).loadRestaurants();
    if (!ref.mounted) return;
    _loading = false;
    state = state.copyWith(
      restaurants: result.restaurants.map(_toViewData).toList(growable: false),
      isLoading: false,
      errorMessage: result.errorMessage,
      clearError: result.errorMessage == null,
    );
  }

  CatalogRestaurantViewData _toViewData(CatalogRestaurantSnapshot restaurant) =>
      CatalogRestaurantViewData(
        id: restaurant.id,
        name: restaurant.name,
        imageUrl: restaurant.imageUrl,
        description: restaurant.description,
        address: restaurant.address,
        rating: restaurant.rating,
        reviewCount: restaurant.reviewCount,
        deliveryTimeMinutes: restaurant.deliveryTimeMinutes,
        category: restaurant.category,
        distanceKm: restaurant.distanceKm,
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
