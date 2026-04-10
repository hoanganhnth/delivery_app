import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/usecases/cart_usecases.dart';
import '../di/cart_di_providers.dart';

part 'cart_notifier.g.dart';

/// Cart notifier for state management using AsyncNotifier
/// Returns CartEntity directly, AsyncValue handles loading/error states
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<CartEntity> build() async {
    // Load cart from storage on initialization
    final getCartUseCase = ref.read(getCartUseCaseProvider);
    final result = await getCartUseCase(NoParams());

    return result.fold(
      (failure) {
        // On failure, return empty cart
        // AsyncValue will handle the error state
        return const CartEntity(
          items: [],
          currentRestaurantId: null,
          currentRestaurantName: null,
        );
      },
      (cart) => cart,
    );
  }

  /// Add item to cart
  Future<void> addItem(CartItemEntity item) async {
    final addToCartUseCase = ref.read(addToCartUseCaseProvider);
    final result = await addToCartUseCase(AddToCartParams(item: item));

    result.fold(
      (failure) => throw failure,
      (cart) => state = AsyncValue.data(cart),
    );
  }

  /// Update item quantity
  Future<void> updateItemQuantity(num menuItemId, int quantity) async {
    if (quantity <= 0) {
      await removeItem(menuItemId);
      return;
    }

    final updateQuantityUseCase = ref.read(updateCartItemQuantityUseCaseProvider);
    final result = await updateQuantityUseCase(
      UpdateCartItemQuantityParams(menuItemId: menuItemId, quantity: quantity),
    );

    result.fold(
      (failure) => throw failure,
      (cart) => state = AsyncValue.data(cart),
    );
  }

  /// Remove item from cart
  Future<void> removeItem(num menuItemId) async {
    final removeFromCartUseCase = ref.read(removeFromCartUseCaseProvider);
    final result = await removeFromCartUseCase(
      RemoveFromCartParams(menuItemId: menuItemId),
    );

    result.fold(
      (failure) => throw failure,
      (cart) => state = AsyncValue.data(cart),
    );
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    final clearCartUseCase = ref.read(clearCartUseCaseProvider);
    final result = await clearCartUseCase(NoParams());

    result.fold(
      (failure) => throw failure,
      (_) => state = const AsyncValue.data(CartEntity(
        items: [],
        currentRestaurantId: null,
        currentRestaurantName: null,
      )),
    );
  }

  /// Update item notes
  Future<void> updateItemNotes(num menuItemId, String? notes) async {
    final updateNotesUseCase = ref.read(updateCartItemNotesUseCaseProvider);
    final result = await updateNotesUseCase(
      UpdateCartItemNotesParams(menuItemId: menuItemId, notes: notes),
    );

    result.fold(
      (failure) => throw failure,
      (cart) => state = AsyncValue.data(cart),
    );
  }

  /// Get quantity of specific menu item
  int getItemQuantity(num menuItemId) {
    return state.value?.getItemQuantity(menuItemId) ?? 0;
  }

  /// Check if can add from restaurant
  bool canAddFromRestaurant(num restaurantId) {
    return state.value?.canAddFromRestaurant(restaurantId) ?? true;
  }
}
