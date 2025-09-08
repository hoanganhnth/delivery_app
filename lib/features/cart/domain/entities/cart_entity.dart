import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item_entity.dart';

part 'cart_entity.freezed.dart';

/// Cart entity representing the entire shopping cart
@freezed
abstract class CartEntity with _$CartEntity {
  const factory CartEntity({
    required List<CartItemEntity> items,
    required num? currentRestaurantId,
    required String? currentRestaurantName,
  }) = _CartEntity;

  const CartEntity._();

  /// Calculate total amount of all items in cart
  double get totalAmount =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  /// Get total number of items in cart
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  /// Check if cart is empty
  bool get isEmpty => items.isEmpty;

  /// Check if cart is not empty
  bool get isNotEmpty => items.isNotEmpty;

  /// Check if cart can add items from a specific restaurant
  bool canAddFromRestaurant(num restaurantId) {
    return isEmpty || currentRestaurantId == restaurantId;
  }

  /// Get quantity of specific menu item in cart
  int getItemQuantity(num menuItemId) {
    try {
      final item = items.firstWhere((item) => item.menuItemId == menuItemId);
      return item.quantity;
    } catch (e) {
      return 0;
    }
  }

  /// Get cart item by menu item id
  CartItemEntity? getCartItem(num menuItemId) {
    try {
      return items.firstWhere((item) => item.menuItemId == menuItemId);
    } catch (e) {
      return null;
    }
  }
}
