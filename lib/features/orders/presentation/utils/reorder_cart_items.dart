import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';

List<CartItemEntity> buildReorderCartItems(OrderEntity order) {
  final restaurantId = order.restaurantId;
  final restaurantName = order.restaurantName?.trim();

  if (restaurantId == null || restaurantId <= 0) {
    throw const FormatException('Restaurant id must be positive');
  }
  if (restaurantName == null || restaurantName.isEmpty) {
    throw const FormatException('Restaurant name is required');
  }
  if (order.items.isEmpty) {
    throw const FormatException('Order must contain at least one item');
  }

  return order.items
      .map((item) {
        final menuItemName = item.menuItemName.trim();
        if (item.menuItemId <= 0 ||
            menuItemName.isEmpty ||
            !item.price.isFinite ||
            item.price <= 0 ||
            item.quantity <= 0) {
          throw const FormatException('Order contains an invalid menu item');
        }

        return CartItemEntity(
          menuItemId: item.menuItemId,
          menuItemName: menuItemName,
          price: item.price,
          quantity: item.quantity,
          restaurantId: restaurantId,
          restaurantName: restaurantName,
          notes: item.notes,
        );
      })
      .toList(growable: false);
}
