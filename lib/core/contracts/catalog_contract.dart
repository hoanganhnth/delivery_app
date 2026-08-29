import 'cart_contract.dart';

/// Neutral read port for customer catalog browsing.
///
/// Catalog owns the application and presentation state; Restaurants (or a
/// future remote catalog adapter) provides the implementation at composition.
abstract interface class CatalogBrowsePort {
  Future<CatalogBrowseResult> loadFeatured();
  Future<CatalogBrowseResult> loadRestaurants();
  Future<CatalogDetailResult> loadDetail(int restaurantId);
}

abstract interface class CatalogMenuLookupPort {
  Future<List<CatalogMenuSnapshot>> menuItems(int restaurantId);
}

final class CatalogBrowseResult {
  const CatalogBrowseResult({
    this.restaurants = const <CatalogRestaurantSnapshot>[],
    this.errorMessage,
  });

  final List<CatalogRestaurantSnapshot> restaurants;
  final String? errorMessage;
}

final class CatalogDetailResult {
  const CatalogDetailResult({
    this.restaurant,
    this.menuItems = const [],
    this.errorMessage,
  });

  final CatalogRestaurantSnapshot? restaurant;
  final List<CatalogMenuSnapshot> menuItems;
  final String? errorMessage;
}

final class CatalogRestaurantSnapshot {
  const CatalogRestaurantSnapshot({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.address,
    this.rating,
    this.reviewCount,
    this.deliveryTimeMinutes,
    this.category,
    this.distanceKm,
    this.deliveryFee,
    this.openingHour,
    this.closingHour,
    this.isOpen,
  });

  final num id;
  final String name;
  final String? imageUrl;
  final String? description;
  final String? address;
  final double? rating;
  final int? reviewCount;
  final num? deliveryTimeMinutes;
  final String? category;
  final double? distanceKm;
  final double? deliveryFee;
  final String? openingHour;
  final String? closingHour;
  final bool? isOpen;
}

enum CatalogMenuStatus { available, unavailable, soldOut }

final class CatalogMenuSnapshot implements CartLineSource {
  const CatalogMenuSnapshot({
    this.id,
    this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    required this.status,
    this.imageUrl,
  });

  @override
  final num? id;
  @override
  final num? restaurantId;
  @override
  final String name;
  final String description;
  @override
  final double price;
  final CatalogMenuStatus status;
  final String? imageUrl;

  @override
  bool get canAddToCart =>
      status == CatalogMenuStatus.available &&
      id != null &&
      id! > 0 &&
      restaurantId != null &&
      restaurantId! > 0 &&
      name.trim().isNotEmpty &&
      price > 0;

  @override
  String? get image => imageUrl;
}
