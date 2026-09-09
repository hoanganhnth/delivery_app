import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/presentation/views/checkout_view.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_home_view.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_restaurant_detail_view.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home is localized and accessible at 360 logical pixels', (
    tester,
  ) async {
    await _pumpPilot(
      tester,
      locale: const Locale('en'),
      theme: AppTheme.dark.themeData,
      size: const Size(360, 800),
      child: CatalogHomeView(state: _homeState, onIntent: (_) {}),
    );

    expect(find.text('Deliver to'), findsOneWidget);
    expect(find.text('What are you craving today?'), findsOneWidget);
    expect(find.text('See all'), findsOneWidget);
    expect(find.bySemanticsLabel('Open notifications'), findsOneWidget);
    expect(find.bySemanticsLabel('Open cart'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Featured restaurants'), 200,
      scrollable: find.byType(Scrollable).first);
    expect(find.text('Featured restaurants'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('restaurant detail is localized and accessible at 390 pixels', (
    tester,
  ) async {
    await _pumpPilot(
      tester,
      locale: const Locale('vi'),
      theme: AppTheme.light.themeData,
      size: const Size(390, 844),
      child: CatalogRestaurantDetailView(
        state: _restaurantState,
        onIntent: (_) {},
      ),
    );

    expect(find.text('Thực đơn'), findsOneWidget);
    expect(find.text('Đang mở cửa'), findsOneWidget);
    expect(find.bySemanticsLabel('Thêm Cơm rang vào giỏ'), findsOneWidget);
    expect(find.bySemanticsLabel('Quay lại'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp(r'Xem giỏ hàng, 1 món')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('checkout English state fits 360 pixels and names actions', (
    tester,
  ) async {
    await _pumpPilot(
      tester,
      locale: const Locale('en'),
      theme: AppTheme.dark.themeData,
      size: const Size(360, 800),
      child: CheckoutView(state: _checkoutState, onIntent: (_) {}),
    );

    expect(find.text('Checkout'), findsOneWidget);
    expect(find.text('Hearth Kitchen'), findsOneWidget);
    expect(find.text('Cash on delivery'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('checkout_notes')),
      240,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Notes (optional)'), findsOneWidget);
    expect(find.bySemanticsLabel('Close checkout'), findsOneWidget);
    expect(find.bySemanticsLabel('Place order'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('all pilots render in both themes and locales', (tester) async {
    for (final locale in const [Locale('vi'), Locale('en')]) {
      for (final theme in [AppTheme.light.themeData, AppTheme.dark.themeData]) {
        for (final child in <Widget>[
          CatalogHomeView(state: _homeState, onIntent: (_) {}),
          CatalogRestaurantDetailView(
            state: _restaurantState,
            onIntent: (_) {},
          ),
          CheckoutView(state: _checkoutState, onIntent: (_) {}),
        ]) {
          await _pumpPilot(
            tester,
            locale: locale,
            theme: theme,
            size: const Size(390, 844),
            child: child,
          );
          expect(tester.takeException(), isNull);
        }
      }
    }
  });
}

const _homeState = CatalogHomeViewState(
  restaurants: [
    CatalogRestaurantViewData(
      id: 1,
      name: 'Hearth Kitchen',
      rating: 4.8,
      deliveryTimeMinutes: 25,
      category: 'Vietnamese',
      distanceKm: 1.4,
      deliveryFee: 0,
    ),
  ],
);

const _restaurantState = CatalogRestaurantDetailViewState(
  restaurant: CatalogRestaurantDetailData(
    id: 1,
    name: 'Bếp Nhà',
    address: '12 Nguyễn Huệ',
    description: 'Món Việt nấu mới mỗi ngày',
    openingHour: '08:00',
    closingHour: '22:00',
    isOpen: true,
  ),
  menuItems: [
    CatalogMenuItemViewData(
      id: 2,
      name: 'Cơm rang',
      description: 'Cơm rang rau củ',
      catalogPrice: 52000,
      availability: CatalogMenuAvailability.available,
      quantity: 1,
    ),
  ],
  cartItemsCount: 1,
  cartTotalAmount: 52000,
);

const _checkoutState = CheckoutViewState(
  isCartLoading: false,
  restaurantName: 'Hearth Kitchen',
  itemCount: 1,
  lines: [
    CheckoutLineViewData(
      menuItemId: 2,
      name: 'Fried rice',
      quantity: 1,
      lineTotal: 52000,
    ),
  ],
  selectedAddress: CheckoutAddressViewData(
    id: 3,
    label: 'Home',
    recipientName: 'Alex',
    phoneNumber: '0900000000',
    fullAddress: '12 Market Street',
    isDefault: true,
  ),
  price: CheckoutPriceViewData(
    subtotal: 52000,
    shippingFee: 12000,
    discountAmount: 0,
    total: 64000,
  ),
);

Future<void> _pumpPilot(
  WidgetTester tester, {
  required Widget child,
  required Locale locale,
  required ThemeData theme,
  required Size size,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      theme: theme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: child,
    ),
  );
  await tester.pump();
}
