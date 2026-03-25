import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecases/cart_usecases.dart';
import 'cart_providers.dart';
import 'cart_state.dart';

part 'cart_notifier.g.dart';

/// Cart notifier for state management
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  CartState build() {
    Future.microtask(() => loadCart());
    return const CartState.initial();
  }

  /// Load cart from storage
  Future<void> loadCart() async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final getCartUseCase = ref.read(getCartUseCaseProvider);
    final result = await getCartUseCase(NoParams());

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

    final addToCartUseCase = ref.read(addToCartUseCaseProvider);
    final result = await addToCartUseCase(AddToCartParams(item: item));

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

    final updateQuantityUseCase = ref.read(updateCartItemQuantityUseCaseProvider);
    final result = await updateQuantityUseCase(
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

    final removeFromCartUseCase = ref.read(removeFromCartUseCaseProvider);
    final result = await removeFromCartUseCase(
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

    final clearCartUseCase = ref.read(clearCartUseCaseProvider);
    final result = await clearCartUseCase(NoParams());

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

    final updateNotesUseCase = ref.read(updateCartItemNotesUseCaseProvider);
    final result = await updateNotesUseCase(
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
