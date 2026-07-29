import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/order_item_entity.dart';
import 'package:delivery_app/features/orders/presentation/utils/reorder_cart_items.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  OrderEntity order({
    int? restaurantId = 7,
    String? restaurantName = 'Quán thật',
    int menuItemId = 11,
    String menuItemName = 'Cơm gà',
    double price = 45000,
    int quantity = 2,
  }) {
    return OrderEntity(
      id: 1,
      status: OrderStatus.delivered,
      customerName: 'Customer',
      customerPhone: '0900000000',
      deliveryAddress: 'Address',
      paymentMethod: PaymentMethod.cod,
      totalAmount: 90000,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      items: [
        OrderItemEntity(
          menuItemId: menuItemId,
          menuItemName: menuItemName,
          quantity: quantity,
          price: price,
        ),
      ],
    );
  }

  test('builds cart items only from canonical order identity', () {
    final items = buildReorderCartItems(order());

    expect(items, hasLength(1));
    expect(items.single.restaurantId, 7);
    expect(items.single.restaurantName, 'Quán thật');
    expect(items.single.menuItemId, 11);
  });

  test('rejects missing restaurant identity before cart mutation', () {
    expect(
      () => buildReorderCartItems(order(restaurantId: null)),
      throwsFormatException,
    );
    expect(
      () => buildReorderCartItems(order(restaurantName: ' ')),
      throwsFormatException,
    );
  });

  test('rejects malformed menu item identity and commercial values', () {
    expect(
      () => buildReorderCartItems(order(menuItemId: 0)),
      throwsFormatException,
    );
    expect(() => buildReorderCartItems(order(price: 0)), throwsFormatException);
    expect(
      () => buildReorderCartItems(order(quantity: 0)),
      throwsFormatException,
    );
  });
}
