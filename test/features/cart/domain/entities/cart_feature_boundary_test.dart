import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('cart and restaurant domain entities do not import each other', () {
    final cartEntity = File(
      'lib/features/cart/domain/entities/cart_item_entity.dart',
    ).readAsStringSync();
    final menuEntity = File(
      'lib/features/restaurants/domain/entities/menu_item_entity.dart',
    ).readAsStringSync();

    expect(
      cartEntity,
      isNot(contains('restaurants/domain/entities/menu_item_entity.dart')),
    );
    expect(
      menuEntity,
      isNot(contains('cart/domain/entities/cart_item_entity.dart')),
    );
  });
}
