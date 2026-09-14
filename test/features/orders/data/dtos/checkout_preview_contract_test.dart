import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const request = CheckoutPreviewRequest(
    restaurantId: 7,
    deliveryLat: 10.78,
    deliveryLng: 106.69,
    items: [CheckoutPreviewItemRequest(menuItemId: 11, quantity: 2)],
  );

  CheckoutPreviewResponse preview({
    String? quoteId = '00000000-0000-0000-0000-000000000001',
    DateTime? expiresAt,
    int? restaurantId = 7,
    String? restaurantName = 'Quán thật',
    double? unitPrice = 45000,
    int? quantity = 2,
    double? lineTotal = 90000,
    double? subtotal = 90000,
    double? shippingFee = 18000,
    double? discountAmount = 0,
    double? totalPrice = 108000,
    List<int>? unavailableItemIds = const [],
  }) {
    return CheckoutPreviewResponse(
      quoteId: quoteId,
      expiresAt: expiresAt ?? _futureExpiry,
      restaurantId: restaurantId,
      restaurantName: restaurantName,
      items: [
        PreviewItemDetail(
          menuItemId: 11,
          menuItemName: 'Cơm gà',
          unitPrice: unitPrice,
          quantity: quantity,
          lineTotal: lineTotal,
        ),
      ],
      subtotal: subtotal,
      shippingFee: shippingFee,
      discountAmount: discountAmount,
      totalPrice: totalPrice,
      unavailableItemIds: unavailableItemIds,
      priceChanges: const [],
    );
  }

  test('accepts a complete server-owned COD preview', () {
    expect(preview().validateFor(request).totalPrice, 108000);
  });

  test('serializes the optional livestream checkout source', () {
    const livestreamId = '00000000-0000-4000-8000-000000000001';
    final json = request.copyWith(livestreamId: livestreamId).toJson();

    expect(json['livestreamId'], livestreamId);
  });

  test('rejects missing prices and inconsistent totals', () {
    expect(
      () => preview(unitPrice: null).validateFor(request),
      throwsFormatException,
    );
    expect(
      () => preview(totalPrice: 1).validateFor(request),
      throwsFormatException,
    );
  });

  test('rejects mismatched or unavailable items', () {
    expect(
      () => preview(quantity: 1, lineTotal: 45000).validateFor(request),
      throwsFormatException,
    );
    expect(
      () => preview(unavailableItemIds: const [11]).validateFor(request),
      throwsFormatException,
    );
  });
}

final _futureExpiry = DateTime.utc(2099, 1, 1);
