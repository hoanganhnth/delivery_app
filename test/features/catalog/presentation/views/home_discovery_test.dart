import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:delivery_app/features/catalog/application/home_suggested_dish.dart';
import 'package:delivery_app/features/catalog/presentation/components/home/home_restaurants_section.dart';
import 'package:delivery_app/features/catalog/presentation/components/home/catalog_restaurant_list.dart';
import '../../../../support/app_harness.dart';

void main() {
  testWidgets('real suggested dish routes with its real restaurant id', (
    tester,
  ) async {
    final intents = <CatalogHomeIntent>[];
    await pumpTestApp(
      tester,
      child: CatalogHomeView(
        state: const CatalogHomeViewState(),
        onIntent: intents.add,
        suggestedDishes: const [
          HomeSuggestedDish(
            name: 'API dish',
            image: '',
            price: 42000,
            restaurantId: 201,
          ),
        ],
      ),
    );
    await tester.ensureVisible(find.text('API dish'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('API dish'));
    expect(
      (intents.single as CatalogHomeRestaurantRequested).restaurantId,
      201,
    );
    expect(find.text('Dữ liệu mẫu — chưa hỗ trợ đặt món này.'), findsNothing);
  });

  testWidgets('carousel swipes and mock category filters the local list', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      child: CatalogHomeView(
        state: const CatalogHomeViewState(),
        onIntent: (_) {},
      ),
    );
    await tester.drag(find.byType(PageView), const Offset(-390, 0));
    await tester.pumpAndSettle();
    expect(find.text('Bữa ngon hết ý'), findsOneWidget);
    await tester.tap(find.text('Bánh cuốn').hitTestable());
    await tester.pumpAndSettle();
    final list = tester.widget<CatalogRestaurantList>(
      find.descendant(
        of: find.byType(HomeRestaurantsSection),
        matching: find.byType(CatalogRestaurantList),
      ),
    );
    expect(list.state.restaurants, hasLength(1));
    expect(list.state.restaurants.single.category, 'Bánh cuốn');
  });

  testWidgets('home renders preview discovery blocks in order', (tester) async {
    await pumpTestApp(
      tester,
      locale: const Locale('vi'),
      child: CatalogHomeView(
        state: const CatalogHomeViewState(),
        onIntent: (_) {},
      ),
    );
    expect(find.byType(PageView), findsOneWidget);
    expect(find.text('Tất cả'), findsOneWidget);
    expect(find.text('Mì & phở').hitTestable(), findsOneWidget);
    expect(find.text('Hôm nay ăn gì?'), findsOneWidget);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(find.text('Quán ngon dành cho bạn'), findsOneWidget);
    expect(find.text('Đề xuất'), findsOneWidget);
  });

  testWidgets(
    'mock dish opens a labelled preview and never emits a real restaurant id',
    (tester) async {
      final intents = <CatalogHomeIntent>[];
      await pumpTestApp(
        tester,
        locale: const Locale('vi'),
        child: CatalogHomeView(
          state: const CatalogHomeViewState(),
          onIntent: intents.add,
        ),
      );
      await tester.ensureVisible(find.text('Mì vằn thắn khô'));
      await tester.tap(find.text('Mì vằn thắn khô'));
      await tester.pumpAndSettle();
      expect(
        find.text('Dữ liệu mẫu — chưa hỗ trợ đặt món này.'),
        findsOneWidget,
      );
      expect(intents.whereType<CatalogHomeRestaurantRequested>(), isEmpty);
    },
  );
}
