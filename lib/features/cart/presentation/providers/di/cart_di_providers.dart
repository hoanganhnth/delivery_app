import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/datasources/cart_local_datasource.dart';
import '../../../data/datasources/cart_local_datasource_impl.dart';
import '../../../data/repositories_impl/cart_repository_impl.dart';
import '../../../domain/usecases/cart_usecases.dart';
import '../state/cart_notifier.dart';

part 'cart_di_providers.g.dart';

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
@riverpod
int cartItemsCount(Ref ref) {
  final cartAsyncValue = ref.watch(cartProvider);
  return cartAsyncValue.value?.totalItems ?? 0;
}

/// Cart total amount provider
@riverpod
double cartTotalAmount(Ref ref) {
  final cartAsyncValue = ref.watch(cartProvider);
  return cartAsyncValue.value?.totalAmount ?? 0.0;
}

/// Is cart empty provider
@riverpod
bool isCartEmpty(Ref ref) {
  final cartAsyncValue = ref.watch(cartProvider);
  return cartAsyncValue.value?.isEmpty ?? true;
}

/// Menu item quantity in cart provider
@riverpod
int menuItemQuantity(Ref ref, num menuItemId) {
  final cartAsyncValue = ref.watch(cartProvider);
  final cart = cartAsyncValue.value;
  if (cart == null) return 0;
  final item = cart.items.where((i) => i.menuItemId == menuItemId).firstOrNull;
  return item?.quantity ?? 0;
}

/// Can add from restaurant provider (check if cart is empty or same restaurant)
@riverpod
bool canAddFromRestaurant(Ref ref, num restaurantId) {
  final cartAsyncValue = ref.watch(cartProvider);
  final cart = cartAsyncValue.value;
  if (cart == null) return true;
  return cart.isEmpty || cart.currentRestaurantId == restaurantId;
}
