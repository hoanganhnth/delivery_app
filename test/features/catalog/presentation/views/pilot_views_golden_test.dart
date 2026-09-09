import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/presentation/views/checkout_view.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_home_view.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_restaurant_detail_view.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    final font = FontLoader('Plus Jakarta Sans');
    for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold']) {
      font.addFont(rootBundle.load(
        'assets/fonts/plus_jakarta_sans/PlusJakartaSans-$weight.ttf',
      ));
    }
    await font.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });

  testWidgets('home light Vietnamese at 360px', (tester) async {
    await _pumpGolden(
      tester,
      size: const Size(360, 800),
      locale: const Locale('vi'),
      theme: AppTheme.light.themeData,
      child: CatalogHomeView(state: _homeState, onIntent: (_) {}),
    );

    await expectLater(
      find.byKey(_goldenKey),
      matchesGoldenFile('goldens/home_light_vi_360.png'),
    );
  });

  testWidgets('restaurant detail dark English at 390px', (tester) async {
    await _pumpGolden(
      tester,
      size: const Size(390, 844),
      locale: const Locale('en'),
      theme: AppTheme.dark.themeData,
      child: CatalogRestaurantDetailView(
        state: _restaurantState,
        onIntent: (_) {},
      ),
    );

    await expectLater(
      find.byKey(_goldenKey),
      matchesGoldenFile('goldens/restaurant_dark_en_390.png'),
    );
  });

  testWidgets('checkout light Vietnamese at 390px', (tester) async {
    await _pumpGolden(
      tester,
      size: const Size(390, 844),
      locale: const Locale('vi'),
      theme: AppTheme.light.themeData,
      child: CheckoutView(state: _checkoutState, onIntent: (_) {}),
    );

    await expectLater(
      find.byKey(_goldenKey),
      matchesGoldenFile('goldens/checkout_light_vi_390.png'),
    );
  });
}

const _goldenKey = Key('pilot_golden');

const _homeState = CatalogHomeViewState(
  restaurants: [
    CatalogRestaurantViewData(
      id: 1,
      name: 'Bếp Nhà',
      rating: 4.8,
      deliveryTimeMinutes: 25,
      category: 'Món Việt',
      distanceKm: 1.4,
      deliveryFee: 0,
    ),
  ],
);

const _restaurantState = CatalogRestaurantDetailViewState(
  restaurant: CatalogRestaurantDetailData(
    id: 1,
    name: 'Hearth Kitchen',
    address: '12 Market Street',
    description: 'Fresh Vietnamese comfort food, cooked to order.',
    openingHour: '08:00',
    closingHour: '22:00',
    isOpen: true,
  ),
  menuItems: [
    CatalogMenuItemViewData(
      id: 2,
      name: 'Vegetable fried rice',
      description: 'Jasmine rice, seasonal vegetables and fresh herbs',
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
  restaurantName: 'Bếp Nhà',
  itemCount: 1,
  lines: [
    CheckoutLineViewData(
      menuItemId: 2,
      name: 'Cơm rang rau củ',
      quantity: 1,
      lineTotal: 52000,
    ),
  ],
  selectedAddress: CheckoutAddressViewData(
    id: 3,
    label: 'Nhà',
    recipientName: 'An',
    phoneNumber: '0900000000',
    fullAddress: '12 Nguyễn Huệ, Quận 1',
    isDefault: true,
  ),
  price: CheckoutPriceViewData(
    subtotal: 52000,
    shippingFee: 12000,
    discountAmount: 0,
    total: 64000,
  ),
);

Future<void> _pumpGolden(
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
      debugShowCheckedModeBanner: false,
      locale: locale,
      theme: theme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: RepaintBoundary(key: _goldenKey, child: child),
    ),
  );
  await tester.pump();
}
