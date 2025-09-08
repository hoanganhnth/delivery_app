import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../restaurants/domain/entities/menu_item_entity.dart';

part 'cart_item_entity.freezed.dart';

/// Cart item entity representing an item in the shopping cart
@freezed
abstract class CartItemEntity with _$CartItemEntity {
  const factory CartItemEntity({
    required num menuItemId,
    required String menuItemName,
    required double price,
    required int quantity,
    required num restaurantId,
    required String restaurantName,
    String? imageUrl,
    String? notes,
  }) = _CartItemEntity;

  const CartItemEntity._();

  /// Factory method to create CartItem from MenuItem
  factory CartItemEntity.fromMenuItem(
    MenuItemEntity menuItem,
    String restaurantName, {
    int quantity = 1,
    String? notes,
  }) {
    return CartItemEntity(
      menuItemId: menuItem.id ?? 0,
      menuItemName: menuItem.name,
      price: menuItem.price,
      quantity: quantity,
      restaurantId: menuItem.restaurantId ?? 0,
      restaurantName: restaurantName,
      imageUrl: menuItem.image,
      notes: notes,
    );
  }

  /// Calculate total price for this cart item
  double get totalPrice => price * quantity;

  /// Create a copy with updated quantity
  CartItemEntity copyWithQuantity(int newQuantity) {
    return copyWith(quantity: newQuantity);
  }

  /// Create a copy with updated notes
  CartItemEntity copyWithNotes(String? newNotes) {
    return copyWith(notes: newNotes);
  }

  /// Check if this cart item matches a menu item
  bool matchesMenuItem(MenuItemEntity menuItem) {
    return menuItemId == menuItem.id &&
           menuItemName == menuItem.name &&
           price == menuItem.price &&
           restaurantId == menuItem.restaurantId;
  }

  /// Update cart item with latest menu item data (for price changes, etc.)
  CartItemEntity updateFromMenuItem(MenuItemEntity menuItem) {
    if (!matchesMenuItem(menuItem)) {
      throw ArgumentError('MenuItem does not match this CartItem');
    }

    return copyWith(
      menuItemName: menuItem.name,
      price: menuItem.price,
      imageUrl: menuItem.image,
    );
  }
}
