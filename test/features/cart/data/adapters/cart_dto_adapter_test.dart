import 'package:delivery_app/features/cart/data/adapters/cart_dto_adapter.dart';
import 'package:delivery_app/features/cart/data/dtos/cart_item_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  test('reads legacy three-field carts without a livestream identity', () {
    final reader = _Reader(
      bytes: [3, 0, 1, 2],
      values: [const <CartItemDto>[], 201, 'Bếp test'],
    );

    final cart = CartDtoAdapter().read(reader);

    expect(cart.currentRestaurantId, 201);
    expect(cart.currentRestaurantName, 'Bếp test');
    expect(cart.livestreamId, isNull);
  });

  test('reads the additive livestream Hive field', () {
    const livestreamId = '00000000-0000-4000-8000-000000000001';
    final reader = _Reader(
      bytes: [4, 0, 1, 2, 3],
      values: [const <CartItemDto>[], 201, 'Bếp test', livestreamId],
    );

    final cart = CartDtoAdapter().read(reader);

    expect(cart.livestreamId, livestreamId);
  });
}

final class _Reader implements BinaryReader {
  _Reader({required List<int> bytes, required List<Object?> values})
    : _bytes = List.of(bytes),
      _values = List.of(values);

  final List<int> _bytes;
  final List<Object?> _values;

  @override
  int readByte() => _bytes.removeAt(0);

  @override
  dynamic read([int? typeId]) => _values.removeAt(0);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
