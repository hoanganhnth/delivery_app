import 'package:delivery_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:delivery_app/features/search/data/models/search_result_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_repository.g.dart';

abstract class SearchRepository {
  Future<List<RestaurantSearchResult>> searchRestaurants(String query, {int page = 0, int size = 20});
  Future<List<DishSearchResult>> searchDishes(String query, {int page = 0, int size = 20});
  Future<List<ShipperSearchResult>> searchShippers(String query, {int page = 0, int size = 20});
}

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<RestaurantSearchResult>> searchRestaurants(String query, {int page = 0, int size = 20}) {
    return _remoteDataSource.searchRestaurants(query, page: page, size: size);
  }

  @override
  Future<List<DishSearchResult>> searchDishes(String query, {int page = 0, int size = 20}) {
    return _remoteDataSource.searchDishes(query, page: page, size: size);
  }

  @override
  Future<List<ShipperSearchResult>> searchShippers(String query, {int page = 0, int size = 20}) {
    return _remoteDataSource.searchShippers(query, page: page, size: size);
  }
}

@riverpod
SearchRepository searchRepository(Ref ref) {
  return SearchRepositoryImpl(ref.watch(searchRemoteDataSourceProvider));
}
