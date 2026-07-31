// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'2c146927785523a0ddf51b23b777a9be4afdc092';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchFilterTab)
final searchFilterTabProvider = SearchFilterTabProvider._();

final class SearchFilterTabProvider
    extends $NotifierProvider<SearchFilterTab, int> {
  SearchFilterTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchFilterTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchFilterTabHash();

  @$internal
  @override
  SearchFilterTab create() => SearchFilterTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$searchFilterTabHash() => r'0abaac8d50b4e91d9a4c7ddd8584513c8ac7c5e6';

abstract class _$SearchFilterTab extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(searchDishesResults)
final searchDishesResultsProvider = SearchDishesResultsProvider._();

final class SearchDishesResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DishSearchResult>>,
          List<DishSearchResult>,
          FutureOr<List<DishSearchResult>>
        >
    with
        $FutureModifier<List<DishSearchResult>>,
        $FutureProvider<List<DishSearchResult>> {
  SearchDishesResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchDishesResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchDishesResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<DishSearchResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DishSearchResult>> create(Ref ref) {
    return searchDishesResults(ref);
  }
}

String _$searchDishesResultsHash() =>
    r'4e9e2e5a9d4d9f9920ccfb39e0127ea212e61a14';

@ProviderFor(searchRestaurantsResults)
final searchRestaurantsResultsProvider = SearchRestaurantsResultsProvider._();

final class SearchRestaurantsResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RestaurantSearchResult>>,
          List<RestaurantSearchResult>,
          FutureOr<List<RestaurantSearchResult>>
        >
    with
        $FutureModifier<List<RestaurantSearchResult>>,
        $FutureProvider<List<RestaurantSearchResult>> {
  SearchRestaurantsResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRestaurantsResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRestaurantsResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<RestaurantSearchResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RestaurantSearchResult>> create(Ref ref) {
    return searchRestaurantsResults(ref);
  }
}

String _$searchRestaurantsResultsHash() =>
    r'f957eb9dcc5be3a2995d31ecad7d0576e5425962';
