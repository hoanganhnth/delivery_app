import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/menu_item_entity.dart';

// Cart item model
class CartItem {
  final MenuItemEntity menuItem;
  final int quantity;
  final num restaurantId;

  const CartItem({
    required this.menuItem,
    required this.quantity,
    required this.restaurantId,
  });

  CartItem copyWith({
    MenuItemEntity? menuItem,
    int? quantity,
    num? restaurantId,
  }) {
    return CartItem(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  double get totalPrice => menuItem.price * quantity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.menuItem.id == menuItem.id &&
        other.restaurantId == restaurantId;
  }

  @override
  int get hashCode => menuItem.id.hashCode ^ restaurantId.hashCode;
}

// Cart state
class CartState {
  final List<CartItem> items;
  final num? currentRestaurantId;

  const CartState({this.items = const [], this.currentRestaurantId});

  CartState copyWith({List<CartItem>? items, num? currentRestaurantId}) {
    return CartState(
      items: items ?? this.items,
      currentRestaurantId: currentRestaurantId ?? this.currentRestaurantId,
    );
  }

  double get totalAmount =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  // Check if cart has items from a different restaurant
  bool canAddFromRestaurant(num restaurantId) {
    return isEmpty || currentRestaurantId == restaurantId;
  }

  // Get quantity of specific menu item
  int getItemQuantity(num menuItemId) {
    try {
      final item = items.firstWhere((item) => item.menuItem.id == menuItemId);
      return item.quantity;
    } catch (e) {
      return 0;
    }
  }
}

// Cart notifier
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  /// Add item to cart
  void addItem(MenuItemEntity menuItem, num restaurantId) {
    // Check if we can add from this restaurant
    if (!state.canAddFromRestaurant(restaurantId)) {
      // In real app, show dialog to confirm clearing cart
      clearCart();
    }

    final existingItemIndex = state.items.indexWhere(
      (item) => item.menuItem.id == menuItem.id,
    );

    List<CartItem> newItems;

    if (existingItemIndex >= 0) {
      // Update existing item quantity
      newItems = List.from(state.items);
      newItems[existingItemIndex] = newItems[existingItemIndex].copyWith(
        quantity: newItems[existingItemIndex].quantity + 1,
      );
    } else {
      // Add new item
      newItems = [
        ...state.items,
        CartItem(menuItem: menuItem, quantity: 1, restaurantId: restaurantId),
      ];
    }

    state = state.copyWith(items: newItems, currentRestaurantId: restaurantId);
  }

  /// Remove item from cart
  void removeItem(num menuItemId) {
    final existingItemIndex = state.items.indexWhere(
      (item) => item.menuItem.id == menuItemId,
    );

    if (existingItemIndex >= 0) {
      List<CartItem> newItems = List.from(state.items);

      if (newItems[existingItemIndex].quantity > 1) {
        // Decrease quantity
        newItems[existingItemIndex] = newItems[existingItemIndex].copyWith(
          quantity: newItems[existingItemIndex].quantity - 1,
        );
      } else {
        // Remove item completely
        newItems.removeAt(existingItemIndex);
      }

      state = state.copyWith(
        items: newItems,
        currentRestaurantId: newItems.isEmpty
            ? null
            : state.currentRestaurantId,
      );
    }
  }

  /// Clear entire cart
  void clearCart() {
    state = const CartState();
  }

  /// Update item quantity directly
  void updateItemQuantity(num menuItemId, int quantity) {
    if (quantity <= 0) {
      removeAllOfItem(menuItemId);
      return;
    }

    final existingItemIndex = state.items.indexWhere(
      (item) => item.menuItem.id == menuItemId,
    );

    if (existingItemIndex >= 0) {
      List<CartItem> newItems = List.from(state.items);
      newItems[existingItemIndex] = newItems[existingItemIndex].copyWith(
        quantity: quantity,
      );

      state = state.copyWith(items: newItems);
    }
  }

  /// Remove all instances of an item
  void removeAllOfItem(num menuItemId) {
    final newItems = state.items
        .where((item) => item.menuItem.id != menuItemId)
        .toList();

    state = state.copyWith(
      items: newItems,
      currentRestaurantId: newItems.isEmpty ? null : state.currentRestaurantId,
    );
  }
}

// Providers
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

// Helper providers
final cartItemsCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).totalItems;
});

final cartTotalAmountProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).totalAmount;
});

final isCartEmptyProvider = Provider<bool>((ref) {
  return ref.watch(cartProvider).isEmpty;
});

final currentRestaurantIdProvider = Provider<num?>((ref) {
  return ref.watch(cartProvider).currentRestaurantId;
});

// Provider to get quantity of specific menu item in cart
final menuItemQuantityProvider = Provider.family<int, num>((ref, menuItemId) {
  return ref.watch(cartProvider).getItemQuantity(menuItemId);
});
