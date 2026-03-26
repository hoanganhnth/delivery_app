import '../../domain/entities/cart_entity.dart';

/// Cart state for UI (AsyncNotifier pattern)
/// Note: isLoading and failure are handled by AsyncValue, so we don't need them here
class CartState {
  final CartEntity cart;

  const CartState({
    required this.cart,
  });

  const CartState.initial()
      : cart = const CartEntity(
          items: [],
          currentRestaurantId: null,
          currentRestaurantName: null,
        );

  CartState copyWith({
    CartEntity? cart,
  }) {
    return CartState(
      cart: cart ?? this.cart,
    );
  }

  // Computed properties for easy access
  bool get isEmpty => cart.isEmpty;
  bool get isNotEmpty => cart.isNotEmpty;
  int get totalItems => cart.totalItems;
  double get totalAmount => cart.totalAmount;
  num? get currentRestaurantId => cart.currentRestaurantId;
  String? get currentRestaurantName => cart.currentRestaurantName;
}
