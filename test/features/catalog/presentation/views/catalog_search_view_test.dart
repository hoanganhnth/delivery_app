import 'dart:async';

import 'package:delivery_app/features/catalog/application/catalog_search_effect.dart';
import 'package:delivery_app/features/catalog/application/catalog_search_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_search_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_search_view_model.dart';
import 'package:delivery_app/features/catalog/di/catalog_search_providers.dart';
import 'package:delivery_app/features/catalog/domain/catalog_search_repository.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  test(
    'search ViewModel maps both result types and ignores a stale query',
    () async {
      final repository = _FakeCatalogSearchRepository();
      final delay = _ControllableDelay();
      final container = ProviderContainer(
        overrides: [
          catalogSearchRepositoryProvider.overrideWithValue(repository),
          catalogSearchDelayProvider.overrideWithValue(delay),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(catalogSearchViewModelProvider.notifier);

      final stale = notifier.dispatch(const CatalogSearchQueryChanged('old'));
      final current = notifier.dispatch(const CatalogSearchQueryChanged('cơm'));
      delay.releaseAll();
      await Future.wait([stale, current]);

      final state = container.read(catalogSearchViewModelProvider);
      expect(state.query, 'cơm');
      expect(state.dishes.single.name, 'Cơm test');
      expect(state.restaurants.single.name, 'Bếp test');
      expect(repository.dishQueries, ['cơm']);
      expect(repository.restaurantQueries, ['cơm']);

      await notifier.dispatch(const CatalogSearchDishSelected('201'));
      final navigated = container.read(catalogSearchViewModelProvider);
      expect(
        navigated.effects.single.effect,
        isA<CatalogSearchNavigateToRestaurant>(),
      );
      await notifier.dispatch(
        CatalogSearchEffectConsumed(navigated.effects.single.id),
      );
      expect(container.read(catalogSearchViewModelProvider).effects, isEmpty);
    },
  );

  testWidgets(
    'catalog search view emits typed query, tab and selection intents',
    (tester) async {
      final intents = <CatalogSearchIntent>[];
      await pumpTestApp(
        tester,
        child: CatalogSearchView(
          state: const CatalogSearchViewState(
            query: 'cơm',
            dishes: [
              CatalogDishSearchViewData(
                id: '301',
                name: 'Cơm test',
                restaurantId: '201',
              ),
            ],
          ),
          onIntent: intents.add,
        ),
      );

      await tester.enterText(
        find.byKey(const Key('catalog_search_input')),
        'cơm sườn',
      );
      await tester.tap(find.text('Quán ăn'));
      await tester.tap(find.text('Cơm test'));
      await tester.tap(find.byKey(const Key('catalog_search_clear')));

      expect(intents[0], isA<CatalogSearchQueryChanged>());
      expect(intents[1], isA<CatalogSearchTabSelected>());
      expect(
        intents[2],
        isA<CatalogSearchDishSelected>().having(
          (intent) => intent.restaurantId,
          'restaurant ID',
          '201',
        ),
      );
      expect(intents[3], isA<CatalogSearchCleared>());
    },
  );
}

class _ControllableDelay implements CatalogSearchDelayPort {
  final _waiters = <Completer<void>>[];

  @override
  Future<void> wait() {
    final completer = Completer<void>();
    _waiters.add(completer);
    return completer.future;
  }

  void releaseAll() {
    for (final completer in _waiters) {
      if (!completer.isCompleted) completer.complete();
    }
  }
}

class _FakeCatalogSearchRepository implements CatalogSearchRepository {
  final dishQueries = <String>[];
  final restaurantQueries = <String>[];

  @override
  Future<List<CatalogDishSearchResult>> searchDishes(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    dishQueries.add(query);
    return const [
      CatalogDishSearchResult(
        id: '301',
        name: 'Cơm test',
        price: 50000,
        restaurantId: '201',
      ),
    ];
  }

  @override
  Future<List<CatalogRestaurantSearchResult>> searchRestaurants(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    restaurantQueries.add(query);
    return const [CatalogRestaurantSearchResult(id: '201', name: 'Bếp test')];
  }
}
