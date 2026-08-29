import 'package:flutter_test/flutter_test.dart';

import 'package:delivery_app/core/contracts/address_contract.dart';
import 'package:delivery_app/core/contracts/cart_contract.dart';
import 'package:delivery_app/core/contracts/checkout_contract.dart';
import 'package:delivery_app/core/contracts/session_contract.dart';

void main() {
  test('cart snapshot exposes immutable totals from neutral line values', () {
    final snapshot = CartSnapshot(
      restaurantId: 17,
      restaurantName: 'Bếp Nhà',
      lines: [
        const CartLineSnapshot(
          menuItemId: 1,
          restaurantId: 17,
          restaurantName: 'Bếp Nhà',
          name: 'Cơm tấm',
          unitPrice: 35,
          quantity: 2,
        ),
      ],
    );

    expect(snapshot.totalItems, 2);
    expect(snapshot.totalAmount, 70);
    expect(snapshot.isEmpty, isFalse);
    expect(
      () => snapshot.lines.add(snapshot.lines.first),
      throwsUnsupportedError,
    );
  });

  test(
    'session snapshot keeps identity and token separate from profile entity',
    () {
      final snapshot = SessionSnapshot(
        isAuthenticated: true,
        authId: 10,
        profileId: 22,
        accessToken: 'access-token',
        roles: {'USER'},
      );

      expect(snapshot.isAuthenticated, isTrue);
      expect(snapshot.authId, 10);
      expect(snapshot.profileId, 22);
      expect(snapshot.accessToken, 'access-token');
      expect(snapshot.roles, contains('USER'));
      expect(() => snapshot.roles.add('ADMIN'), throwsUnsupportedError);
    },
  );

  test('delivery address snapshot exposes checkout-safe address data', () {
    const address = DeliveryAddressSnapshot(
      id: 9,
      profileId: 22,
      label: 'Nhà',
      recipientName: 'An',
      phoneNumber: '0900000000',
      fullAddress: '1 Nguyễn Huệ, Quận 1, TP.HCM',
      latitude: 10.776,
      longitude: 106.701,
      isDefault: true,
    );

    expect(address.profileId, 22);
    expect(address.fullAddress, contains('Nguyễn Huệ'));
    expect(address.hasCoordinates, isTrue);
  });

  test('checkout contracts preserve quote and idempotency data', () {
    final request = CheckoutPreviewRequest(
      restaurantId: 17,
      deliveryLat: 10.776,
      deliveryLng: 106.701,
      items: [CheckoutItemInput(menuItemId: 1, quantity: 2)],
    );
    final command = PlaceOrderCommand(
      quoteId: 'quote-1',
      idempotencyKey: 'idem-1',
      restaurantId: request.restaurantId,
      deliveryAddress: '1 Nguyễn Huệ',
      deliveryLat: request.deliveryLat,
      deliveryLng: request.deliveryLng,
      customerName: 'An',
      customerPhone: '0900000000',
      paymentMethod: 'COD',
      items: request.items,
    );

    expect(command.quoteId, 'quote-1');
    expect(command.idempotencyKey, 'idem-1');
    expect(command.items.single.quantity, 2);
  });
}
