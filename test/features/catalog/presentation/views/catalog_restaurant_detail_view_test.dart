import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:delivery_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:delivery_app/features/cart/di/cart_di_providers.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_effect.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_view_model.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_restaurant_detail_view.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/domain/repositories/restaurant_repository.dart';
import 'package:delivery_app/features/restaurants/di/restaurant_di_providers.dart';
import 'package:delivery_app/features/restaurants/di/flash_sale_catalog_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'detail ViewModel owns restaurant load, cart mutations and effects',
    () async {
      final restaurants = _FakeRestaurantRepository();
      final cart = _FakeCartRepository();
      final container = ProviderContainer(
        overrides: [
          restaurantRepositoryProvider.overrideWithValue(restaurants),
          catalogBrowsePortProvider.overrideWithValue(
            _FakeCatalogBrowsePort(restaurants),
          ),
          cartRepositoryProvider.overrideWithValue(cart),
          restaurantFlashSaleItemsProvider(
            201,
          ).overrideWith((ref) async => const {}),
        ],
      );
      addTearDown(container.dispose);
      final provider = catalogRestaurantDetailViewModelProvider(201);
      final notifier = container.read(provider.notifier);

      await notifier.dispatch(const CatalogRestaurantDetailLoadRequested());
      expect(container.read(provider).restaurant?.name, 'Bếp test');
      expect(container.read(provider).menuItems.single.name, 'Cơm test');

      await notifier.dispatch(
        const CatalogRestaurantDetailIncrementRequested(301),
      );
      expect(container.read(provider).cartItemsCount, 1);
      await notifier.dispatch(
        const CatalogRestaurantDetailDecrementRequested(301),
      );
      expect(container.read(provider).cartItemsCount, 0);

      await notifier.dispatch(const CatalogRestaurantDetailBackRequested());
      final state = container.read(provider);
      expect(
        state.effects.single.effect,
        isA<CatalogRestaurantDetailNavigateBack>(),
      );
      await notifier.dispatch(
        CatalogRestaurantDetailEffectConsumed(state.effects.single.id),
      );
      expect(container.read(provider).effects, isEmpty);
    },
  );

  test(
    'detail ViewModel confirms before replacing a different restaurant cart',
    () async {
      final container = ProviderContainer(
        overrides: [
          restaurantRepositoryProvider.overrideWithValue(
            _FakeRestaurantRepository(),
          ),
          catalogBrowsePortProvider.overrideWithValue(
            _FakeCatalogBrowsePort(_FakeRestaurantRepository()),
          ),
          cartRepositoryProvider.overrideWithValue(_FakeCartRepository()),
          restaurantFlashSaleItemsProvider(
            201,
          ).overrideWith((ref) async => const {}),
          restaurantFlashSaleItemsProvider(
            202,
          ).overrideWith((ref) async => const {}),
        ],
      );
      addTearDown(container.dispose);
      final first = catalogRestaurantDetailViewModelProvider(201);
      await container
          .read(first.notifier)
          .dispatch(const CatalogRestaurantDetailLoadRequested());
      await container
          .read(first.notifier)
          .dispatch(const CatalogRestaurantDetailIncrementRequested(301));

      final second = catalogRestaurantDetailViewModelProvider(202);
      await container
          .read(second.notifier)
          .dispatch(const CatalogRestaurantDetailLoadRequested());
      await container
          .read(second.notifier)
          .dispatch(const CatalogRestaurantDetailIncrementRequested(301));
      final pending = container.read(second);
      expect(
        pending.effects.single.effect,
        isA<CatalogRestaurantDetailConfirmRestaurantChange>(),
      );

      await container
          .read(second.notifier)
          .dispatch(
            const CatalogRestaurantDetailRestaurantChangeConfirmed(301),
          );
      expect(container.read(second).cartItemsCount, 1);
    },
  );

  testWidgets(
    'restaurant detail renders data and emits typed menu/navigation intents',
    (tester) async {
      final intents = <CatalogRestaurantDetailIntent>[];
      await pumpTestApp(
        tester,
        child: CatalogRestaurantDetailView(
          state: const CatalogRestaurantDetailViewState(
            restaurant: CatalogRestaurantDetailData(
              id: 201,
              name: 'Bếp test',
              address: '1 Đường Test',
            ),
            menuItems: [
              CatalogMenuItemViewData(
                id: 301,
                name: 'Cơm test',
                description: 'Món thử nghiệm',
                catalogPrice: 50000,
                availability: CatalogMenuAvailability.available,
                quantity: 1,
              ),
            ],
            cartItemsCount: 1,
            cartTotalAmount: 50000,
          ),
          onIntent: intents.add,
        ),
      );

      await tester.tap(find.byKey(const Key('menu_increment_301')));
      await tester.tap(find.byKey(const Key('menu_decrement_301')));
      await tester.tap(find.text('Xem giỏ hàng (1)'));
      await tester.tap(find.byIcon(Icons.arrow_back).first);

      expect(intents[0], isA<CatalogRestaurantDetailIncrementRequested>());
      expect(intents[1], isA<CatalogRestaurantDetailDecrementRequested>());
      expect(intents[2], isA<CatalogRestaurantDetailCartRequested>());
      expect(intents[3], isA<CatalogRestaurantDetailBackRequested>());
    },
  );
}

