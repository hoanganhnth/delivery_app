import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/domain/repositories/restaurant_repository.dart';
import 'package:delivery_app/features/restaurants/presentation/providers/detail/restaurant_detail_notifier.dart';
import 'package:delivery_app/features/restaurants/presentation/providers/di/restaurant_di_providers.dart';
import 'package:delivery_app/features/restaurants/presentation/providers/list/restaurants_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  group('restaurant catalog and detail providers', () {
    test('loads catalog, exposes loading, then retries a backend failure', () async {
      final repository = _FakeRestaurantRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(restaurantsProvider, (_, _) {});
      final notifier = container.read(restaurantsProvider.notifier);

      repository.restaurantsResult = const Left(
        NetworkFailure('Mất kết nối danh sách'),
      );
      final failedLoad = notifier.loadRestaurants(page: 2, limit: 10);
      expect(container.read(restaurantsProvider).isLoading, isTrue);
      await failedLoad;

      expect(container.read(restaurantsProvider).errorMessage, 'Mất kết nối danh sách');
      expect(repository.lastPage, 2);
      expect(repository.lastLimit, 10);

      repository.restaurantsResult = Right([buildRestaurant()]);
      await notifier.refreshRestaurants();

      final state = container.read(restaurantsProvider);
      expect(state.isLoading, isFalse);
      expect(state.failure, isNull);
      expect(state.restaurants.single.name, 'Bếp test');
    });

    test('searches by query, restores the catalog for blank input and limits featured rows', () async {
      final repository = _FakeRestaurantRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(restaurantsProvider, (_, _) {});
      final notifier = container.read(restaurantsProvider.notifier);

      repository.searchResult = Right([buildRestaurant(name: 'Bếp tìm kiếm')]);
      await notifier.searchRestaurants('  cơm  ');
      expect(repository.lastSearchQuery, '  cơm  ');
      expect(container.read(restaurantsProvider).restaurants.single.name, 'Bếp tìm kiếm');

      repository.restaurantsResult = Right([buildRestaurant(name: 'Danh sách gốc')]);
      await notifier.searchRestaurants('   ');
      expect(container.read(restaurantsProvider).restaurants.single.name, 'Danh sách gốc');

      repository.restaurantsResult = Right(
        List.generate(6, (index) => buildRestaurant(id: index + 1)),
      );
      await notifier.loadFeaturedRestaurants();
      expect(container.read(restaurantsProvider).restaurants, hasLength(3));
    });

    test('keeps restaurant facts when menu load fails and retries menu only', () async {
      final repository = _FakeRestaurantRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(restaurantDetailProvider, (_, _) {});
      final notifier = container.read(restaurantDetailProvider.notifier);

      repository.restaurantResult = Right(buildRestaurant());
      repository.menuResult = const Left(ServerFailure('Menu tạm thời lỗi'));
      await notifier.loadRestaurantDetail(201);

      var state = container.read(restaurantDetailProvider);
      expect(state.restaurant?.id, 201);
      expect(state.menuItems, isEmpty);
      expect(state.errorMessage, 'Menu tạm thời lỗi');

      repository.menuResult = Right([buildMenuItem()]);
      final retry = notifier.loadMenuItems(201);
      expect(container.read(restaurantDetailProvider).isMenuLoading, isTrue);
      await retry;

      state = container.read(restaurantDetailProvider);
      expect(state.restaurant?.id, 201);
      expect(state.menuItems.single.name, 'Cơm test');
      expect(state.failure, isNull);
      expect(repository.restaurantCalls, 1);
      expect(repository.menuCalls, 2);
    });
  });
}

ProviderContainer _container(_FakeRestaurantRepository repository) {
  return ProviderContainer(
    overrides: [
      restaurantRepositoryProvider.overrideWithValue(repository),
    ],
  );
}

class _FakeRestaurantRepository implements RestaurantRepository {
  Either<Failure, List<RestaurantEntity>> restaurantsResult = Right([
    buildRestaurant(),
  ]);
  Either<Failure, RestaurantEntity> restaurantResult = Right(buildRestaurant());
  Either<Failure, List<MenuItemEntity>> menuResult = Right([buildMenuItem()]);
  Either<Failure, List<RestaurantEntity>> searchResult = Right([
    buildRestaurant(),
  ]);

  int? lastPage;
  int? lastLimit;
  String? lastSearchQuery;
  int restaurantCalls = 0;
  int menuCalls = 0;

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    lastPage = page;
    lastLimit = limit;
    return restaurantsResult;
  }

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(num id) async {
    restaurantCalls += 1;
    return restaurantResult;
  }

  @override
  Future<Either<Failure, List<MenuItemEntity>>> getMenuItems(
    num restaurantId,
  ) async {
    menuCalls += 1;
    return menuResult;
  }

  @override
  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurants({
    required String query,
    double? latitude,
    double? longitude,
  }) async {
    lastSearchQuery = query;
    return searchResult;
  }
}
