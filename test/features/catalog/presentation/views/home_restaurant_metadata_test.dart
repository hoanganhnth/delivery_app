import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/home/catalog_restaurant_list.dart';
import 'package:delivery_app/features/restaurants/presentation/widgets/shared/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../support/app_harness.dart';

void main() {
  testWidgets('missing Home metadata has display-only preview defaults', (
    tester,
  ) async {
    const restaurant = CatalogRestaurantViewData(id: 201, name: 'Quán thật');
    var opened = false;
    await pumpTestApp(
      tester,
      locale: const Locale('vi'),
      child: CatalogRestaurantCard(
        restaurant: restaurant,
        onTap: () => opened = true,
      ),
    );
    final card = tester.widget<RestaurantCard>(find.byType(RestaurantCard));
    expect(card.rating, 4.8);
    expect(card.distance, '1.2 km');
    expect(card.deliveryTime, '20–30 phút');
    expect(find.text('Yêu thích'), findsOneWidget);
    await tester.tap(find.text('Quán thật'));
    expect(opened, isTrue);
    expect(restaurant.rating, isNull);
    expect(restaurant.id, 201);
  });

  testWidgets('real values including zero are never replaced by defaults', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      locale: const Locale('vi'),
      child: CatalogRestaurantCard(
        restaurant: const CatalogRestaurantViewData(
          id: 201,
          name: 'Quán thật',
          rating: 0,
          distanceKm: 0,
          deliveryTimeMinutes: 45,
        ),
        onTap: () {},
      ),
    );
    final card = tester.widget<RestaurantCard>(find.byType(RestaurantCard));
    expect(card.rating, 0);
    expect(card.distance, '0.0 km');
    expect(card.deliveryTime, '45 phút');
  });
}
