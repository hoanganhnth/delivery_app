import 'package:freezed_annotation/freezed_annotation.dart';

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
}
