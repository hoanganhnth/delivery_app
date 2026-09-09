import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_home_components.dart';
import 'package:delivery_app/features/catalog/presentation/components/catalog_restaurant_detail_parts.dart';
import 'package:delivery_app/features/catalog/presentation/pages/catalog_restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('restaurant row has compact thumbnail alongside its name', (
    tester,
  ) async {
    var opened = false;
    await pumpTestApp(
      tester,
      child: CatalogRestaurantCard(
        restaurant: const CatalogRestaurantViewData(
          id: 1,
          name: 'Real restaurant',
        ),
        onTap: () => opened = true,
      ),
    );
    final photo = find.byType(AppContentImage);
    expect(tester.getSize(photo), const Size(86, 86));
    expect(
      tester.getTopLeft(find.text('Real restaurant')).dx,
      greaterThan(tester.getTopRight(photo).dx),
    );
    await tester.tap(find.text('Real restaurant'));
    expect(opened, isTrue);
  });

  testWidgets(
    'item sheet shows real detail and adds through the existing intent',
    (tester) async {
      final intents = <CatalogRestaurantDetailIntent>[];
      await pumpTestApp(
        tester,
        locale: const Locale('vi'),
        child: Builder(
          builder: (context) => CatalogMenuItemCard(
            item: const CatalogMenuItemViewData(
              id: 7,
              name: 'Real dish',
              description: 'Full description from the catalog',
              catalogPrice: 42000,
              availability: CatalogMenuAvailability.available,
            ),
            onIntent: intents.add,
            onOpen: () => showCatalogMenuItemSheet(
              context: context,
              item: const CatalogMenuItemViewData(
                id: 7,
                name: 'Real dish',
                description: 'Full description from the catalog',
                catalogPrice: 42000,
                availability: CatalogMenuAvailability.available,
              ),
              onAdd: () => intents.add(
                const CatalogRestaurantDetailIncrementRequested(7),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Real dish'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('Full description from the catalog'), findsNWidgets(2));
      await tester.tap(find.byKey(const Key('catalog_item_sheet_add')));
      await tester.pumpAndSettle();
      expect(intents.single, isA<CatalogRestaurantDetailIncrementRequested>());
      expect(
        (intents.single as CatalogRestaurantDetailIncrementRequested)
            .menuItemId,
        7,
      );
      expect(find.byType(BottomSheet), findsNothing);
    },
  );

}
