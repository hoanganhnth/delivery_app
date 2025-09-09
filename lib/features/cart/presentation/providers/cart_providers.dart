import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/cart_usecases.dart';
import '../../data/datasources/cart_local_datasource_impl.dart';
import '../../data/repositories_impl/cart_repository_impl.dart';
import 'cart_notifier.dart';
import 'cart_state.dart';

// ================================
// DATA LAYER PROVIDERS
// ================================

/// Data source provider
final cartLocalDataSourceProvider = Provider<CartLocalDataSourceImpl>((ref) {
  return CartLocalDataSourceImpl();
});

/// Repository provider
final cartRepositoryProvider = Provider<CartRepositoryImpl>((ref) {
  final localDataSource = ref.watch(cartLocalDataSourceProvider);
  return CartRepositoryImpl(localDataSource);
});

// ================================
// USE CASE PROVIDERS
// ================================

/// Get cart use case provider
final getCartUseCaseProvider = Provider<GetCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return GetCartUseCase(repository);
});

/// Add to cart use case provider
final addToCartUseCaseProvider = Provider<AddToCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return AddToCartUseCase(repository);
});

/// Update cart item quantity use case provider
final updateCartItemQuantityUseCaseProvider =
    Provider<UpdateCartItemQuantityUseCase>((ref) {
      final repository = ref.watch(cartRepositoryProvider);
      return UpdateCartItemQuantityUseCase(repository);
    });

/// Remove from cart use case provider
final removeFromCartUseCaseProvider = Provider<RemoveFromCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return RemoveFromCartUseCase(repository);
});

/// Clear cart use case provider
final clearCartUseCaseProvider = Provider<ClearCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return ClearCartUseCase(repository);
});

/// Update cart item notes use case provider
final updateCartItemNotesUseCaseProvider = Provider<UpdateCartItemNotesUseCase>(
  (ref) {
    final repository = ref.watch(cartRepositoryProvider);
    return UpdateCartItemNotesUseCase(repository);
  },
);

// ================================
// MAIN CART PROVIDER
// ================================

/// Main cart notifier provider
final cartNotifierProvider = StateNotifierProvider<CartNotifier, CartState>((
  ref,
) {
  return CartNotifier(
    getCartUseCase: ref.watch(getCartUseCaseProvider),
    addToCartUseCase: ref.watch(addToCartUseCaseProvider),
    updateQuantityUseCase: ref.watch(updateCartItemQuantityUseCaseProvider),
    removeFromCartUseCase: ref.watch(removeFromCartUseCaseProvider),
    clearCartUseCase: ref.watch(clearCartUseCaseProvider),
    updateNotesUseCase: ref.watch(updateCartItemNotesUseCaseProvider),
  );
});

// ================================
// HELPER PROVIDERS
// ================================

/// Get total items count in cart
final cartItemsCountProvider = Provider<int>((ref) {
  return ref.watch(cartNotifierProvider).totalItems;
});

/// Get total amount in cart
final cartTotalAmountProvider = Provider<double>((ref) {
  return ref.watch(cartNotifierProvider).totalAmount;
});

/// Check if cart is empty
final isCartEmptyProvider = Provider<bool>((ref) {
  return ref.watch(cartNotifierProvider).isEmpty;
});

/// Get current restaurant ID
final currentRestaurantIdProvider = Provider<num?>((ref) {
  return ref.watch(cartNotifierProvider).currentRestaurantId;
});

/// Get quantity of specific menu item in cart
final menuItemQuantityProvider = Provider.family<int, num>((ref, menuItemId) {
  final state = ref.watch(cartNotifierProvider);
  return state.cart.getItemQuantity(menuItemId);
});

/// Check if can add from restaurant
final canAddFromRestaurantProvider = Provider.family<bool, num>((
  ref,
  restaurantId,
) {
  return ref
      .watch(cartNotifierProvider)
      .cart
      .canAddFromRestaurant(restaurantId);
});
