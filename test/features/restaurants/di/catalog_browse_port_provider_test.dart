import 'package:delivery_app/features/restaurants/di/catalog_browse_port_provider.dart';
import 'package:delivery_app/features/restaurants/di/restaurant_di_providers.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/domain/repositories/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:delivery_app/core/error/failures.dart';

void main() {
  test('featured restaurants prefer the newest restaurants', () async {
    final container = ProviderContainer(
      overrides: [
        restaurantRepositoryProvider.overrideWithValue(
          _FakeRestaurantRepository([
            _restaurant(1, 'Quán cũ'),
            _restaurant(35, 'Quán Test HÀ ĐÔNG'),
          ]),
        ),
      ],
    );
    addTearDown(container.dispose);

    final result =
        await container.read(catalogBrowsePortProvider).loadFeatured();

    expect(result.restaurants.map((restaurant) => restaurant.name), [
      'Quán Test HÀ ĐÔNG',
      'Quán cũ',
    ]);
  });
}

RestaurantEntity _restaurant(num id, String name) =>
    RestaurantEntity(id: id, name: name, address: 'Hà Nội');

class _FakeRestaurantRepository implements RestaurantRepository {
  _FakeRestaurantRepository(this.restaurants);

  final List<RestaurantEntity> restaurants;

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async => Right(restaurants);

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(num id) async =>
      Right(restaurants.firstWhere((restaurant) => restaurant.id == id));

  @override
  Future<Either<Failure, List<MenuItemEntity>>> getMenuItems(
    num restaurantId,
  ) async => const Right([]);

  @override
  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurants({
    required String query,
    double? latitude,
    double? longitude,
  }) async => Right(restaurants);
}
