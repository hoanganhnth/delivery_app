/// Domain command used to create a customer order.
///
/// HTTP/Retrofit DTO conversion is exclusively the responsibility of the
/// Orders data adapter.
final class OrderCreationCommand {
  const OrderCreationCommand({
    this.quoteId,
    this.idempotencyKey,
    required this.restaurantId,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.customerName,
    required this.customerPhone,
    required this.paymentMethod,
    this.notes,
    this.voucherIds,
    this.selectionMode,
    required this.items,
  });

  final String? quoteId;
  final String? idempotencyKey;
  final int restaurantId;
  final String deliveryAddress;
  final double deliveryLat;
  final double deliveryLng;
  final String customerName;
  final String customerPhone;
  final String paymentMethod;
  final String? notes;
  final List<int>? voucherIds;
  final String? selectionMode;
  final List<OrderCreationItem> items;
}

final class OrderCreationItem {
  const OrderCreationItem({
    required this.menuItemId,
    required this.quantity,
    this.notes,
    this.flashSaleItemId,
  });

  final int menuItemId;
  final int quantity;
  final String? notes;
  final int? flashSaleItemId;
}
