import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
import 'catalog_home_view_model.dart';
import 'home_suggested_dish.dart';

/// Bounded lookup over already-loaded featured restaurants; never mock API IDs.
final homeSuggestedDishesProvider = FutureProvider<List<HomeSuggestedDish>>((
  ref,
) async {
  final restaurants = ref.watch(
    catalogHomeViewModelProvider.select((state) => state.restaurants),
  );
  final port = ref.watch(catalogMenuLookupPortProvider);
  final groups = await Future.wait(
    restaurants.take(4).map((restaurant) async {
      try {
        final menu = await port.menuItems(restaurant.id.toInt());
        return menu
            .where(
              (item) =>
                  item.status == CatalogMenuStatus.available &&
                  item.price > 0 &&
                  item.imageUrl?.isNotEmpty == true,
            )
            .take(1)
            .map(
              (item) => HomeSuggestedDish(
                name: item.name,
                image: item.imageUrl!,
                price: item.price,
                restaurantId: restaurant.id,
              ),
            )
            .toList();
      } catch (_) {
        // Optional Home discovery must not break the real catalog or checkout.
        return <HomeSuggestedDish>[];
      }
    }),
  );
  return groups.expand((items) => items).toList(growable: false);
});
