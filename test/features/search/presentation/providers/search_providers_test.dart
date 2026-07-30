import 'package:delivery_app/features/search/data/models/search_result_model.dart';
import 'package:delivery_app/features/search/domain/repositories/search_repository.dart';
import 'package:delivery_app/features/search/presentation/providers/search_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty search performs no delay or I/O', () async {
    final repository = _FakeSearchRepository();
    final delay = _ImmediateSearchDelay();
    final container = _container(repository, delay);
    addTearDown(container.dispose);

    expect(await container.read(searchDishesResultsProvider.future), isEmpty);
    expect(await container.read(searchRestaurantsResultsProvider.future), isEmpty);
    expect(delay.calls, 0);
    expect(repository.dishQueries, isEmpty);
    expect(repository.restaurantQueries, isEmpty);
  });

  test('injected delay makes dish and restaurant search deterministic', () async {
    final repository = _FakeSearchRepository();
    final delay = _ImmediateSearchDelay();
    final container = _container(repository, delay);
    addTearDown(container.dispose);

    container.read(searchQueryProvider.notifier).setQuery('cơm');
    final dishes = await container.read(searchDishesResultsProvider.future);
    final restaurants = await container.read(
      searchRestaurantsResultsProvider.future,
    );

    expect(dishes.single.name, 'Cơm test');
    expect(restaurants.single.name, 'Bếp test');
    expect(repository.dishQueries, ['cơm']);
    expect(repository.restaurantQueries, ['cơm']);
    expect(delay.calls, 2);
  });

  test('backend search error is observable and a new query retries', () async {
    final repository = _FakeSearchRepository()..dishError = StateError('search down');
    final container = _container(repository, _ImmediateSearchDelay());
    addTearDown(container.dispose);

    container.read(searchQueryProvider.notifier).setQuery('fail');
    await expectLater(
      container.read(searchDishesResultsProvider.future),
      throwsA(isA<StateError>()),
    );

    repository.dishError = null;
    container.read(searchQueryProvider.notifier).setQuery('retry');
    final result = await container.read(searchDishesResultsProvider.future);

    expect(result.single.name, 'Cơm test');
    expect(repository.dishQueries, ['fail', 'retry']);
  });
}

ProviderContainer _container(
  _FakeSearchRepository repository,
  _ImmediateSearchDelay delay,
) {
  return ProviderContainer(
    overrides: [
      searchRepositoryProvider.overrideWithValue(repository),
      searchDelayProvider.overrideWithValue(delay),
    ],
  );
}

class _ImmediateSearchDelay implements SearchDelayPort {
  int calls = 0;

  @override
  Future<void> wait() async {
    calls += 1;
  }
}

class _FakeSearchRepository implements SearchRepository {
  final List<String> dishQueries = [];
  final List<String> restaurantQueries = [];
  Object? dishError;

  @override
  Future<List<DishSearchResult>> searchDishes(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    dishQueries.add(query);
    if (dishError != null) throw dishError!;
    return const [
      DishSearchResult(
        id: '301',
        name: 'Cơm test',
        price: 50000,
        restaurantId: '201',
      ),
    ];
  }

  @override
  Future<List<RestaurantSearchResult>> searchRestaurants(
    String query, {
    int page = 0,
    int size = 20,
  }) async {
    restaurantQueries.add(query);
    return const [
      RestaurantSearchResult(id: '201', name: 'Bếp test'),
    ];
  }
}
