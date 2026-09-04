import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/features/restaurants/di/restaurant_di_providers.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/domain/usecases/get_restaurant_by_id_usecase.dart';
import 'package:delivery_app/features/restaurants/domain/usecases/get_restaurants_usecase.dart';
import 'package:delivery_app/features/restaurants/domain/usecases/get_menu_items_usecase.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';

/// Adapter that keeps Restaurant entities behind the neutral Catalog port.
final catalogBrowsePortProvider = Provider<CatalogBrowsePort>((ref) {
  final addressState = ref.watch(userAddressListProvider);
  final activeAddress =
      addressState.selectedAddress ?? addressState.defaultAddress;
  return _RestaurantsCatalogAdapter(
    getRestaurants: ref.watch(getRestaurantsUseCaseProvider),
    getRestaurant: ref.watch(getRestaurantByIdUseCaseProvider),
    getMenuItems: ref.watch(getMenuItemsUseCaseProvider),
    latitude: activeAddress?.latitude,
    longitude: activeAddress?.longitude,
  );
});

final catalogMenuLookupPortProvider = Provider<CatalogMenuLookupPort>((ref) {
  return _RestaurantsCatalogAdapter(
    getRestaurants: ref.watch(getRestaurantsUseCaseProvider),
    getRestaurant: ref.watch(getRestaurantByIdUseCaseProvider),
    getMenuItems: ref.watch(getMenuItemsUseCaseProvider),
  );
});

final class _RestaurantsCatalogAdapter
    implements CatalogBrowsePort, CatalogMenuLookupPort {
  const _RestaurantsCatalogAdapter({
    required this.getRestaurants,
    required this.getRestaurant,
    required this.getMenuItems,
    this.latitude,
    this.longitude,
  });

  final GetRestaurantsUseCase getRestaurants;
  final GetRestaurantByIdUseCase getRestaurant;
  final GetMenuItemsUseCase getMenuItems;
  final double? latitude;
  final double? longitude;

  @override
  Future<CatalogBrowseResult> loadFeatured() async {
    final result = await getRestaurants(
      GetRestaurantsParams(
        latitude: latitude,
        longitude: longitude,
        page: 1,
        limit: 6,
      ),
    );
    return result.fold(
      (failure) => CatalogBrowseResult(errorMessage: failure.message),
      (rows) {
        // The REST list is currently ordered by insertion/ID. Prefer the
        // newest entries for the home spotlight so a newly created restaurant
        // is immediately discoverable without changing the public API.
        final featured =
            rows.toList()..sort((left, right) => right.id.compareTo(left.id));
        return CatalogBrowseResult(
          restaurants: featured
              .take(3)
              .map(_restaurant)
              .toList(growable: false),
        );
      },
    );
  }

  @override
  Future<CatalogBrowseResult> loadRestaurants() async {
    final result = await getRestaurants(
      GetRestaurantsParams(
        latitude: latitude,
        longitude: longitude,
      ),
    );
    return result.fold(
      (failure) => CatalogBrowseResult(errorMessage: failure.message),
      (rows) => CatalogBrowseResult(
        restaurants: rows.map(_restaurant).toList(growable: false),
      ),
    );
  }

  @override
  Future<CatalogDetailResult> loadDetail(int restaurantId) async {
    final restaurantResult = await getRestaurant(restaurantId);
    return restaurantResult.fold<Future<CatalogDetailResult>>(
      (failure) async => CatalogDetailResult(errorMessage: failure.message),
      (restaurant) async {
        final menuResult = await getMenuItems(restaurantId);
        return menuResult.fold(
          (failure) => CatalogDetailResult(
            restaurant: _restaurant(restaurant),
            errorMessage: failure.message,
          ),
          (menu) => CatalogDetailResult(
            restaurant: _restaurant(restaurant),
            menuItems: menu
                .map((item) => _menu(item, restaurant.id))
                .toList(growable: false),
          ),
        );
      },
    );
  }

  @override
  Future<List<CatalogMenuSnapshot>> menuItems(int restaurantId) async {
    final result = await getMenuItems(restaurantId);
    return result.fold(
      (_) => const <CatalogMenuSnapshot>[],
      (rows) =>
          rows.map((item) => _menu(item, restaurantId)).toList(growable: false),
    );
  }

  static CatalogRestaurantSnapshot _restaurant(RestaurantEntity value) =>
      CatalogRestaurantSnapshot(
        id: value.id,
        name: value.name,
        imageUrl: value.image,
        description: value.description,
        address: value.address,
        rating: value.rating,
        reviewCount: value.reviewCount,
        deliveryTimeMinutes: value.deliveryTime,
        category: value.category,
        distanceKm: value.distance,
        deliveryFee: value.deliveryFee,
        openingHour: value.openingHour,
        closingHour: value.closingHour,
        isOpen: value.isOpen,
      );

  static CatalogMenuSnapshot _menu(MenuItemEntity value, num restaurantId) =>
      CatalogMenuSnapshot(
        id: value.id,
        restaurantId: value.restaurantId ?? restaurantId,
        name: value.name,
        description: value.description,
        price: value.price,
        status: switch (value.status) {
          MenuItemStatus.available => CatalogMenuStatus.available,
          MenuItemStatus.unavailable => CatalogMenuStatus.unavailable,
          MenuItemStatus.soldOut => CatalogMenuStatus.soldOut,
        },
        imageUrl: value.image,
      );
}
