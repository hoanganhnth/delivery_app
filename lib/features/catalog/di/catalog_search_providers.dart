import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:delivery_app/features/catalog/domain/catalog_search_repository.dart';

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

/// Catalog-owned Gateway adapter. Search DTOs are decoded at this boundary so
/// the catalog application layer never depends on the legacy Search feature.
final catalogSearchRepositoryProvider = Provider<CatalogSearchRepository>((
  ref,
) {
  return _CatalogSearchRepository(ref.watch(dioProvider));
});

final class _CatalogSearchRepository implements CatalogSearchRepository {
  const _CatalogSearchRepository(this._dio);

  final Dio _dio;

  @override
  Future<List<CatalogDishSearchResult>> searchDishes(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    final rows = await _request('/search/dishes', query, page, size);
    return rows
        .map(
          (row) => CatalogDishSearchResult(
            id: _string(row['id']),
            name: _string(row['name']),
            description: _nullableString(row['description']),
            price: _double(row['price']),
            restaurantId: _nullableString(row['restaurantId']),
            imageUrl: _nullableString(row['imageUrl'] ?? row['image']),
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
    final rows = await _request('/search/restaurants', query, page, size);
    return rows
        .map(
          (row) => CatalogRestaurantSearchResult(
            id: _string(row['id']),
            name: _string(row['name']),
            description: _nullableString(row['description']),
            cuisine: _nullableString(row['cuisine']),
            rating: _double(row['rating']),
            distanceKm: _double(row['distanceKm'] ?? row['distance']),
            deliveryTimeMinutes: _number(
              row['deliveryTimeMinutes'] ?? row['deliveryTime'],
            ),
            imageUrl: _nullableString(row['imageUrl'] ?? row['image']),
          ),
        )
        .toList(growable: false);
  }

  Future<List<Map<String, dynamic>>> _request(
    String path,
    String query,
    int page,
    int size,
  ) async {
    final response = await _dio.get(
      path,
      queryParameters: {'q': query, 'page': page, 'size': size},
    );
    final envelope = response.data;
    if (envelope is! Map<String, dynamic> ||
        envelope['status'] != 1 ||
        !envelope.containsKey('message') ||
        !envelope.containsKey('data')) {
      throw const FormatException('Search response is invalid');
    }
    final data = envelope['data'];
    final items = data is Map<String, dynamic> ? data['items'] : null;
    if (items is! List) {
      throw const FormatException('Search response page is invalid');
    }
    return items
        .whereType<Map>()
        .map((row) => Map<String, dynamic>.from(row))
        .toList(growable: false);
  }

  static String _string(Object? value) => value?.toString().trim() ?? '';

  static String? _nullableString(Object? value) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }

  static double? _double(Object? value) => switch (value) {
    num number => number.toDouble(),
    String text => double.tryParse(text),
    _ => null,
  };

  static num? _number(Object? value) => switch (value) {
    num number => number,
    String text => num.tryParse(text),
    _ => null,
  };
}
