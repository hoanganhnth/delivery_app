import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'catalog_contract.dart';

/// Neutral catalog browse dependency. Production composition supplies the
/// Restaurants-backed implementation; tests can override it with a fake.
final catalogBrowsePortProvider = Provider<CatalogBrowsePort>((ref) {
  return _UnavailableCatalogBrowsePort.instance;
});

final catalogMenuLookupPortProvider = Provider<CatalogMenuLookupPort>((ref) {
  return _UnavailableCatalogBrowsePort.instance;
});

final class _UnavailableCatalogBrowsePort
    implements CatalogBrowsePort, CatalogMenuLookupPort {
  const _UnavailableCatalogBrowsePort._();

  static const instance = _UnavailableCatalogBrowsePort._();

  @override
  Future<CatalogBrowseResult> loadFeatured() async =>
      const CatalogBrowseResult();

  @override
  Future<CatalogBrowseResult> loadRestaurants() async =>
      const CatalogBrowseResult();

  @override
  Future<CatalogDetailResult> loadDetail(int restaurantId) async =>
      const CatalogDetailResult();

  @override
  Future<List<CatalogMenuSnapshot>> menuItems(int restaurantId) async =>
      const <CatalogMenuSnapshot>[];
}
