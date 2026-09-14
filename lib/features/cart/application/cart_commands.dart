import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';

/// Write-side boundary used by other bounded contexts.
///
/// Catalog/restaurant UI must request cart changes through this port instead of
/// reaching into CartNotifier. Cart remains the sole owner of persistence and
/// restaurant-consistency invariants.
abstract interface class CartCommands {
  Future<void> addItem(CartItemEntity item, {String? livestreamId});
  Future<void> updateItemQuantity(num menuItemId, int quantity);
  Future<void> removeItem(num menuItemId);
  Future<void> clearCart();
}
