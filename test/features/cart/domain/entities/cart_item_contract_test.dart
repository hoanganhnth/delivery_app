import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validItem = MenuItemEntity(
    id: 7,
    restaurantId: 3,
    name: 'Cơm gà',
    description: '',
    price: 50000,
    status: MenuItemStatus.available,
  );

  test('cart item preserves canonical menu and restaurant identity', () {
    final item = CartItemEntity.fromMenuItem(validItem, 'Nhà hàng');
    expect(item.menuItemId, 7);
    expect(item.restaurantId, 3);
    expect(item.price, 50000);
  });

  test('cart item rejects missing IDs instead of fabricating zero', () {
    const invalidItem = MenuItemEntity(
      name: 'Không rõ nguồn',
      description: '',
      price: 50000,
      status: MenuItemStatus.available,
    );

    expect(
      () => CartItemEntity.fromMenuItem(invalidItem, 'Nhà hàng'),
      throwsArgumentError,
    );
  });
}
