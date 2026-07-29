import 'package:dio/dio.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:delivery_app/features/search/data/models/search_result_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_remote_datasource.g.dart';

abstract class SearchRemoteDataSource {
  Future<List<RestaurantSearchResult>> searchRestaurants(
    String query, {
    int page = 0,
    int size = 20,
  });
  Future<List<DishSearchResult>> searchDishes(
    String query, {
    int page = 0,
    int size = 20,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final Dio _dio;

  SearchRemoteDataSourceImpl(this._dio);

  List<dynamic> _extractPageContent(Response<dynamic> response) {
    final envelope = response.data;
    if (envelope is! Map<String, dynamic> ||
        envelope['status'] != 1 ||
        !envelope.containsKey('message') ||
        !envelope.containsKey('data')) {
      throw const FormatException(
        'Search response does not match the canonical BaseResponse contract',
      );
    }

    final page = envelope['data'];
    if (page is! Map<String, dynamic> || page['items'] is! List<dynamic>) {
      throw const FormatException('Search response contains an invalid page');
    }
    return page['items'] as List<dynamic>;
  }

  @override
  Future<List<RestaurantSearchResult>> searchRestaurants(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/search/restaurants',
        queryParameters: {'q': query, 'page': page, 'size': size},
      );
      final data = _extractPageContent(response);
      return data.map((json) {
        if (json is! Map<String, dynamic>) {
          throw const FormatException('Restaurant search result must be an object');
        }
        return RestaurantSearchResult.fromJson(json);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DishSearchResult>> searchDishes(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/search/dishes',
        queryParameters: {'q': query, 'page': page, 'size': size},
      );
      final data = _extractPageContent(response);
      return data.map((json) {
        if (json is! Map<String, dynamic>) {
          throw const FormatException('Dish search result must be an object');
        }
        return DishSearchResult.fromJson(json);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}

@riverpod
SearchRemoteDataSource searchRemoteDataSource(Ref ref) {
  return SearchRemoteDataSourceImpl(ref.watch(dioProvider));
}
