/// Checkout boundary shared by Cart, Checkout and the Orders data adapter.
/// HTTP DTOs stay outside this contract.
abstract interface class CheckoutPort {
  Future<CheckoutQuote> preview(CheckoutPreviewRequest request);
  Future<OrderReceipt> place(PlaceOrderCommand command);
}

final class CheckoutPreviewRequest {
  CheckoutPreviewRequest({
    required this.restaurantId,
    required this.deliveryLat,
    required this.deliveryLng,
    required Iterable<CheckoutItemInput> items,
    this.voucherId,
    Iterable<int>? selectedVoucherIds,
    this.selectionMode,
  }) : items = List.unmodifiable(items),
       selectedVoucherIds = selectedVoucherIds == null
           ? null
           : List.unmodifiable(selectedVoucherIds);

  final int restaurantId;
  final double deliveryLat;
  final double deliveryLng;
  final List<CheckoutItemInput> items;
  final int? voucherId;
  final List<int>? selectedVoucherIds;
  final String? selectionMode;
}

final class CheckoutItemInput {
  const CheckoutItemInput({
    required this.menuItemId,
    required this.quantity,
    this.flashSaleItemId,
  });

  final int menuItemId;
  final int quantity;
  final int? flashSaleItemId;
}

final class CheckoutQuote {
  CheckoutQuote({
    required this.quoteId,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    Iterable<int> unavailableItemIds = const <int>[],
    this.expiresAt,
  }) : unavailableItemIds = List.unmodifiable(unavailableItemIds);

  final String quoteId;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final List<int> unavailableItemIds;
  final DateTime? expiresAt;
}

final class PlaceOrderCommand {
  PlaceOrderCommand({
    required this.quoteId,
    required this.idempotencyKey,
    required this.restaurantId,
    required this.deliveryAddress,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.customerName,
    required this.customerPhone,
    required this.paymentMethod,
    required Iterable<CheckoutItemInput> items,
    this.notes,
    Iterable<int>? voucherIds,
    this.selectionMode,
  }) : items = List.unmodifiable(items),
       voucherIds = voucherIds == null ? null : List.unmodifiable(voucherIds);

  final String quoteId;
  final String idempotencyKey;
  final int restaurantId;
  final String deliveryAddress;
  final double deliveryLat;
  final double deliveryLng;
  final String customerName;
  final String customerPhone;
  final String paymentMethod;
  final List<CheckoutItemInput> items;
  final String? notes;
  final List<int>? voucherIds;
  final String? selectionMode;
}

final class OrderReceipt {
  const OrderReceipt({
    required this.orderId,
    required this.status,
    required this.createdAt,
  });

  final int orderId;
  final String status;
  final DateTime createdAt;
}
