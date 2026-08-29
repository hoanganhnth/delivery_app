/// Neutral cart write/read ports. Cart owns persistence and invariants;
/// callers never import CartNotifier or CartEntity.
abstract interface class CartCommands {
  Future<void> addLine(CartLineInput input);
  Future<void> setQuantity(int menuItemId, int quantity);
  Future<void> removeLine(int menuItemId);
  Future<void> clear();
}

abstract interface class CartReader {
  CartSnapshot? get current;
  Stream<CartSnapshot> get changes;
}

/// Minimal catalog projection required to create or refresh a cart line.
/// Catalog/restaurant entities implement this contract without importing Cart.
abstract interface class CartLineSource {
  num? get id;
  num? get restaurantId;
  String get name;
  double get price;
  String? get image;
  bool get canAddToCart;
}

class CartLineInput {
  const CartLineInput({
    required this.menuItemId,
    required this.restaurantId,
    required this.restaurantName,
    required this.name,
    required this.unitPrice,
    required this.quantity,
    this.imageUrl,
    this.notes,
    this.flashSaleItemId,
  });

  final int menuItemId;
  final int restaurantId;
  final String restaurantName;
  final String name;
  final double unitPrice;
  final int quantity;
  final String? imageUrl;
  final String? notes;
  final int? flashSaleItemId;
}

final class CartLineSnapshot extends CartLineInput {
  const CartLineSnapshot({
    required super.menuItemId,
    required super.restaurantId,
    required super.restaurantName,
    required super.name,
    required super.unitPrice,
    required super.quantity,
    super.imageUrl,
    super.notes,
    super.flashSaleItemId,
  });

  double get total => unitPrice * quantity;
}

final class CartSnapshot {
  CartSnapshot({
    required Iterable<CartLineSnapshot> lines,
    this.restaurantId,
    this.restaurantName,
  }) : lines = List.unmodifiable(lines);

  final List<CartLineSnapshot> lines;
  final int? restaurantId;
  final String? restaurantName;

  int get totalItems => lines.fold(0, (sum, line) => sum + line.quantity);
  double get totalAmount => lines.fold(0, (sum, line) => sum + line.total);
  bool get isEmpty => lines.isEmpty;
  bool get isNotEmpty => lines.isNotEmpty;
}
