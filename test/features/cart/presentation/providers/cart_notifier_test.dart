import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:delivery_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:delivery_app/features/cart/presentation/providers/di/cart_di_providers.dart';
import 'package:delivery_app/features/cart/presentation/providers/state/cart_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  test('cart actions add, update notes/quantity, remove and clear', () async {
    final repository = _InMemoryCartRepository();
    final container = _container(repository);
    addTearDown(container.dispose);
    final initial = await container.read(cartProvider.future);
    expect(initial.isEmpty, isTrue);
    final notifier = container.read(cartProvider.notifier);

    await notifier.addItem(buildCartItem());
    expect(container.read(cartProvider).value?.totalItems, 1);
    expect(notifier.canAddFromRestaurant(201), isTrue);
    expect(notifier.canAddFromRestaurant(202), isFalse);

    await notifier.updateItemQuantity(301, 3);
    await notifier.updateItemNotes(301, 'Ít cay');
    var item = container.read(cartProvider).value!.items.single;
    expect(item.quantity, 3);
    expect(item.notes, 'Ít cay');
    expect(notifier.getItemQuantity(301), 3);

    await notifier.updateItemQuantity(301, 0);
    expect(container.read(cartProvider).value?.isEmpty, isTrue);
    expect(container.read(cartProvider).value?.currentRestaurantId, isNull);

    await notifier.addItem(buildCartItem());
    await notifier.clearCart();
    expect(container.read(cartProvider).value?.isEmpty, isTrue);
  });

  test('cross-restaurant and storage failures preserve the current cart for retry', () async {
    final repository = _InMemoryCartRepository();
    final container = _container(repository);
    addTearDown(container.dispose);
    await container.read(cartProvider.future);
    final notifier = container.read(cartProvider.notifier);
    await notifier.addItem(buildCartItem());

    await expectLater(
      notifier.addItem(
        buildCartItem(menuItemId: 302, restaurantId: 202),
      ),
      throwsA(isA<ValidationFailure>()),
    );
    expect(container.read(cartProvider).value?.items.single.menuItemId, 301);

    repository.nextFailure = const CacheFailure('Không ghi được giỏ hàng');
    await expectLater(
      notifier.updateItemQuantity(301, 2),
      throwsA(isA<CacheFailure>()),
    );
    expect(container.read(cartProvider).value?.items.single.quantity, 1);

    await notifier.updateItemQuantity(301, 2);
    expect(container.read(cartProvider).value?.items.single.quantity, 2);
  });
}

ProviderContainer _container(_InMemoryCartRepository repository) {
  return ProviderContainer(
    overrides: [cartRepositoryProvider.overrideWithValue(repository)],
  );
}

class _InMemoryCartRepository implements CartRepository {
  CartEntity cart = const CartEntity(
    items: [],
    currentRestaurantId: null,
    currentRestaurantName: null,
  );
  Failure? nextFailure;

  Either<Failure, T>? _takeFailure<T>() {
    final failure = nextFailure;
    nextFailure = null;
    return failure == null ? null : Left(failure);
  }

  @override
  Future<Either<Failure, CartEntity>> getCart() async => Right(cart);

  @override
  Future<Either<Failure, CartEntity>> addItem(CartItemEntity item) async {
    final failure = _takeFailure<CartEntity>();
    if (failure != null) return failure;
    if (!cart.canAddFromRestaurant(item.restaurantId)) {
      return const Left(ValidationFailure('Khác nhà hàng'));
    }
    final existingIndex = cart.items.indexWhere(
      (current) => current.menuItemId == item.menuItemId,
    );
    final items = [...cart.items];
    if (existingIndex >= 0) {
      final existing = items[existingIndex];
      items[existingIndex] = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      );
    } else {
      items.add(item);
    }
    cart = buildCart(items: items);
    return Right(cart);
  }

  @override
  Future<Either<Failure, CartEntity>> updateItemQuantity(
    num menuItemId,
    int quantity,
  ) async {
    final failure = _takeFailure<CartEntity>();
    if (failure != null) return failure;
    cart = buildCart(
      items: cart.items
          .map(
            (item) => item.menuItemId == menuItemId
                ? item.copyWith(quantity: quantity)
                : item,
          )
          .toList(),
    );
    return Right(cart);
  }

  @override
  Future<Either<Failure, CartEntity>> removeItem(num menuItemId) async {
    final failure = _takeFailure<CartEntity>();
    if (failure != null) return failure;
    cart = buildCart(
      items: cart.items.where((item) => item.menuItemId != menuItemId).toList(),
    );
    return Right(cart);
  }

  @override
  Future<Either<Failure, Unit>> clearCart() async {
    final failure = _takeFailure<Unit>();
    if (failure != null) return failure;
    cart = buildCart(items: []);
    return const Right(unit);
  }

  @override
  Future<Either<Failure, CartEntity>> updateItemNotes(
    num menuItemId,
    String? notes,
  ) async {
    final failure = _takeFailure<CartEntity>();
    if (failure != null) return failure;
    cart = buildCart(
      items: cart.items
          .map(
            (item) => item.menuItemId == menuItemId
                ? item.copyWith(notes: notes)
                : item,
          )
          .toList(),
    );
    return Right(cart);
  }

  @override
  Future<Either<Failure, bool>> canAddFromRestaurant(
    num restaurantId,
  ) async => Right(cart.canAddFromRestaurant(restaurantId));
}
