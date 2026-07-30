import 'package:delivery_app/features/search/data/models/search_result_model.dart';
import 'package:delivery_app/features/search/domain/repositories/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_providers.g.dart';

abstract interface class SearchDelayPort {
  Future<void> wait();
}

class DefaultSearchDelay implements SearchDelayPort {
  const DefaultSearchDelay();

  @override
  Future<void> wait() => Future<void>.delayed(
    const Duration(milliseconds: 300),
  );
}

final searchDelayProvider = Provider<SearchDelayPort>((ref) {
  return const DefaultSearchDelay();
});

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
class SearchFilterTab extends _$SearchFilterTab {
  @override
  int build() => 0; // 0: Dishes, 1: Restaurants

  void setTab(int tabIndex) {
    state = tabIndex;
  }
}

@riverpod
Future<List<DishSearchResult>> searchDishesResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  await ref.read(searchDelayProvider).wait();

  final repository = ref.read(searchRepositoryProvider);
  return repository.searchDishes(query);
}

@riverpod
Future<List<RestaurantSearchResult>> searchRestaurantsResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  await ref.read(searchDelayProvider).wait();

  final repository = ref.read(searchRepositoryProvider);
  return repository.searchRestaurants(query);
}
