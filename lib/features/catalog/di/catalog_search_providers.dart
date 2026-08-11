import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/catalog/domain/catalog_search_repository.dart';
import 'package:delivery_app/features/search/data/datasources/search_remote_datasource.dart';

abstract interface class CatalogSearchDelayPort {
  Future<void> wait();
}

class DefaultCatalogSearchDelay implements CatalogSearchDelayPort {
  const DefaultCatalogSearchDelay();

  @override
  Future<void> wait() =>
      Future<void>.delayed(const Duration(milliseconds: 300));
}

final catalogSearchDelayProvider = Provider<CatalogSearchDelayPort>((ref) {
  return const DefaultCatalogSearchDelay();
});

/// Catalog composition adapter over the Gateway search datasource. Data DTOs
/// stop here; the application layer consumes only catalog domain results.
final catalogSearchRepositoryProvider = Provider<CatalogSearchRepository>((
  ref,
) {
  return _RemoteCatalogSearchRepository(
    ref.watch(searchRemoteDataSourceProvider),
  );
});

class _RemoteCatalogSearchRepository implements CatalogSearchRepository {
  const _RemoteCatalogSearchRepository(this._delegate);

  final SearchRemoteDataSource _delegate;

  @override
  Future<List<CatalogDishSearchResult>> searchDishes(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    final rows = await _delegate.searchDishes(query, page: page, size: size);
    return rows
        .map(
          (row) => CatalogDishSearchResult(
            id: row.id,
            name: row.name,
            description: row.description,
            price: row.price,
            restaurantId: row.restaurantId,
            imageUrl: row.imageUrl,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<List<CatalogRestaurantSearchResult>> searchRestaurants(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    final rows = await _delegate.searchRestaurants(
      query,
      page: page,
      size: size,
    );
    return rows
        .map(
          (row) => CatalogRestaurantSearchResult(
            id: row.id,
            name: row.name,
            description: row.description,
            cuisine: row.cuisine,
            rating: row.rating,
            imageUrl: row.imageUrl,
          ),
        )
        .toList(growable: false);
  }
}
