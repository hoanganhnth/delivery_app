import 'package:delivery_app/features/cart/application/cart_view_intent.dart';
import 'package:delivery_app/features/cart/application/cart_view_state.dart';
import 'package:delivery_app/features/cart/presentation/views/cart_view.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/presentation/views/checkout_view.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_state.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_intent.dart';
import 'package:delivery_app/features/cart/presentation/views/order_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../support/app_harness.dart';

void main() {
  testWidgets(
    'phone checkout starts with address and keeps gated action visible',
    (tester) async {
      final intents = <CheckoutIntent>[];
      await pumpTestApp(
        tester,
        viewport: const Size(320, 740),
        child: CheckoutView(
          state: const CheckoutViewState(
            isCartLoading: false,
            restaurantName: 'Bếp',
            itemCount: 1,
            lines: [
              CheckoutLineViewData(
                menuItemId: 1,
                name: 'Cơm',
                quantity: 1,
                lineTotal: 50000,
              ),
            ],
          ),
          onIntent: intents.add,
        ),
      );
      expect(
        tester
            .getTopLeft(find.byKey(const Key('checkout_address_selector')))
            .dy,
        lessThan(tester.getTopLeft(find.text('Bếp')).dy),
      );
      final button = tester.widget<FilledButton>(
        find.byKey(const Key('checkout_place_order')),
      );
      expect(button.onPressed, isNull);
      await tester.tap(find.byKey(const Key('checkout_address_selector')));
      expect(intents.single, isA<CheckoutAddressSelectionRequested>());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('confirmation preserves tracking and home actions on phone', (
    tester,
  ) async {
    final intents = <OrderConfirmationIntent>[];
    var home = false;
    await pumpTestApp(
      tester,
      viewport: const Size(320, 740),
      child: OrderConfirmationView(
        state: const OrderConfirmationViewState(),
        onIntent: intents.add,
        onHome: () => home = true,
      ),
    );
    await tester.tap(find.byKey(const Key('confirmation_tracking')));
    expect(intents.single, isA<OrderConfirmationTrackingRequested>());
    await tester.tap(find.byType(TextButton));
    expect(home, isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'phone cart has horizontal quantity controls and fixed checkout',
    (tester) async {
      final intents = <CartViewIntent>[];
      await pumpTestApp(
        tester,
        child: CartView(
          state: const CartViewState(
            isLoading: false,
            restaurantName: 'Bếp',
            totalAmount: 100000,
            items: [
              CartLineViewData(
                menuItemId: 1,
                name: 'Cơm',
                price: 50000,
                quantity: 2,
                notes: 'Ít cay',
              ),
            ],
          ),
          onIntent: intents.add,
        ),
      );
      final minus = find.byIcon(Icons.remove);
      final plus = find.byIcon(Icons.add);
      expect(tester.getCenter(minus).dy, tester.getCenter(plus).dy);
      expect(tester.getCenter(minus).dx, lessThan(tester.getCenter(plus).dx));
      expect(find.byKey(const Key('cart_checkout')), findsOneWidget);
      await tester.tap(plus);
      await tester.tap(minus);
      await tester.tap(find.byKey(const Key('cart_checkout')));
      expect(intents, [
        isA<CartIncrementRequested>(),
        isA<CartDecrementRequested>(),
        isA<CartCheckoutRequested>(),
      ]);
      expect(find.text('Ít cay'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
