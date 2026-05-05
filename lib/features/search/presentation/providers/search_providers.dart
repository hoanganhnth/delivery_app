import 'package:delivery_app/features/search/data/models/search_result_model.dart';
import 'package:delivery_app/features/search/domain/repositories/search_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_providers.g.dart';

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
  int build() => 0; // 0: Dishes, 1: Restaurants, 2: Shippers

  void setTab(int tabIndex) {
    state = tabIndex;
  }
}

@riverpod
Future<List<DishSearchResult>> searchDishesResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  
  // Optional: add a debounce delay
  await Future.delayed(const Duration(milliseconds: 300));
  
  final repository = ref.read(searchRepositoryProvider);
  return repository.searchDishes(query);
}

@riverpod
Future<List<RestaurantSearchResult>> searchRestaurantsResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  
  await Future.delayed(const Duration(milliseconds: 300));
  
  final repository = ref.read(searchRepositoryProvider);
  return repository.searchRestaurants(query);
}

@riverpod
Future<List<ShipperSearchResult>> searchShippersResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];
  
  await Future.delayed(const Duration(milliseconds: 300));
  
  final repository = ref.read(searchRepositoryProvider);
  return repository.searchShippers(query);
}
