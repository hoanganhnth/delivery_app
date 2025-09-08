import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_entity.dart';
import '../entities/cart_item_entity.dart';

/// Repository interface for cart operations
abstract class CartRepository {
  /// Get current cart
  Future<Either<Failure, CartEntity>> getCart();

  /// Add item to cart
  Future<Either<Failure, CartEntity>> addItem(CartItemEntity item);

  /// Update item quantity in cart
  Future<Either<Failure, CartEntity>> updateItemQuantity(num menuItemId, int quantity);

  /// Remove item from cart
  Future<Either<Failure, CartEntity>> removeItem(num menuItemId);

  /// Clear entire cart
  Future<Either<Failure, Unit>> clearCart();

  /// Update item notes
  Future<Either<Failure, CartEntity>> updateItemNotes(num menuItemId, String? notes);

  /// Check if cart can add items from restaurant
  Future<Either<Failure, bool>> canAddFromRestaurant(num restaurantId);
}
