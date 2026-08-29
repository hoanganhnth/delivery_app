import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_contract.dart';

final cartCommandsPortProvider = Provider<CartCommands>((ref) =>
    _UnavailableCartPort.instance);

final cartReaderPortProvider = Provider<CartReader>((ref) =>
    _UnavailableCartPort.instance);

final class _UnavailableCartPort implements CartCommands, CartReader {
  const _UnavailableCartPort._();
  static const instance = _UnavailableCartPort._();

  @override
  CartSnapshot? get current => null;

  @override
  Stream<CartSnapshot> get changes => const Stream<CartSnapshot>.empty();

  @override
  Future<void> addLine(CartLineInput input) async {}

  @override
  Future<void> setQuantity(int menuItemId, int quantity) async {}

  @override
  Future<void> removeLine(int menuItemId) async {}

  @override
  Future<void> clear() async {}
}
