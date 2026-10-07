import 'dart:io';

import 'package:delivery_app/core/error/exceptions.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/cart/data/adapters/cart_dto_adapter.dart';
import 'package:delivery_app/features/cart/data/adapters/cart_item_dto_adapter.dart';
import 'package:delivery_app/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:delivery_app/features/cart/data/datasources/cart_local_datasource_impl.dart';
import 'package:delivery_app/features/cart/data/dtos/cart_dto.dart';
import 'package:delivery_app/features/cart/data/dtos/cart_item_dto.dart';
import 'package:delivery_app/features/cart/data/repositories_impl/cart_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

import '../../../support/fulfilment_builders.dart';

const item = CartItemDto(
  menuItemId: 301,
  menuItemName: 'Rice',
  price: 50000,
  quantity: 1,
  restaurantId: 201,
  restaurantName: 'Kitchen',
  imageUrl: 'image',
  notes: 'warm',
  flashSaleItemId: 88,
);
T value<T>(Either<Exception, T> result) => result.getOrElse((e) => throw e);

void main() {
  late Directory directory;
  late CartLocalDataSourceImpl source;
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('cart-coverage');
    Hive.init(directory.path);
    if (!Hive.isAdapterRegistered(CartDtoAdapter().typeId)) {
      Hive.registerAdapter(CartDtoAdapter());
      Hive.registerAdapter(CartItemDtoAdapter());
    }
    source = CartLocalDataSourceImpl();
  });
  tearDown(() async {
    await Hive.close();
    await directory.delete(recursive: true);
  });

  test('Hive persists all fields and mutations survive reopening', () async {
    expect(value(await source.getCart()).items, isEmpty);
    expect(
      value(await source.addItem(item, livestreamId: 'live')).livestreamId,
      'live',
    );
    expect(
      value(
        await source.addItem(item, livestreamId: 'live'),
      ).items.single.quantity,
      2,
    );
    await source.addItem(item.copyWith(menuItemId: 302));
    final quantity = value(await source.updateItemQuantity(301, 4));
    expect(quantity.items.map((i) => i.quantity), [4, 1]);
    final notes = value(await source.updateItemNotes(301, 'hot'));
    expect(notes.items.map((i) => i.notes), ['hot', 'warm']);
    expect(value(await source.removeItem(302)).currentRestaurantId, 201);
    await Hive.close();
    final restored = value(await source.getCart());
    expect(restored.items.single, item.copyWith(quantity: 4, notes: 'hot'));
    expect(value(await source.saveCart(restored)), unit);
    final empty = value(await source.removeItem(301));
    expect(empty.items, isEmpty);
    expect(empty.currentRestaurantId, isNull);
    expect(empty.currentRestaurantName, isNull);
    expect(empty.livestreamId, isNull);
    await source.addItem(item);
    expect(value(await source.clearCart()), unit);
    expect(value(await source.getCart()).items, isEmpty);
  });

  test('JSON round trip preserves cart and promotion identity', () {
    const cart = CartDto(
      items: [item],
      currentRestaurantId: 201,
      currentRestaurantName: 'Kitchen',
      livestreamId: 'live',
    );
    final json = cart.toJson();
    json['items'] = [item.toJson()];
    expect(CartDto.fromJson(json), cart);
    expect(CartItemDto.fromJson(item.toJson()), item);
    expect(CartDtoAdapter(), CartDtoAdapter());
    expect(CartDtoAdapter().hashCode, CartDtoAdapter().typeId.hashCode);
    expect(CartItemDtoAdapter(), CartItemDtoAdapter());
    expect(CartItemDtoAdapter().hashCode, CartItemDtoAdapter().typeId.hashCode);
    expect((CartDtoAdapter() as Object) == CartItemDtoAdapter(), isFalse);
  });

  test(
    'repository forwards storage operations and maps every item field',
    () async {
      final repository = CartRepositoryImpl(source);
      expect((await repository.getCart()).isRight(), isTrue);
      final added = (await repository.addItem(
        buildCartItem(),
      )).getOrElse((e) => throw e);
      expect(added.items.single.menuItemId, 301);
      expect(
        (await repository.canAddFromRestaurant(201)).getOrElse((e) => throw e),
        isTrue,
      );
      expect(
        (await repository.canAddFromRestaurant(202)).getOrElse((e) => throw e),
        isFalse,
      );
      expect(
        (await repository.updateItemQuantity(
          301,
          3,
        )).getOrElse((e) => throw e).items.single.quantity,
        3,
      );
      expect(
        (await repository.updateItemNotes(
          301,
          'hot',
        )).getOrElse((e) => throw e).items.single.notes,
        'hot',
      );
      expect(
        (await repository.removeItem(301)).getOrElse((e) => throw e).items,
        isEmpty,
      );
      expect((await repository.clearCart()).isRight(), isTrue);
      final entity = item.toEntity();
      expect(entity.imageUrl, 'image');
      expect(entity.notes, 'warm');
      expect(entity.flashSaleItemId, 88);
      expect(entity.price, 50000);
    },
  );

  for (final throws in [false, true]) {
    test(
      'repository maps ${throws ? 'thrown' : 'returned'} storage failures',
      () async {
        final repository = CartRepositoryImpl(_FailedSource(throws));
        final results = [
          await repository.getCart(),
          await repository.addItem(buildCartItem()),
          await repository.updateItemQuantity(301, 2),
          await repository.removeItem(301),
          await repository.clearCart(),
          await repository.updateItemNotes(301, null),
          await repository.canAddFromRestaurant(201),
        ];
        for (final result in results) {
          expect(
            result.fold((e) => e, (_) => null),
            throws ? isA<ServerFailure>() : isA<UnexpectedFailure>(),
          );
        }
      },
    );
  }
}

class _FailedSource implements CartLocalDataSource {
  _FailedSource(this.throws);
  final bool throws;
  Future<Either<Exception, T>> fail<T>() async {
    if (throws) throw StateError('storage unavailable');
    return Left(CacheException('storage unavailable'));
  }

  @override
  Future<Either<Exception, CartDto>> getCart() => fail();
  @override
  Future<Either<Exception, CartDto>> addItem(
    CartItemDto item, {
    String? livestreamId,
  }) => fail();
  @override
  Future<Either<Exception, CartDto>> removeItem(num menuItemId) => fail();
  @override
  Future<Either<Exception, CartDto>> updateItemQuantity(
    num menuItemId,
    int quantity,
  ) => fail();
  @override
  Future<Either<Exception, CartDto>> updateItemNotes(
    num menuItemId,
    String? notes,
  ) => fail();
  @override
  Future<Either<Exception, Unit>> clearCart() => fail();
  @override
  Future<Either<Exception, Unit>> saveCart(CartDto cart) => fail();
}
