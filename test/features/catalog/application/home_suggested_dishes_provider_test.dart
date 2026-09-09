import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_view_model.dart';
import 'package:delivery_app/features/catalog/application/home_suggested_dishes_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('suggestions use real menu fields and bounded restaurant ids', () async {
    final port = _MenuPort();
    final container = ProviderContainer(
      overrides: [
        catalogHomeViewModelProvider.overrideWith(_Home.new),
        catalogMenuLookupPortProvider.overrideWithValue(port),
      ],
    );
    addTearDown(container.dispose);
    final dishes = await container.read(homeSuggestedDishesProvider.future);
    expect(port.requested, [201]);
    expect(dishes.single.name, 'Real menu dish');
    expect(dishes.single.price, 42000);
    expect(dishes.single.restaurantId, 201);
  });
  test('optional menu failures return no API suggestions', () async {
    final container = ProviderContainer(
      overrides: [
        catalogHomeViewModelProvider.overrideWith(_Home.new),
        catalogMenuLookupPortProvider.overrideWithValue(_MenuPort(fail: true)),
      ],
    );
    addTearDown(container.dispose);
    expect(await container.read(homeSuggestedDishesProvider.future), isEmpty);
  });
}

class _Home extends CatalogHomeViewModel {
  @override
  CatalogHomeViewState build() => const CatalogHomeViewState(
    restaurants: [CatalogRestaurantViewData(id: 201, name: 'Real restaurant')],
  );
}

class _MenuPort implements CatalogMenuLookupPort {
  _MenuPort({this.fail = false});
  final bool fail;
  final requested = <int>[];
  @override
  Future<List<CatalogMenuSnapshot>> menuItems(int restaurantId) async {
    requested.add(restaurantId);
    if (fail) throw StateError('offline');
    return const [
      CatalogMenuSnapshot(
        id: 7,
        restaurantId: 201,
        name: 'Real menu dish',
        description: '',
        price: 42000,
        imageUrl: 'https://example.com/dish.png',
        status: CatalogMenuStatus.available,
      ),
    ];
  }
}