class _FakeRestaurantRepository implements RestaurantRepository {
  @override
  Future<Either<Failure, List<RestaurantEntity>>> getRestaurants({
    double? latitude,
    double? longitude,
    String? category,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async => Right([buildRestaurant()]);

  @override
  Future<Either<Failure, RestaurantEntity>> getRestaurantById(num id) async =>
      Right(buildRestaurant(id: id));

  @override
  Future<Either<Failure, List<MenuItemEntity>>> getMenuItems(
    num restaurantId,
  ) async => Right([buildMenuItem(restaurantId: restaurantId)]);

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
  Future<CatalogBrowseResult> loadFeatured() async => const CatalogBrowseResult();

  @override
  Future<CatalogBrowseResult> loadRestaurants() async => const CatalogBrowseResult();

  @override
  Future<CatalogDetailResult> loadDetail(int restaurantId) async {
    final restaurant = await repository.getRestaurantById(restaurantId);
    return restaurant.fold(
      (failure) => CatalogDetailResult(errorMessage: failure.message),
      (value) async {
        final menu = await repository.getMenuItems(restaurantId);
        return menu.fold(
          (failure) => CatalogDetailResult(
            restaurant: CatalogRestaurantSnapshot(id: value.id, name: value.name),
            errorMessage: failure.message,
          ),
          (items) => CatalogDetailResult(
            restaurant: CatalogRestaurantSnapshot(id: value.id, name: value.name),
            menuItems: items
                .map(
                  (item) => CatalogMenuSnapshot(
                    id: item.id,
                    restaurantId: item.restaurantId ?? value.id,
                    name: item.name,
                    description: item.description,
                    price: item.price,
                    status: switch (item.status) {
                      MenuItemStatus.available => CatalogMenuStatus.available,
                      MenuItemStatus.unavailable => CatalogMenuStatus.unavailable,
                      MenuItemStatus.soldOut => CatalogMenuStatus.soldOut,
                    },
                    imageUrl: item.image,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _FakeCartRepository implements CartRepository {
  CartEntity _cart = const CartEntity(
    items: [],
    currentRestaurantId: null,
    currentRestaurantName: null,
  );

  @override
  Future<Either<Failure, CartEntity>> addItem(CartItemEntity item) async {
    final current = [..._cart.items];
    final index = current.indexWhere(
      (row) => row.menuItemId == item.menuItemId,
    );
    if (index >= 0) {
      current[index] = current[index].copyWith(
        quantity: current[index].quantity + item.quantity,
      );
    } else {
      current.add(item);
    }
    _cart = _withItems(current);
    return Right(_cart);
  }

  @override
  Future<Either<Failure, Unit>> clearCart() async {
    _cart = _withItems(const []);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, bool>> canAddFromRestaurant(num restaurantId) async =>
      Right(_cart.canAddFromRestaurant(restaurantId));

  @override
  Future<Either<Failure, CartEntity>> getCart() async => Right(_cart);

  @override
  Future<Either<Failure, CartEntity>> removeItem(num menuItemId) async {
    _cart = _withItems(
      _cart.items.where((item) => item.menuItemId != menuItemId).toList(),
    );
    return Right(_cart);
  }

  @override
  Future<Either<Failure, CartEntity>> updateItemNotes(
    num menuItemId,
    String? notes,
  ) async => Right(_cart);

  @override
  Future<Either<Failure, CartEntity>> updateItemQuantity(
    num menuItemId,
    int quantity,
  ) async {
    _cart = _withItems(
      _cart.items
          .map(
            (item) => item.menuItemId == menuItemId
                ? item.copyWith(quantity: quantity)
                : item,
          )
          .toList(),
    );
    return Right(_cart);
  }

  CartEntity _withItems(List<CartItemEntity> items) {
    return CartEntity(
      items: items,
      currentRestaurantId: items.isEmpty ? null : items.first.restaurantId,
      currentRestaurantName: items.isEmpty ? null : items.first.restaurantName,
    );
  }
}
