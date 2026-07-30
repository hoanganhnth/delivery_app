import 'package:delivery_app/features/cart/presentation/utils/checkout_order_builder.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  test('builds the canonical COD order from cart, address and server preview', () {
    final request = CheckoutOrderBuilder.buildOrderRequest(
      cart: buildCart(items: [buildCartItem(notes: 'Ít cay')]),
      address: buildAddress(),
      preview: _preview,
      notes: 'Gọi trước khi giao',
    );

    expect(request.restaurantId, 201);
    expect(request.deliveryAddress, contains('2 Đường Khách'));
    expect(request.deliveryLat, 10.78);
    expect(request.deliveryLng, 106.71);
    expect(request.customerName, 'Customer Test');
    expect(request.customerPhone, '0900000002');
    expect(request.paymentMethod, 'COD');
    expect(request.notes, 'Gọi trước khi giao');
    expect(request.items.single.menuItemId, 301);
    expect(request.items.single.notes, 'Ít cay');
  });

  test('rejects missing address and mixed-restaurant carts before preview I/O', () {
    expect(
      () => CheckoutOrderBuilder.buildPreviewRequest(
        cart: buildCart(),
        address: null,
      ),
      throwsA(
        isA<CheckoutOrderBuildException>().having(
          (error) => error.failure,
          'failure',
          CheckoutOrderBuildFailure.invalidInput,
        ),
      ),
    );

    final mixedCart = buildCart(
      items: [
        buildCartItem(),
        buildCartItem(menuItemId: 302, restaurantId: 202),
      ],
    );
    expect(
      () => CheckoutOrderBuilder.buildPreviewRequest(
        cart: mixedCart,
        address: buildAddress(),
      ),
      throwsA(isA<CheckoutOrderBuildException>()),
    );
  });

  test('rejects absent or mismatched server price confirmation', () {
    expect(
      () => CheckoutOrderBuilder.buildOrderRequest(
        cart: buildCart(),
        address: buildAddress(),
        preview: null,
      ),
      throwsA(
        isA<CheckoutOrderBuildException>().having(
          (error) => error.failure,
          'failure',
          CheckoutOrderBuildFailure.invalidPreview,
        ),
      ),
    );

    expect(
      () => CheckoutOrderBuilder.buildOrderRequest(
        cart: buildCart(),
        address: buildAddress(),
        preview: _preview.copyWith(restaurantId: 999),
      ),
      throwsA(
        isA<CheckoutOrderBuildException>().having(
          (error) => error.failure,
          'failure',
          CheckoutOrderBuildFailure.invalidPreview,
        ),
      ),
    );
  });
}

const _preview = CheckoutPreviewResponse(
  restaurantId: 201,
  restaurantName: 'Bếp test',
  items: [
    PreviewItemDetail(
      menuItemId: 301,
      menuItemName: 'Cơm test',
      unitPrice: 50000,
      quantity: 1,
      lineTotal: 50000,
    ),
  ],
  subtotal: 50000,
  shippingFee: 15000,
  discountAmount: 0,
  totalPrice: 65000,
  unavailableItemIds: [],
);
