import 'package:fpdart/fpdart.dart';
import '../dtos/cart_dto.dart';
import '../dtos/cart_item_dto.dart';

/// Local datasource interface for cart operations
abstract class CartLocalDataSource {
  /// Get current cart from local storage
  Future<Either<Exception, CartDto>> getCart();

  /// Save cart to local storage
  Future<Either<Exception, Unit>> saveCart(CartDto cart);

  /// Clear cart from local storage
  Future<Either<Exception, Unit>> clearCart();

  /// Add item to cart in local storage
  Future<Either<Exception, CartDto>> addItem(CartItemDto item);

  /// Update item quantity in local storage
  Future<Either<Exception, CartDto>> updateItemQuantity(num menuItemId, int quantity);

  /// Remove item from local storage
  Future<Either<Exception, CartDto>> removeItem(num menuItemId);

  /// Update item notes in local storage
  Future<Either<Exception, CartDto>> updateItemNotes(num menuItemId, String? notes);
}
