/// Search facts owned by the catalog bounded context.
///
/// They intentionally do not expose the legacy search DTO/model types.
final class CatalogRestaurantSearchResult {
  const CatalogRestaurantSearchResult({
    required this.id,
    required this.name,
    this.description,
    this.cuisine,
    this.rating,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? description;
  final String? cuisine;
  final double? rating;
  final String? imageUrl;
}

final class CatalogDishSearchResult {
  const CatalogDishSearchResult({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.restaurantId,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? description;
  final double? price;
  final String? restaurantId;
  final String? imageUrl;
}

abstract interface class CatalogSearchRepository {
  Future<List<CatalogRestaurantSearchResult>> searchRestaurants(
    String query, {
    int page = 0,
    int size = 20,
  });

  Future<List<CatalogDishSearchResult>> searchDishes(
    String query, {
    int page = 0,
    int size = 20,
  });
}
