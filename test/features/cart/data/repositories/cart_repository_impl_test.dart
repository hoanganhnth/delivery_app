import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:delivery_app/features/cart/data/dtos/cart_dto.dart';
import 'package:delivery_app/features/cart/data/dtos/cart_item_dto.dart';
import 'package:delivery_app/features/cart/data/repositories_impl/cart_repository_impl.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'repository rejects cross-restaurant items before mutating storage',
    () async {
      final dataSource = _FakeCartLocalDataSource(
        const CartDto(
          items: [
            CartItemDto(
              menuItemId: 301,
              menuItemName: 'Cơm test',
              price: 50000,
              quantity: 1,
              restaurantId: 201,
              restaurantName: 'Bếp test',
            ),
          ],
          currentRestaurantId: 201,
          currentRestaurantName: 'Bếp test',
        ),
      );
      final repository = CartRepositoryImpl(dataSource);

      final result = await repository.addItem(
        buildCartItem(menuItemId: 302, restaurantId: 202),
      );

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((failure) => failure, (_) => null),
        isA<ValidationFailure>(),
      );
      expect(dataSource.addCalls, 0);
      expect(dataSource.cart.currentRestaurantId, 201);
    },
  );

  test('repository still forwards a same-restaurant item', () async {
    final dataSource = _FakeCartLocalDataSource(
      const CartDto(
        items: [],
        currentRestaurantId: null,
        currentRestaurantName: null,
      ),
    );
    final repository = CartRepositoryImpl(dataSource);

    final result = await repository.addItem(
      buildCartItem(flashSaleItemId: 8801),
    );

    expect(result.isRight(), isTrue);
    expect(dataSource.addCalls, 1);
    expect(dataSource.cart.items.single.menuItemId, 301);
    expect(dataSource.cart.items.single.flashSaleItemId, 8801);
  });
}

class _FakeCartLocalDataSource implements CartLocalDataSource {
  _FakeCartLocalDataSource(this.cart);

  CartDto cart;
  int addCalls = 0;

  @override
  Future<Either<Exception, CartDto>> getCart() async => Right(cart);

  @override
  Future<Either<Exception, CartDto>> addItem(CartItemDto item) async {
    addCalls += 1;
    cart = CartDto(
      items: [...cart.items, item],
      currentRestaurantId: item.restaurantId,
      currentRestaurantName: item.restaurantName,
    );
    return Right(cart);
  }

  @override
  Future<Either<Exception, Unit>> clearCart() async {
    cart = const CartDto(
      items: [],
      currentRestaurantId: null,
      currentRestaurantName: null,
    );
    return const Right(unit);
  }

  @override
  Future<Either<Exception, CartDto>> removeItem(num menuItemId) async =>
      Right(cart);

  @override
  Future<Either<Exception, Unit>> saveCart(CartDto cart) async {
    this.cart = cart;
    return const Right(unit);
  }

  @override
  Future<Either<Exception, CartDto>> updateItemNotes(
    num menuItemId,
    String? notes,
  ) async => Right(cart);

  @override
  Future<Either<Exception, CartDto>> updateItemQuantity(
    num menuItemId,
    int quantity,
  ) async => Right(cart);
}
