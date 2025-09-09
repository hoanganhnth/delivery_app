/// Order item entity representing individual items in an order
class OrderItemEntity {
  final int? id;
  final int menuItemId;
  final String menuItemName;
  final int quantity;
  final double price;
  final String? notes;

  const OrderItemEntity({
    this.id,
    required this.menuItemId,
    required this.menuItemName,
    required this.quantity,
    required this.price,
    this.notes,
  });

  /// Calculate total price for this item
  double get totalPrice => price * quantity;

  OrderItemEntity copyWith({
    int? id,
    int? menuItemId,
    String? menuItemName,
    int? quantity,
    double? price,
    String? notes,
  }) {
    return OrderItemEntity(
      id: id ?? this.id,
      menuItemId: menuItemId ?? this.menuItemId,
      menuItemName: menuItemName ?? this.menuItemName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderItemEntity &&
        other.id == id &&
        other.menuItemId == menuItemId &&
        other.menuItemName == menuItemName &&
        other.quantity == quantity &&
        other.price == price &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      menuItemId,
      menuItemName,
      quantity,
      price,
      notes,
    );
  }

  @override
  String toString() {
    return 'OrderItemEntity(id: $id, menuItemId: $menuItemId, menuItemName: $menuItemName, quantity: $quantity, price: $price, notes: $notes)';
  }
}
