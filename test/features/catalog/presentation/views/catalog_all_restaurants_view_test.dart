import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_all_restaurants_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('all restaurants view emits typed route intents only', (
    tester,
  ) async {
    final intents = <CatalogAllRestaurantsIntent>[];
    await pumpTestApp(
      tester,
      child: CatalogAllRestaurantsView(
        state: const CatalogAllRestaurantsViewState(
          restaurants: [
            CatalogRestaurantViewData(
              id: 201,
              name: 'Bếp test',
              address: '1 Đường Test',
              rating: 4.5,
            ),
          ],
        ),
        onIntent: intents.add,
      ),
    );

    await tester.tap(find.byTooltip('Quay lại'));
    await tester.tap(find.byTooltip('Tìm kiếm'));
    await tester.tap(find.text('Bếp test'));

    expect(intents[0], isA<CatalogAllRestaurantsBackRequested>());
    expect(intents[1], isA<CatalogAllRestaurantsSearchRequested>());
    expect(
      (intents[2] as CatalogAllRestaurantsRestaurantRequested).restaurantId,
      201,
    );
  });
}
