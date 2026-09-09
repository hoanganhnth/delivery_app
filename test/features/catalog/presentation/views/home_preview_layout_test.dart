import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_home_view.dart';
import 'package:delivery_app/features/catalog/presentation/components/home/home_livestream_banner.dart';
import 'package:delivery_app/features/catalog/presentation/components/home/catalog_restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  for (final size in const [Size(375, 812), Size(390, 844), Size(430, 932)]) {
    for (final dark in [false, true]) {
      testWidgets('home fits $size dark=$dark with large text and live content', (
        tester,
      ) async {
        await pumpTestApp(
          tester,
          viewport: size,
          locale: const Locale('vi'),
          theme: dark ? AppTheme.dark.themeData : AppTheme.light.themeData,
          child: MediaQuery(
            data: MediaQueryData(size: size, textScaler: TextScaler.linear(2)),
            child: CatalogHomeView(
              state: const CatalogHomeViewState(
                deliveryAddress:
                    'Địa chỉ rất dài tại Hoàn Kiếm, Hà Nội, Việt Nam',
                restaurants: [
                  CatalogRestaurantViewData(
                    id: 1,
                    name:
                        'Nhà hàng có tên dài để kiểm tra bố cục trên điện thoại',
                    rating: 4.8,
                    distanceKm: 1.2,
                    deliveryTimeMinutes: 25,
                  ),
                ],
              ),
              onIntent: (_) {},
              livestreamBanner: HomeLivestreamBanner(onTap: () {}),
            ),
          ),
        );
        await tester.drag(find.byType(CustomScrollView), const Offset(0, -400));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('Freeship Xtra'), findsNothing);
      });
    }
  }

  testWidgets(
    'loading stays loading and missing catalog has labelled fixtures',
    (tester) async {
      for (final state in const [
        CatalogHomeViewState(isLoading: true),
        CatalogHomeViewState(),
      ]) {
        await pumpTestApp(
          tester,
          locale: const Locale('vi'),
          child: CatalogHomeView(state: state, onIntent: (_) {}),
        );
        final list = tester.widget<CatalogRestaurantList>(
          find.byType(CatalogRestaurantList),
        );
        expect(list.state.isLoading, state.isLoading);
        expect(list.state.restaurants.isEmpty, state.isLoading);
        if (!state.isLoading) {
          expect(
            find.text('Danh sách mẫu — chưa kết nối dữ liệu quán'),
            findsOneWidget,
          );
        }
        expect(find.text('Freeship Xtra'), findsNothing);
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets('home has a separate brand, inline address and search row', (
    tester,
  ) async {
    final intents = <CatalogHomeIntent>[];
    await pumpTestApp(
      tester,
      locale: const Locale('vi'),
      theme: AppTheme.light.themeData,
      child: CatalogHomeView(
        state: const CatalogHomeViewState(deliveryAddress: '12 Tràng Thi'),
        onIntent: intents.add,
      ),
    );
    expect(find.text('ShopeeFood'), findsOneWidget);
    final address = tester.getCenter(find.text('12 Tràng Thi'));
    final label = tester.getCenter(find.text('Giao đến'));
    expect(address.dy, closeTo(label.dy, 2));
    expect(tester.getCenter(find.text('ShopeeFood')).dy, lessThan(label.dy));
    await tester.tap(find.text('12 Tràng Thi'));
    expect(intents.single, isA<CatalogHomeAddressRequested>());
    expect(find.text('Freeship Xtra'), findsNothing);
  });

  testWidgets('catalog errors expose retry while mock rows stay labelled', (
    tester,
  ) async {
    final intents = <CatalogHomeIntent>[];
    await pumpTestApp(
      tester,
      locale: const Locale('vi'),
      child: CatalogHomeView(
        state: const CatalogHomeViewState(errorMessage: 'Catalog offline'),
        onIntent: intents.add,
      ),
    );
    await tester.ensureVisible(find.text('Thử lại'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Thử lại'));
    expect(intents.single, isA<CatalogHomeLoadRequested>());
    expect(
      find.text('Danh sách mẫu — chưa kết nối dữ liệu quán'),
      findsOneWidget,
    );
  });
}
