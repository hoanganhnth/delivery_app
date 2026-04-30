import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../restaurants/domain/entities/menu_item_entity.dart';
import '../../../../restaurants/presentation/providers/di/restaurant_di_providers.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/usecases/cart_usecases.dart';
import '../di/cart_di_providers.dart';

part 'cart_notifier.g.dart';

/// Kết quả đồng bộ giá
class PriceSyncResult {
  final List<PriceChange> priceChanges;
  final List<num> unavailableItemIds;

  const PriceSyncResult({
    this.priceChanges = const [],
    this.unavailableItemIds = const [],
  });

  bool get hasChanges => priceChanges.isNotEmpty || unavailableItemIds.isNotEmpty;
}

class PriceChange {
  final num menuItemId;
  final String itemName;
  final double oldPrice;
  final double newPrice;

  const PriceChange({
    required this.menuItemId,
    required this.itemName,
    required this.oldPrice,
    required this.newPrice,
  });

  double get priceDifference => newPrice - oldPrice;
  bool get priceIncreased => newPrice > oldPrice;
}

/// Cart notifier for state management using AsyncNotifier
/// Returns CartEntity directly, AsyncValue handles loading/error states
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<CartEntity> build() async {
    // Load cart from storage on initialization
    final getCartUseCase = ref.read(getCartUseCaseProvider);
    final result = await getCartUseCase(NoParams());

    final cart = result.fold(
      (failure) => const CartEntity(
        items: [],
        currentRestaurantId: null,
        currentRestaurantName: null,
      ),
      (cart) => cart,
    );

    // Tự động đồng bộ giá với server nếu cart không rỗng (fire-and-forget)
    if (cart.isNotEmpty) {
      _syncPricesInBackground(cart);
    }

    return cart;
  }

  /// Đồng bộ giá ngầm (không chặn UI, cập nhật state khi xong)
  Future<void> _syncPricesInBackground(CartEntity cart) async {
    try {
      final syncResult = await _performPriceSync(cart);

      if (syncResult.hasChanges) {
        // Lấy lại cart mới nhất từ state (có thể đã thay đổi)
        final currentCart = state.value;
        if (currentCart == null || currentCart.isEmpty) return;

        var updatedItems = List<CartItemEntity>.from(currentCart.items);

        // Cập nhật giá
        for (final change in syncResult.priceChanges) {
          final idx = updatedItems.indexWhere(
            (item) => item.menuItemId == change.menuItemId,
          );
          if (idx != -1) {
            updatedItems[idx] = updatedItems[idx].copyWith(
              price: change.newPrice,
            );
          }
        }

        // Xoá item không còn available
        updatedItems.removeWhere(
          (item) => syncResult.unavailableItemIds.contains(item.menuItemId),
        );

        final updatedCart = CartEntity(
          items: updatedItems,
          currentRestaurantId:
              updatedItems.isEmpty ? null : currentCart.currentRestaurantId,
          currentRestaurantName:
              updatedItems.isEmpty ? null : currentCart.currentRestaurantName,
        );

        // Cập nhật state
        state = AsyncValue.data(updatedCart);

        // Persist vào local storage
        await _persistCart(updatedCart);
      }
    } catch (_) {
      // Sync thất bại thì bỏ qua — giữ giá local cũ
      // Lần checkout server sẽ validate lại
    }
  }

  /// Thực hiện đồng bộ giá — gọi API getMenuItems rồi so sánh
  Future<PriceSyncResult> _performPriceSync(CartEntity cart) async {
    if (cart.isEmpty || cart.currentRestaurantId == null) {
      return const PriceSyncResult();
    }

    final getMenuItemsUseCase = ref.read(getMenuItemsUseCaseProvider);
    final result = await getMenuItemsUseCase(cart.currentRestaurantId!);

    return result.fold(
      (_) => const PriceSyncResult(), // API fail → no changes
      (serverMenuItems) {
        final serverMap = <num, MenuItemEntity>{};
        for (final item in serverMenuItems) {
          if (item.id != null) serverMap[item.id!] = item;
        }

        final priceChanges = <PriceChange>[];
        final unavailableIds = <num>[];

        for (final cartItem in cart.items) {
          final serverItem = serverMap[cartItem.menuItemId];

          if (serverItem == null) {
            // Món không còn tồn tại trên server
            unavailableIds.add(cartItem.menuItemId);
            continue;
          }

          if (serverItem.status != MenuItemStatus.available) {
            // Món đã hết / unavailable
            unavailableIds.add(cartItem.menuItemId);
            continue;
          }

          // So sánh giá
          if ((serverItem.price - cartItem.price).abs() > 0.01) {
            priceChanges.add(PriceChange(
              menuItemId: cartItem.menuItemId,
              itemName: cartItem.menuItemName,
              oldPrice: cartItem.price,
              newPrice: serverItem.price,
            ));
          }
        }

        return PriceSyncResult(
          priceChanges: priceChanges,
          unavailableItemIds: unavailableIds,
        );
      },
    );
  }

  /// Đồng bộ giá thủ công (gọi từ UI, ví dụ khi mở màn hình giỏ hàng)
  /// Trả về PriceSyncResult để UI hiển thị thông báo
  Future<PriceSyncResult> syncPricesWithServer() async {
    final currentCart = state.value;
    if (currentCart == null || currentCart.isEmpty) {
      return const PriceSyncResult();
    }

    final syncResult = await _performPriceSync(currentCart);

    if (syncResult.hasChanges) {
      var updatedItems = List<CartItemEntity>.from(currentCart.items);

      for (final change in syncResult.priceChanges) {
        final idx = updatedItems.indexWhere(
          (item) => item.menuItemId == change.menuItemId,
        );
        if (idx != -1) {
          updatedItems[idx] = updatedItems[idx].copyWith(
            price: change.newPrice,
          );
        }
      }

      updatedItems.removeWhere(
        (item) => syncResult.unavailableItemIds.contains(item.menuItemId),
      );

      final updatedCart = CartEntity(
        items: updatedItems,
        currentRestaurantId:
            updatedItems.isEmpty ? null : currentCart.currentRestaurantId,
        currentRestaurantName:
            updatedItems.isEmpty ? null : currentCart.currentRestaurantName,
      );

      state = AsyncValue.data(updatedCart);
      await _persistCart(updatedCart);
    }

    return syncResult;
  }

  /// Persist cart to local storage after sync
  Future<void> _persistCart(CartEntity cart) async {
    final clearCartUseCase = ref.read(clearCartUseCaseProvider);
    await clearCartUseCase(NoParams());

    final addToCartUseCase = ref.read(addToCartUseCaseProvider);
    for (final item in cart.items) {
      await addToCartUseCase(AddToCartParams(item: item));
    }
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
