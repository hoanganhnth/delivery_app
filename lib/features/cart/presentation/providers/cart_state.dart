import '../../../../core/error/failures.dart';
import '../../domain/entities/cart_entity.dart';

/// Cart state for UI
class CartState {
  final CartEntity cart;
  final bool isLoading;
  final Failure? failure;

  const CartState({
    required this.cart,
    this.isLoading = false,
    this.failure,
  });

  const CartState.initial()
      : cart = const CartEntity(
          items: [],
          currentRestaurantId: null,
          currentRestaurantName: null,
        ),
        isLoading = false,
        failure = null;

  CartState copyWith({
    CartEntity? cart,
    bool? isLoading,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  // Computed properties for easy access
  bool get isEmpty => cart.isEmpty;
  bool get isNotEmpty => cart.isNotEmpty;
  int get totalItems => cart.totalItems;
  double get totalAmount => cart.totalAmount;
  num? get currentRestaurantId => cart.currentRestaurantId;
  String? get currentRestaurantName => cart.currentRestaurantName;
  bool get hasError => failure != null;
}
