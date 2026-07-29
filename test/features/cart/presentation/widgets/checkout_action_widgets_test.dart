import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:delivery_app/features/cart/presentation/widgets/cart_checkout_button.dart';
import 'package:delivery_app/features/cart/presentation/widgets/checkout_bottom_section.dart';
import 'package:delivery_app/features/user_address/presentation/widgets/address_bottom_actions.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

const _cart = CartEntity(
  currentRestaurantId: 7,
  currentRestaurantName: 'Quán thật',
  items: [
    CartItemEntity(
      menuItemId: 11,
      menuItemName: 'Cơm tấm',
      price: 50000,
      quantity: 2,
      restaurantId: 7,
      restaurantName: 'Quán thật',
    ),
  ],
);

Widget _testApp(Widget child) {
  return ProviderScope(
    child: ScreenUtilInit(
      designSize: const Size(390, 812),
      builder: (_, __) => MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(body: child),
      ),
    ),
  );
}

void _setPhoneViewport(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 812);
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('checkout bottom action uses server-owned total and calls place-order callback', (
    tester,
  ) async {
    _setPhoneViewport(tester);
    var submitted = false;

    await tester.pumpWidget(
      _testApp(
        CheckoutBottomSection(
          cart: _cart,
          isLoading: false,
          serverSubtotal: 100000,
          serverShippingFee: 20000,
          serverDiscount: 10000,
          serverTotal: 110000,
          onPlaceOrder: () => submitted = true,
        ),
      ),
    );

    expect(find.text('110000₫'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(submitted, isTrue);
  });

  testWidgets('checkout bottom action is disabled while loading', (tester) async {
    _setPhoneViewport(tester);
    var submitted = false;

    await tester.pumpWidget(
      _testApp(
        CheckoutBottomSection(
          cart: _cart,
          isLoading: true,
          serverTotal: 110000,
          onPlaceOrder: () => submitted = true,
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(submitted, isFalse);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('cart checkout button calls checkout navigation callback', (tester) async {
    _setPhoneViewport(tester);
    var tapped = false;

    await tester.pumpWidget(
      _testApp(
        CartCheckoutButton(
          totalAmount: 120000,
          onPressed: () => tapped = true,
        ),
      ),
    );

    expect(find.text('Thanh toán'), findsOneWidget);
    expect(find.text('120000đ'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('address bottom actions save and default switch are wired', (tester) async {
    _setPhoneViewport(tester);
    var saved = false;
    bool? defaultValue;

    await tester.pumpWidget(
      _testApp(
        AddressBottomActions(
          colors: LightColors(),
          isEditing: true,
          isDefault: false,
          isSubmitting: false,
          onDefaultChanged: (value) => defaultValue = value,
          onSave: () => saved = true,
        ),
      ),
    );

    await tester.tap(find.byType(Switch));
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(defaultValue, isTrue);
    expect(saved, isTrue);
  });

  testWidgets('address save action is disabled while submitting', (tester) async {
    _setPhoneViewport(tester);
    var saved = false;

    await tester.pumpWidget(
      _testApp(
        AddressBottomActions(
          colors: LightColors(),
          isEditing: false,
          isDefault: false,
          isSubmitting: true,
          onSave: () => saved = true,
        ),
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(saved, isFalse);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
