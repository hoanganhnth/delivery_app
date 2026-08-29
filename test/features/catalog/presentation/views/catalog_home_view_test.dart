import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_effect.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_view_model.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_home_view.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/domain/repositories/restaurant_repository.dart';
import 'package:delivery_app/features/restaurants/di/restaurant_di_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'catalog home view model maps featured data and queues navigation',
    () async {
      final repository = _FakeRestaurantRepository();
      final container = ProviderContainer(
        overrides: [
          restaurantRepositoryProvider.overrideWithValue(repository),
          catalogBrowsePortProvider.overrideWithValue(
            _FakeCatalogBrowsePort(repository),
          ),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(catalogHomeViewModelProvider.notifier);

      await notifier.dispatch(const CatalogHomeLoadRequested());
      expect(
        container.read(catalogHomeViewModelProvider).restaurants.single.name,
        'Bếp test',
      );
      expect(repository.lastLimit, 6);

      await notifier.dispatch(const CatalogHomeRestaurantRequested(201));
      final state = container.read(catalogHomeViewModelProvider);
      expect(
        state.effects.single.effect,
        isA<CatalogHomeNavigateToRestaurant>(),
      );
      await notifier.dispatch(
        CatalogHomeEffectConsumed(state.effects.single.id),
      );
      expect(container.read(catalogHomeViewModelProvider).effects, isEmpty);
    },
  );

  testWidgets('catalog home renders data and emits navigation intents only', (
    tester,
  ) async {
    final intents = <CatalogHomeIntent>[];
    await pumpTestApp(
      tester,
      child: CatalogHomeView(
        state: const CatalogHomeViewState(
          restaurants: [
            CatalogRestaurantViewData(
              id: 201,
              name: 'Bếp test',
              deliveryFee: 0,
            ),
          ],
        ),
        onIntent: intents.add,
      ),
    );

    tester.widget<AmberSearchBar>(find.byType(AmberSearchBar)).onTap!();
    await tester.tap(find.text('Giao đến'));
    await tester.tap(find.byIcon(Icons.notifications_outlined));
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.tap(find.text('Xem tất cả'));
    await tester.tap(find.text('Bếp test'));

    expect(intents[0], isA<CatalogHomeSearchRequested>());
    expect(intents[1], isA<CatalogHomeAddressRequested>());
    expect(intents[2], isA<CatalogHomeNotificationsRequested>());
    expect(intents[3], isA<CatalogHomeCartRequested>());
    expect(intents[4], isA<CatalogHomeAllRestaurantsRequested>());
    expect(
      intents[5],
      isA<CatalogHomeRestaurantRequested>().having(
        (intent) => intent.restaurantId,
        'restaurantId',
        201,
      ),
    );
  });
}

class _FakeRestaurantRepository implements RestaurantRepository {
  int? lastLimit;

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    lastLimit = limit;
    return Right([buildRestaurant()]);
  }

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(num id) async =>
      Right(buildRestaurant(id: id));

  @override
  Future<Either<Failure, List<MenuItemEntity>>> getMenuItems(
    num restaurantId,
  ) async => const Right([]);

  @override
  Future<Either<Failure, List<RestaurantEntity>>> searchRestaurants({
    required String query,
    double? latitude,
    double? longitude,
  }) async => Right([buildRestaurant()]);
}

class _FakeCatalogBrowsePort implements CatalogBrowsePort {
  _FakeCatalogBrowsePort(this.repository);
  final RestaurantRepository repository;

  @override
  Future<CatalogBrowseResult> loadFeatured() async {
    final result = await repository.getRestaurants(page: 1, limit: 6);
    return result.fold(
      (failure) => CatalogBrowseResult(errorMessage: failure.message),
      (rows) => CatalogBrowseResult(
        restaurants: rows
            .take(3)
            .map((row) => CatalogRestaurantSnapshot(id: row.id, name: row.name))
            .toList(),
      ),
    );
  }

  @override
  Future<CatalogBrowseResult> loadRestaurants() async => loadFeatured();

  @override
  Future<CatalogDetailResult> loadDetail(int restaurantId) async =>
      const CatalogDetailResult();
}
