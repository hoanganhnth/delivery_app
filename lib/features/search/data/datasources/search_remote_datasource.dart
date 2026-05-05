import 'package:dio/dio.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:delivery_app/features/search/data/models/search_result_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_remote_datasource.g.dart';

abstract class SearchRemoteDataSource {
  Future<List<RestaurantSearchResult>> searchRestaurants(String query, {int page = 0, int size = 20});
  Future<List<DishSearchResult>> searchDishes(String query, {int page = 0, int size = 20});
  Future<List<ShipperSearchResult>> searchShippers(String query, {int page = 0, int size = 20});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio _dio;

  SearchRemoteDataSourceImpl(this._dio);

  @override
  Future<List<RestaurantSearchResult>> searchRestaurants(String query, {int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        '/api/search/restaurants',
        queryParameters: {'q': query, 'page': page, 'size': size},
      );
      final List data = response.data['content'] ?? [];
      return data.map((json) => RestaurantSearchResult.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DishSearchResult>> searchDishes(String query, {int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        '/api/search/dishes',
        queryParameters: {'q': query, 'page': page, 'size': size},
      );
      final List data = response.data['content'] ?? [];
      return data.map((json) => DishSearchResult.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ShipperSearchResult>> searchShippers(String query, {int page = 0, int size = 20}) async {
    try {
      final response = await _dio.get(
        '/api/search/shippers',
        queryParameters: {'q': query, 'page': page, 'size': size},
      );
      final List data = response.data['content'] ?? [];
      return data.map((json) => ShipperSearchResult.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

@riverpod
SearchRemoteDataSource searchRemoteDataSource(Ref ref) {
  return SearchRemoteDataSourceImpl(ref.watch(dioProvider));
}
