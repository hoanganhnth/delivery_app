import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/catalog/di/catalog_search_providers.dart';
import 'package:delivery_app/features/catalog/domain/catalog_search_repository.dart';

import 'catalog_search_effect.dart';
import 'catalog_search_intent.dart';
import 'catalog_search_state.dart';

final catalogSearchViewModelProvider =
    NotifierProvider<CatalogSearchViewModel, CatalogSearchViewState>(
      CatalogSearchViewModel.new,
    );

class CatalogSearchViewModel extends Notifier<CatalogSearchViewState> {
  int _nextEffectId = 0;
  int _requestEpoch = 0;

  @override
  CatalogSearchViewState build() => const CatalogSearchViewState();

  Future<void> dispatch(CatalogSearchIntent intent) async {
    switch (intent) {
      case CatalogSearchQueryChanged(:final value):
        await _changeQuery(value);
      case CatalogSearchCleared():
        _requestEpoch += 1;
        state = state.copyWith(
          clearQuery: true,
          dishes: const [],
          restaurants: const [],
          isSearching: false,
          hasDishError: false,
          hasRestaurantError: false,
        );
      case CatalogSearchTabSelected(:final tab):
        state = state.copyWith(tab: tab);
      case CatalogSearchDishSelected(:final restaurantId):
        if (restaurantId.trim().isNotEmpty) {
          _emit(CatalogSearchNavigateToRestaurant(restaurantId.trim()));
        }
      case CatalogSearchRestaurantSelected(:final restaurantId):
        if (restaurantId.trim().isNotEmpty) {
          _emit(CatalogSearchNavigateToRestaurant(restaurantId.trim()));
        }
      case CatalogSearchEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _changeQuery(String query) async {
    final requestEpoch = ++_requestEpoch;
    state = state.copyWith(
      query: query,
      dishes: const [],
      restaurants: const [],
      isSearching: query.isNotEmpty,
      hasDishError: false,
      hasRestaurantError: false,
    );
    if (query.isEmpty) return;

    await ref.read(catalogSearchDelayProvider).wait();
    if (!ref.mounted || requestEpoch != _requestEpoch) return;

    final repository = ref.read(catalogSearchRepositoryProvider);
    final dishesFuture = _captureDishes(repository, query);
    final restaurantsFuture = _captureRestaurants(repository, query);
    final dishes = await dishesFuture;
    final restaurants = await restaurantsFuture;
    if (!ref.mounted || requestEpoch != _requestEpoch) return;

    state = state.copyWith(
      dishes: dishes.data.map(_dishViewData).toList(growable: false),
      restaurants: restaurants.data
          .map(_restaurantViewData)
          .toList(growable: false),
      isSearching: false,
      hasDishError: dishes.hasError,
      hasRestaurantError: restaurants.hasError,
    );
  }

  Future<_SearchOutcome<List<CatalogDishSearchResult>>> _captureDishes(
    CatalogSearchRepository repository,
    String query,
  ) async {
    try {
      return _SearchOutcome.data(await repository.searchDishes(query));
    } catch (_) {
      return const _SearchOutcome.error();
    }
  }

  Future<_SearchOutcome<List<CatalogRestaurantSearchResult>>>
  _captureRestaurants(CatalogSearchRepository repository, String query) async {
    try {
      return _SearchOutcome.data(await repository.searchRestaurants(query));
    } catch (_) {
      return const _SearchOutcome.error();
    }
  }

  CatalogDishSearchViewData _dishViewData(CatalogDishSearchResult result) {
    return CatalogDishSearchViewData(
      id: result.id,
      name: result.name,
      description: result.description,
      price: result.price,
      restaurantId: result.restaurantId,
      imageUrl: result.imageUrl,
    );
  }

  CatalogRestaurantSearchViewData _restaurantViewData(
    CatalogRestaurantSearchResult result,
  ) {
    return CatalogRestaurantSearchViewData(
      id: result.id,
      name: result.name,
      cuisine: result.cuisine,
      rating: result.rating,
      imageUrl: result.imageUrl,
    );
  }

  void _emit(CatalogSearchEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}

final class _SearchOutcome<T> {
  const _SearchOutcome.data(this.data) : hasError = false;
  const _SearchOutcome.error() : data = const <Never>[] as T, hasError = true;

  final T data;
  final bool hasError;
}
