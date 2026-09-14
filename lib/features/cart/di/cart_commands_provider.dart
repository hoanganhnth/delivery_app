import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/cart/application/cart_commands.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:delivery_app/features/cart/application/cart_notifier.dart';

/// Temporary adapter over the legacy notifier. It gives external features one
/// stable command port while Cart itself is migrated to an application layer.
final cartCommandsProvider = Provider<CartCommands>((ref) {
  return _RiverpodCartCommands(ref);
});

class _RiverpodCartCommands implements CartCommands {
  const _RiverpodCartCommands(this._ref);

  final Ref _ref;

  @override
  Future<void> addItem(CartItemEntity item, {String? livestreamId}) => _ref
      .read(cartProvider.notifier)
      .addItem(item, livestreamId: livestreamId);

  @override
  Future<void> clearCart() => _ref.read(cartProvider.notifier).clearCart();

  @override
  Future<void> removeItem(num menuItemId) =>
      _ref.read(cartProvider.notifier).removeItem(menuItemId);

  @override
  Future<void> updateItemQuantity(num menuItemId, int quantity) =>
      _ref.read(cartProvider.notifier).updateItemQuantity(menuItemId, quantity);
}
