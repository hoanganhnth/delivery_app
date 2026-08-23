import 'package:delivery_app/features/cart/application/checkout_voucher.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('accepts shop-funded wallet vouchers and derives the shop layer', () {
    final voucher = CheckoutVoucher.fromJson({
      'id': 7,
      'code': 'SHOP10',
      'name': 'Shop discount',
      'creatorType': 'SHOP',
      'rewardType': 'PERCENTAGE',
      'discountValue': 10,
      'scopeType': 'SHOP',
      'scopeRefId': 201,
      'minOrderValue': 50000,
    });

    expect(voucher.layer, 'SHOP_DISCOUNT');
    expect(voucher.fundingSource, 'SHOP');
    expect(voucher.appliesToRestaurant(201), isTrue);
  });

  test('AUTO accepts the server-selected combination and additive totals', () {
    const request = CheckoutPreviewRequest(
      restaurantId: 201,
      deliveryLat: 10.78,
      deliveryLng: 106.71,
      selectionMode: 'AUTO',
      selectedVoucherIds: <int>[],
      items: <CheckoutPreviewItemRequest>[
        CheckoutPreviewItemRequest(menuItemId: 301, quantity: 1),
      ],
    );
    final response = CheckoutPreviewResponse(
      quoteId: '00000000-0000-0000-0000-000000000001',
      expiresAt: DateTime.utc(2099),
      restaurantId: 201,
      restaurantName: 'Bếp test',
      items: const <PreviewItemDetail>[
        PreviewItemDetail(
          menuItemId: 301,
          menuItemName: 'Cơm test',
          unitPrice: 100000,
          quantity: 1,
          lineTotal: 100000,
        ),
      ],
      subtotal: 100000,
      shippingFee: 20000,
      discountAmount: 30000,
      itemDiscount: 20000,
      shippingDiscount: 10000,
      customerShippingFee: 10000,
      totalPrice: 90000,
      selectedVoucherIds: const <int>[11, 12, 13],
      appliedVouchers: const <AppliedVoucherInfo>[
        AppliedVoucherInfo(
          voucherId: 11,
          code: 'SHOP10',
          layer: 'SHOP_DISCOUNT',
          fundingSource: 'SHOP',
          discountBase: 100000,
          discountAmount: 20000,
        ),
      ],
    );

    expect(response.validateFor(request).selectedVoucherIds, [11, 12, 13]);
  });

  test('MANUAL rejects a server response that changes selected IDs', () {
    const request = CheckoutPreviewRequest(
      restaurantId: 201,
      deliveryLat: 10.78,
      deliveryLng: 106.71,
      selectionMode: 'MANUAL',
      selectedVoucherIds: <int>[11, 12],
      items: <CheckoutPreviewItemRequest>[
        CheckoutPreviewItemRequest(menuItemId: 301, quantity: 1),
      ],
    );
    final response = CheckoutPreviewResponse(
      quoteId: '00000000-0000-0000-0000-000000000001',
      expiresAt: DateTime.utc(2099),
      restaurantId: 201,
      restaurantName: 'Bếp test',
      items: const <PreviewItemDetail>[
        PreviewItemDetail(
          menuItemId: 301,
          menuItemName: 'Cơm test',
          unitPrice: 100000,
          quantity: 1,
          lineTotal: 100000,
        ),
      ],
      subtotal: 100000,
      shippingFee: 20000,
      discountAmount: 0,
      totalPrice: 120000,
      selectedVoucherIds: const <int>[11, 13],
    );

    expect(() => response.validateFor(request), throwsFormatException);
  });
}
