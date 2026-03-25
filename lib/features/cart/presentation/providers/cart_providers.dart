import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/cart_local_datasource.dart';
import '../../data/datasources/cart_local_datasource_impl.dart';
import '../../data/repositories_impl/cart_repository_impl.dart';
import '../../domain/usecases/cart_usecases.dart';
import 'cart_notifier.dart';

part 'cart_providers.g.dart';

// ================================
// DATA LAYER PROVIDERS
// ================================

/// Data source provider
@Riverpod(keepAlive: true)
CartLocalDataSource cartLocalDataSource(Ref ref) {
  return CartLocalDataSourceImpl();
}

/// Repository provider
@riverpod
CartRepositoryImpl cartRepository(Ref ref) {
  final localDataSource = ref.watch(cartLocalDataSourceProvider);
  return CartRepositoryImpl(localDataSource);
}

// ================================
// USE CASE PROVIDERS
// ================================

/// Get cart use case provider
@riverpod
GetCartUseCase getCartUseCase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return GetCartUseCase(repository);
}

/// Add to cart use case provider
@riverpod
AddToCartUseCase addToCartUseCase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return AddToCartUseCase(repository);
}

/// Update cart item quantity use case provider
@riverpod
UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return UpdateCartItemQuantityUseCase(repository);
}

/// Remove from cart use case provider
@riverpod
RemoveFromCartUseCase removeFromCartUseCase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return RemoveFromCartUseCase(repository);
}

/// Clear cart use case provider
@riverpod
ClearCartUseCase clearCartUseCase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return ClearCartUseCase(repository);
}

/// Update cart item notes use case provider
@riverpod
UpdateCartItemNotesUseCase updateCartItemNotesUseCase(Ref ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return UpdateCartItemNotesUseCase(repository);
}

// ================================
// CONVENIENCE PROVIDERS
// ================================

/// Cart items count provider
final cartItemsCountProvider = Provider<int>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.totalItems;
});

/// Cart total amount provider
final cartTotalAmountProvider = Provider<double>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.totalAmount;
});

/// Is cart empty provider
final isCartEmptyProvider = Provider<bool>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.isEmpty;
});

/// Menu item quantity in cart provider
final menuItemQuantityProvider = Provider.family<int, num>((ref, menuItemId) {
  final cartState = ref.watch(cartProvider);
  final item = cartState.cart.items.where((i) => i.menuItemId == menuItemId).firstOrNull;
  return item?.quantity ?? 0;
});

/// Can add from restaurant provider (check if cart is empty or same restaurant)
final canAddFromRestaurantProvider = Provider.family<bool, num>((ref, restaurantId) {
  final cartState = ref.watch(cartProvider);
  return cartState.isEmpty || cartState.currentRestaurantId == restaurantId;
});
