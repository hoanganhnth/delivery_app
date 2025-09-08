import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../dtos/cart_dto.dart';
import '../dtos/cart_item_dto.dart';
import 'cart_local_datasource.dart';

/// Implementation of CartLocalDataSource using Hive
class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const String _cartBoxName = 'cart_box';
  static const String _cartKey = 'current_cart';

  Box<CartDto>? _cartBox;

  /// Initialize Hive and register adapters if needed
  static Future<void> initialize() async {
    // Adapters will be registered by build_runner generated code
    await Hive.initFlutter();
  }

  /// Get or open the cart box
  Future<Box<CartDto>> _getCartBox() async {
    if (_cartBox == null || !_cartBox!.isOpen) {
      _cartBox = await Hive.openBox<CartDto>(_cartBoxName);
    }
    return _cartBox!;
  }

  @override
  Future<Either<Exception, CartDto>> getCart() async {
    try {
      final cartBox = await _getCartBox();
      final cart = cartBox.get(_cartKey);

      if (cart != null) {
        return right(cart);
      } else {
        // Return empty cart if none exists
        return right(const CartDto(
          items: [],
          currentRestaurantId: null,
          currentRestaurantName: null,
        ));
      }
    } catch (e) {
      return left(CacheException('Failed to get cart from local storage'));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveCart(CartDto cart) async {
    try {
      final cartBox = await _getCartBox();
      await cartBox.put(_cartKey, cart);
      return right(unit);
    } catch (e) {
      return left(CacheException('Failed to save cart to local storage'));
    }
  }

  @override
  Future<Either<Exception, Unit>> clearCart() async {
    try {
      final cartBox = await _getCartBox();
      await cartBox.delete(_cartKey);
      return right(unit);
    } catch (e) {
      return left(CacheException('Failed to clear cart from local storage'));
    }
  }

  @override
  Future<Either<Exception, CartDto>> addItem(CartItemDto item) async {
    try {
      final getCartResult = await getCart();

      return await getCartResult.fold(
        (exception) async => left(exception),
        (currentCart) async {
          // Check if item already exists
          final existingIndex = currentCart.items.indexWhere(
            (cartItem) => cartItem.menuItemId == item.menuItemId,
          );

          List<CartItemDto> updatedItems;

          if (existingIndex >= 0) {
            // Update existing item quantity
            updatedItems = List.from(currentCart.items);
            final existingItem = updatedItems[existingIndex];
            updatedItems[existingIndex] = existingItem.copyWith(
              quantity: existingItem.quantity + item.quantity,
            );
          } else {
            // Add new item
            updatedItems = [...currentCart.items, item];
          }

          final updatedCart = currentCart.copyWith(
            items: updatedItems,
            currentRestaurantId: item.restaurantId,
            currentRestaurantName: item.restaurantName,
          );

          // Save updated cart
          final cartBox = await _getCartBox();
          await cartBox.put(_cartKey, updatedCart);

          return right(updatedCart);
        },
      );
    } catch (e) {
      return left(CacheException('Failed to add item to cart'));
    }
  }

  @override
  Future<Either<Exception, CartDto>> updateItemQuantity(num menuItemId, int quantity) async {
    try {
      final getCartResult = await getCart();

      return await getCartResult.fold(
        (exception) async => left(exception),
        (currentCart) async {
          final updatedItems = currentCart.items.map((item) {
            if (item.menuItemId == menuItemId) {
              return item.copyWith(quantity: quantity);
            }
            return item;
          }).toList();

          final updatedCart = currentCart.copyWith(items: updatedItems);

          // Save updated cart
          final cartBox = await _getCartBox();
          await cartBox.put(_cartKey, updatedCart);

          return right(updatedCart);
        },
      );
    } catch (e) {
      return left(CacheException('Failed to update item quantity'));
    }
  }

  @override
  Future<Either<Exception, CartDto>> removeItem(num menuItemId) async {
    try {
      final getCartResult = await getCart();

      return await getCartResult.fold(
        (exception) async => left(exception),
        (currentCart) async {
          final updatedItems = currentCart.items
              .where((item) => item.menuItemId != menuItemId)
              .toList();

          final updatedCart = currentCart.copyWith(
            items: updatedItems,
            currentRestaurantId: updatedItems.isEmpty ? null : currentCart.currentRestaurantId,
            currentRestaurantName: updatedItems.isEmpty ? null : currentCart.currentRestaurantName,
          );

          // Save updated cart
          final cartBox = await _getCartBox();
          await cartBox.put(_cartKey, updatedCart);

          return right(updatedCart);
        },
      );
    } catch (e) {
      return left(CacheException('Failed to remove item from cart'));
    }
  }

  @override
  Future<Either<Exception, CartDto>> updateItemNotes(num menuItemId, String? notes) async {
    try {
      final getCartResult = await getCart();

      return await getCartResult.fold(
        (exception) async => left(exception),
        (currentCart) async {
          final updatedItems = currentCart.items.map((item) {
            if (item.menuItemId == menuItemId) {
              return item.copyWith(notes: notes);
            }
            return item;
          }).toList();

          final updatedCart = currentCart.copyWith(items: updatedItems);

          // Save updated cart
          final cartBox = await _getCartBox();
          await cartBox.put(_cartKey, updatedCart);

          return right(updatedCart);
        },
      );
    } catch (e) {
      return left(CacheException('Failed to update item notes'));
    }
  }
}
