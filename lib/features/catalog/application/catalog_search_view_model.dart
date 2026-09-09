import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/catalog/di/catalog_search_providers.dart';
import 'package:delivery_app/features/catalog/domain/catalog_search_repository.dart';

import 'catalog_search_effect.dart';
import 'catalog_search_intent.dart';
import 'catalog_search_preview_fixtures.dart';
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
      case CatalogSearchLoadRequested():
        await _loadInitialRestaurants();
      case CatalogSearchCleared():
        await _changeQuery('');
      case CatalogSearchTabSelected(:final tab):
        state = state.copyWith(tab: tab);
      case CatalogSearchSortSelected(:final sort):
        state = state.copyWith(sort: sort);
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
    final normalizedQuery = query.trim();
    state = state.copyWith(
      query: normalizedQuery,
      dishes: const [],
      restaurants: normalizedQuery.isEmpty ? state.restaurants : const [],
      isSearching: true,
      hasDishError: false,
      hasRestaurantError: false,
    );
    if (normalizedQuery.isEmpty) {
      await _loadInitialRestaurants(requestEpoch: requestEpoch);
      return;
    }

    await ref.read(catalogSearchDelayProvider).wait();
    if (!ref.mounted || requestEpoch != _requestEpoch) return;

    final repository = ref.read(catalogSearchRepositoryProvider);
    final dishesFuture = _captureDishes(repository, normalizedQuery);
    final restaurantsFuture = _captureRestaurants(repository, normalizedQuery);
    final dishes = await dishesFuture;
    final restaurants = await restaurantsFuture;
    if (!ref.mounted || requestEpoch != _requestEpoch) return;

    final fallbackRestaurants = _matchingFixtures(normalizedQuery);
    final useFallbackRestaurants =
        restaurants.data.isEmpty && fallbackRestaurants.isNotEmpty;
    state = state.copyWith(
      dishes: dishes.data.map(_dishViewData).toList(growable: false),
      restaurants:
          useFallbackRestaurants
              ? fallbackRestaurants
              : restaurants.data
                  .map(_restaurantViewData)
                  .toList(growable: false),
      isSearching: false,
      hasDishError: dishes.hasError,
      hasRestaurantError: restaurants.hasError && !useFallbackRestaurants,
    );
  }

  Future<void> _loadInitialRestaurants({int? requestEpoch}) async {
    final epoch = requestEpoch ?? ++_requestEpoch;
    if (requestEpoch == null && state.restaurants.isNotEmpty) {
      state = state.copyWith(isSearching: false);
      return;
    }
    state = state.copyWith(
      clearQuery: requestEpoch != null,
      restaurants: const [],
      dishes: const [],
      isSearching: true,
      hasDishError: false,
      hasRestaurantError: false,
    );
    final result = await _captureBrowseRestaurants();
    if (!ref.mounted || epoch != _requestEpoch) return;
    final rows = result.restaurants
        .map(_browseRestaurantViewData)
        .toList(growable: false);
    state = state.copyWith(
      restaurants: rows.isEmpty ? catalogSearchPreviewFixtures : rows,
      isSearching: false,
      hasRestaurantError: false,
    );
  }

  Future<CatalogBrowseResult> _captureBrowseRestaurants() async {
    try {
      return await ref.read(catalogBrowsePortProvider).loadRestaurants();
    } catch (_) {
      return const CatalogBrowseResult();
    }
  }

  List<CatalogRestaurantSearchViewData> _matchingFixtures(String query) {
    final normalized = query.toLowerCase();
    return catalogSearchPreviewFixtures
        .where(
          (restaurant) => restaurant.name.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
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
      distanceKm: result.distanceKm,
      deliveryTimeMinutes: result.deliveryTimeMinutes,
      imageUrl: result.imageUrl,
    );
  }

  CatalogRestaurantSearchViewData _browseRestaurantViewData(
    CatalogRestaurantSnapshot result,
  ) {
    return CatalogRestaurantSearchViewData(
      id: result.id.toString(),
      name: result.name,
      cuisine: result.category,
      rating: result.rating,
      distanceKm: result.distanceKm,
      deliveryTimeMinutes: result.deliveryTimeMinutes,
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
