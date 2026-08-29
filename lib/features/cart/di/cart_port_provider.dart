import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/cart_contract.dart';
import 'package:delivery_app/features/cart/application/cart_notifier.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';

final cartCommandsPortOverrideProvider = Provider<CartCommands>((ref) =>
    _CartPortAdapter(ref));

final cartReaderPortOverrideProvider = Provider<CartReader>((ref) =>
    _CartPortAdapter(ref));

final class _CartPortAdapter implements CartCommands, CartReader {
  _CartPortAdapter(this._ref) {
    _ref.onDispose(_changes.close);
    _snapshot = _toSnapshot(_ref.read(cartProvider).value);
    _ref.listen<AsyncValue<CartEntity>>(cartProvider, (_, next) {
      final snapshot = _toSnapshot(next.value);
      _snapshot = snapshot;
      if (snapshot != null && !_changes.isClosed) _changes.add(snapshot);
    });
  }

  final Ref _ref;
  final _changes = StreamController<CartSnapshot>.broadcast();
  late CartSnapshot? _snapshot;

  @override
  CartSnapshot? get current => _snapshot;

  @override
  Stream<CartSnapshot> get changes => _changes.stream;

  @override
  Future<void> addLine(CartLineInput input) => _ref
      .read(cartProvider.notifier)
      .addItem(CartItemEntity.fromMenuItem(_Source(input), input.restaurantName,
          quantity: input.quantity,
          notes: input.notes,
          flashSaleItemId: input.flashSaleItemId));

  @override
  Future<void> setQuantity(int menuItemId, int quantity) =>
      _ref.read(cartProvider.notifier).updateItemQuantity(menuItemId, quantity);

  @override
  Future<void> removeLine(int menuItemId) =>
      _ref.read(cartProvider.notifier).removeItem(menuItemId);

  @override
  Future<void> clear() => _ref.read(cartProvider.notifier).clearCart();

  static CartSnapshot? _toSnapshot(CartEntity? cart) {
    if (cart == null) return null;
    return CartSnapshot(
      restaurantId: cart.currentRestaurantId?.toInt(),
      restaurantName: cart.currentRestaurantName,
      lines: cart.items.map((item) => CartLineSnapshot(
            menuItemId: item.menuItemId.toInt(),
            restaurantId: item.restaurantId.toInt(),
            restaurantName: item.restaurantName,
            name: item.menuItemName,
            unitPrice: item.price,
            quantity: item.quantity,
            imageUrl: item.imageUrl,
            notes: item.notes,
            flashSaleItemId: item.flashSaleItemId,
          )),
    );
  }
}

final class _Source implements CartLineSource {
  const _Source(this.input);
  final CartLineInput input;
  @override num get id => input.menuItemId;
  @override num get restaurantId => input.restaurantId;
  @override String get name => input.name;
  @override double get price => input.unitPrice;
  @override String? get image => input.imageUrl;
  @override bool get canAddToCart => true;
}
