import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/cart_usecases.dart';
import 'cart_state.dart';

/// Cart notifier for state management
class CartNotifier extends StateNotifier<CartState> {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartItemQuantityUseCase _updateQuantityUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final UpdateCartItemNotesUseCase _updateNotesUseCase;

  CartNotifier({
    required GetCartUseCase getCartUseCase,
    required AddToCartUseCase addToCartUseCase,
    required UpdateCartItemQuantityUseCase updateQuantityUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required ClearCartUseCase clearCartUseCase,
    required UpdateCartItemNotesUseCase updateNotesUseCase,
  })  : _getCartUseCase = getCartUseCase,
        _addToCartUseCase = addToCartUseCase,
        _updateQuantityUseCase = updateQuantityUseCase,
        _removeFromCartUseCase = removeFromCartUseCase,
        _clearCartUseCase = clearCartUseCase,
        _updateNotesUseCase = updateNotesUseCase,
        super(const CartState.initial()) {
    loadCart();
  }

  /// Load cart from storage
  Future<void> loadCart() async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _getCartUseCase(NoParams());

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (cart) => state = state.copyWith(
        isLoading: false,
        cart: cart,
      ),
    );
  }

  /// Add item to cart
  Future<void> addItem(CartItemEntity item) async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _addToCartUseCase(AddToCartParams(item: item));

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (cart) => state = state.copyWith(
        isLoading: false,
        cart: cart,
      ),
    );
  }

  /// Update item quantity
  Future<void> updateItemQuantity(num menuItemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(menuItemId);
      return;
    }

    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _updateQuantityUseCase(
      UpdateCartItemQuantityParams(menuItemId: menuItemId, quantity: quantity),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (cart) => state = state.copyWith(
        isLoading: false,
        cart: cart,
      ),
    );
  }

  /// Remove item from cart
  Future<void> removeItem(num menuItemId) async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _removeFromCartUseCase(
      RemoveFromCartParams(menuItemId: menuItemId),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (cart) => state = state.copyWith(
        isLoading: false,
        cart: cart,
      ),
    );
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _clearCartUseCase(NoParams());

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (_) => state = state.copyWith(
        isLoading: false,
        cart: const CartEntity(
          items: [],
          currentRestaurantId: null,
          currentRestaurantName: null,
        ),
      ),
    );
  }

  /// Update item notes
  Future<void> updateItemNotes(num menuItemId, String? notes) async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final result = await _updateNotesUseCase(
      UpdateCartItemNotesParams(menuItemId: menuItemId, notes: notes),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (cart) => state = state.copyWith(
        isLoading: false,
        cart: cart,
      ),
    );
  }

  /// Get quantity of specific menu item
  int getItemQuantity(num menuItemId) {
    return state.cart.getItemQuantity(menuItemId);
  }

  /// Check if can add from restaurant
  bool canAddFromRestaurant(num restaurantId) {
    return state.cart.canAddFromRestaurant(restaurantId);
  }
}
