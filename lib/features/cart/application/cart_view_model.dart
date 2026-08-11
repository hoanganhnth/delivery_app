import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/cart/application/cart_commands.dart';
import 'package:delivery_app/features/cart/di/cart_commands_provider.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/application/cart_notifier.dart';
import 'cart_view_effect.dart';
import 'cart_view_intent.dart';
import 'cart_view_state.dart';

final cartViewModelProvider = NotifierProvider<CartViewModel, CartViewState>(
  CartViewModel.new,
);

class CartViewModel extends Notifier<CartViewState> {
  int _nextEffectId = 0;
  bool _commandRunning = false;
  @override
  CartViewState build() {
    final value = ref.read(cartProvider);
    ref.listen<AsyncValue<CartEntity>>(cartProvider, (_, next) {
      if (ref.mounted) state = _fromCart(next, effects: state.effects);
    });
    return _fromCart(value);
  }

  Future<void> dispatch(CartViewIntent intent) async {
    switch (intent) {
      case CartPriceSyncRequested():
        await _syncPrices();
      case CartRetryRequested():
        ref.invalidate(cartProvider);
      case CartBackRequested():
        _emit(const CartNavigateBack());
      case CartBrowseRestaurantsRequested():
        _emit(const CartNavigateRestaurants());
      case CartCheckoutRequested():
        if (!state.isEmpty) _emit(const CartNavigateCheckout());
      case CartClearRequested():
        if (!state.isEmpty) _emit(const CartConfirmClear());
      case CartClearConfirmed():
        await _command((commands) => commands.clearCart());
      case CartIncrementRequested(:final menuItemId):
        await _changeQuantity(menuItemId, 1);
      case CartDecrementRequested(:final menuItemId):
        await _changeQuantity(menuItemId, -1);
      case CartEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _changeQuantity(num id, int delta) async {
    final item = state.items.where((line) => line.menuItemId == id).firstOrNull;
    if (item == null) {
      return;
    }
    if (item.quantity + delta <= 0) {
      return _command((commands) => commands.removeItem(id));
    }
    return _command(
      (commands) => commands.updateItemQuantity(id, item.quantity + delta),
    );
  }

  Future<void> _command(
    Future<void> Function(CartCommands commands) action,
  ) async {
    if (_commandRunning) {
      return;
    }
    _commandRunning = true;
    try {
      await action(ref.read(cartCommandsProvider));
    } catch (_) {
      _emit(
        const CartShowMessage('Không thể cập nhật giỏ hàng. Vui lòng thử lại.'),
      );
    } finally {
      _commandRunning = false;
    }
  }

  Future<void> _syncPrices() async {
    try {
      final result = await ref
          .read(cartProvider.notifier)
          .syncPricesWithServer();
      if (!result.hasChanges) return;
      final messages = <String>[
        for (final change in result.priceChanges)
          '${change.itemName}: ${change.priceIncreased ? 'tăng' : 'giảm'} giá',
        if (result.unavailableItemIds.isNotEmpty)
          '${result.unavailableItemIds.length} món đã hết hàng (đã xoá)',
      ];
      _emit(CartShowMessage(messages.join('\n')));
    } catch (_) {
      /* preserves legacy silent price-sync failure */
    }
  }

  CartViewState _fromCart(
    AsyncValue<CartEntity> value, {
    List<UiEffectEnvelope<CartViewEffect>> effects = const [],
  }) => value.when(
    loading: () => CartViewState(isLoading: true, effects: effects),
    error: (_, _) =>
        CartViewState(isLoading: false, hasError: true, effects: effects),
    data: (cart) => CartViewState(
      restaurantName: cart.currentRestaurantName,
      items: cart.items
          .map(
            (item) => CartLineViewData(
              menuItemId: item.menuItemId,
              name: item.menuItemName,
              price: item.price,
              quantity: item.quantity,
              imageUrl: item.imageUrl,
              notes: item.notes,
            ),
          )
          .toList(growable: false),
      isLoading: false,
      totalAmount: cart.totalAmount,
      effects: effects,
    ),
  );
  void _emit(CartViewEffect effect) => state = state.copyWith(
    effects: [
      ...state.effects,
      UiEffectEnvelope(id: _nextEffectId++, effect: effect),
    ],
  );
}
