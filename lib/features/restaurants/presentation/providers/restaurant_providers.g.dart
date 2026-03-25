// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(restaurantRepository)
final restaurantRepositoryProvider = RestaurantRepositoryProvider._();

final class RestaurantRepositoryProvider
    extends
        $FunctionalProvider<
          RestaurantRepository,
          RestaurantRepository,
          RestaurantRepository
        >
    with $Provider<RestaurantRepository> {
  RestaurantRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantRepositoryHash();

  @$internal
  @override
  $ProviderElement<RestaurantRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantRepository create(Ref ref) {
    return restaurantRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantRepository>(value),
    );
  }
}

String _$restaurantRepositoryHash() =>
    r'4537de33eaa22b9070683442ef67b57bb62fdc93';

@ProviderFor(getRestaurantsUseCase)
final getRestaurantsUseCaseProvider = GetRestaurantsUseCaseProvider._();

final class GetRestaurantsUseCaseProvider
    extends
        $FunctionalProvider<
          GetRestaurantsUseCase,
          GetRestaurantsUseCase,
          GetRestaurantsUseCase
        >
    with $Provider<GetRestaurantsUseCase> {
  GetRestaurantsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRestaurantsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRestaurantsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRestaurantsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRestaurantsUseCase create(Ref ref) {
    return getRestaurantsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRestaurantsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRestaurantsUseCase>(value),
    );
  }
}

String _$getRestaurantsUseCaseHash() =>
    r'05346c5164de4c6bbb29f73cd62564b49ba50593';

@ProviderFor(getRestaurantByIdUseCase)
final getRestaurantByIdUseCaseProvider = GetRestaurantByIdUseCaseProvider._();

final class GetRestaurantByIdUseCaseProvider
    extends
        $FunctionalProvider<
          GetRestaurantByIdUseCase,
          GetRestaurantByIdUseCase,
          GetRestaurantByIdUseCase
        >
    with $Provider<GetRestaurantByIdUseCase> {
  GetRestaurantByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRestaurantByIdUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRestaurantByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRestaurantByIdUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRestaurantByIdUseCase create(Ref ref) {
    return getRestaurantByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRestaurantByIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRestaurantByIdUseCase>(value),
    );
  }
}

String _$getRestaurantByIdUseCaseHash() =>
    r'35e3f73b07fb2695ed052722f52bca79ee5d60a0';

@ProviderFor(getMenuItemsUseCase)
final getMenuItemsUseCaseProvider = GetMenuItemsUseCaseProvider._();

final class GetMenuItemsUseCaseProvider
    extends
        $FunctionalProvider<
          GetMenuItemsUseCase,
          GetMenuItemsUseCase,
          GetMenuItemsUseCase
        >
    with $Provider<GetMenuItemsUseCase> {
  GetMenuItemsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMenuItemsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMenuItemsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetMenuItemsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetMenuItemsUseCase create(Ref ref) {
    return getMenuItemsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMenuItemsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMenuItemsUseCase>(value),
    );
  }
}

String _$getMenuItemsUseCaseHash() =>
    r'e27d7b1aac6bbb3a7ad49be8e3d399179c9da749';

@ProviderFor(searchRestaurantsUseCase)
final searchRestaurantsUseCaseProvider = SearchRestaurantsUseCaseProvider._();

final class SearchRestaurantsUseCaseProvider
    extends
        $FunctionalProvider<
          SearchRestaurantsUseCase,
          SearchRestaurantsUseCase,
          SearchRestaurantsUseCase
        >
    with $Provider<SearchRestaurantsUseCase> {
  SearchRestaurantsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRestaurantsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRestaurantsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SearchRestaurantsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchRestaurantsUseCase create(Ref ref) {
    return searchRestaurantsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRestaurantsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRestaurantsUseCase>(value),
    );
  }
}

String _$searchRestaurantsUseCaseHash() =>
    r'6f3d61a1be822997af37283f9da53e3728c692be';

@ProviderFor(getRestaurantsNearByUseCase)
final getRestaurantsNearByUseCaseProvider =
    GetRestaurantsNearByUseCaseProvider._();

final class GetRestaurantsNearByUseCaseProvider
    extends
        $FunctionalProvider<
          GetRestaurantsNearByUseCase,
          GetRestaurantsNearByUseCase,
          GetRestaurantsNearByUseCase
        >
    with $Provider<GetRestaurantsNearByUseCase> {
  GetRestaurantsNearByUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRestaurantsNearByUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRestaurantsNearByUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetRestaurantsNearByUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetRestaurantsNearByUseCase create(Ref ref) {
    return getRestaurantsNearByUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRestaurantsNearByUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRestaurantsNearByUseCase>(value),
    );
  }
}

String _$getRestaurantsNearByUseCaseHash() =>
    r'b3a7d1a195bbbf4ce420b7bd190ccebc4a37a66d';

@ProviderFor(featuredRestaurants)
final featuredRestaurantsProvider = FeaturedRestaurantsProvider._();

final class FeaturedRestaurantsProvider
    extends
        $FunctionalProvider<
          List<RestaurantEntity>,
          List<RestaurantEntity>,
          List<RestaurantEntity>
        >
    with $Provider<List<RestaurantEntity>> {
  FeaturedRestaurantsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredRestaurantsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredRestaurantsHash();

  @$internal
  @override
  $ProviderElement<List<RestaurantEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<RestaurantEntity> create(Ref ref) {
    return featuredRestaurants(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<RestaurantEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<RestaurantEntity>>(value),
    );
  }
}

String _$featuredRestaurantsHash() =>
    r'08ac37d3b0241b66c0667313324296c02006f2ff';

@ProviderFor(restaurantById)
final restaurantByIdProvider = RestaurantByIdFamily._();

final class RestaurantByIdProvider
    extends
        $FunctionalProvider<
          RestaurantEntity?,
          RestaurantEntity?,
          RestaurantEntity?
        >
    with $Provider<RestaurantEntity?> {
  RestaurantByIdProvider._({
    required RestaurantByIdFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'restaurantByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$restaurantByIdHash();

  @override
  String toString() {
    return r'restaurantByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<RestaurantEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantEntity? create(Ref ref) {
    final argument = this.argument as num;
    return restaurantById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantEntity?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RestaurantByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$restaurantByIdHash() => r'8c8e99fa6a9d4b18ceafd406b4452fcfd0ca942b';

final class RestaurantByIdFamily extends $Family
    with $FunctionalFamilyOverride<RestaurantEntity?, num> {
  RestaurantByIdFamily._()
    : super(
        retry: null,
        name: r'restaurantByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RestaurantByIdProvider call(num restaurantId) =>
      RestaurantByIdProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'restaurantByIdProvider';
}

@ProviderFor(menuItemsByRestaurant)
final menuItemsByRestaurantProvider = MenuItemsByRestaurantFamily._();

final class MenuItemsByRestaurantProvider
    extends
        $FunctionalProvider<
          List<MenuItemEntity>,
          List<MenuItemEntity>,
          List<MenuItemEntity>
        >
    with $Provider<List<MenuItemEntity>> {
  MenuItemsByRestaurantProvider._({
    required MenuItemsByRestaurantFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'menuItemsByRestaurantProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$menuItemsByRestaurantHash();

  @override
  String toString() {
    return r'menuItemsByRestaurantProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<MenuItemEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<MenuItemEntity> create(Ref ref) {
    final argument = this.argument as num;
    return menuItemsByRestaurant(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MenuItemEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MenuItemEntity>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MenuItemsByRestaurantProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$menuItemsByRestaurantHash() =>
    r'e64131117e40c71622a9e1d5b095c9981638d8a2';

final class MenuItemsByRestaurantFamily extends $Family
    with $FunctionalFamilyOverride<List<MenuItemEntity>, num> {
  MenuItemsByRestaurantFamily._()
    : super(
        retry: null,
        name: r'menuItemsByRestaurantProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MenuItemsByRestaurantProvider call(num restaurantId) =>
      MenuItemsByRestaurantProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'menuItemsByRestaurantProvider';
}

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

String _$searchQueryHash() => r'a2de29f344488b8b351fbfcf9c230f993798b9ea';

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

@ProviderFor(filteredRestaurants)
final filteredRestaurantsProvider = FilteredRestaurantsProvider._();

final class FilteredRestaurantsProvider
    extends
        $FunctionalProvider<
          List<RestaurantEntity>,
          List<RestaurantEntity>,
          List<RestaurantEntity>
        >
    with $Provider<List<RestaurantEntity>> {
  FilteredRestaurantsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredRestaurantsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredRestaurantsHash();

  @$internal
  @override
  $ProviderElement<List<RestaurantEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<RestaurantEntity> create(Ref ref) {
    return filteredRestaurants(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<RestaurantEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<RestaurantEntity>>(value),
    );
  }
}

String _$filteredRestaurantsHash() =>
    r'503aa3eb9e8f0e3a6ae4e101aa6380f0e3c43c88';

@ProviderFor(isLoadingRestaurants)
final isLoadingRestaurantsProvider = IsLoadingRestaurantsProvider._();

final class IsLoadingRestaurantsProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLoadingRestaurantsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoadingRestaurantsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoadingRestaurantsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoadingRestaurants(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoadingRestaurantsHash() =>
    r'8364ec98e53864036ebd0551d350e3685b6db41d';

@ProviderFor(isLoadingRestaurantDetail)
final isLoadingRestaurantDetailProvider = IsLoadingRestaurantDetailFamily._();

final class IsLoadingRestaurantDetailProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLoadingRestaurantDetailProvider._({
    required IsLoadingRestaurantDetailFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'isLoadingRestaurantDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isLoadingRestaurantDetailHash();

  @override
  String toString() {
    return r'isLoadingRestaurantDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as num;
    return isLoadingRestaurantDetail(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsLoadingRestaurantDetailProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isLoadingRestaurantDetailHash() =>
    r'88c79a5f625bb911fe7759751f666a0b4ee27683';

final class IsLoadingRestaurantDetailFamily extends $Family
    with $FunctionalFamilyOverride<bool, num> {
  IsLoadingRestaurantDetailFamily._()
    : super(
        retry: null,
        name: r'isLoadingRestaurantDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsLoadingRestaurantDetailProvider call(num restaurantId) =>
      IsLoadingRestaurantDetailProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'isLoadingRestaurantDetailProvider';
}

@ProviderFor(isLoadingSearch)
final isLoadingSearchProvider = IsLoadingSearchProvider._();

final class IsLoadingSearchProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLoadingSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoadingSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoadingSearchHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoadingSearch(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoadingSearchHash() => r'2ab55bd2ed479046ec0e960e4d5b5a8e660751b2';

@ProviderFor(isLoadingNearby)
final isLoadingNearbyProvider = IsLoadingNearbyProvider._();

final class IsLoadingNearbyProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLoadingNearbyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoadingNearbyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoadingNearbyHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoadingNearby(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoadingNearbyHash() => r'bf1c6ebc61fb440d414a6b6021158ab07972ff00';

@ProviderFor(isLoadingFeatured)
final isLoadingFeaturedProvider = IsLoadingFeaturedProvider._();

final class IsLoadingFeaturedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLoadingFeaturedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoadingFeaturedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoadingFeaturedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoadingFeatured(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoadingFeaturedHash() => r'cdcdc5d1f0ec5f5c10c0fbcbb691da9798a0fce6';

@ProviderFor(isLoadingMenu)
final isLoadingMenuProvider = IsLoadingMenuFamily._();

final class IsLoadingMenuProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLoadingMenuProvider._({
    required IsLoadingMenuFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'isLoadingMenuProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isLoadingMenuHash();

  @override
  String toString() {
    return r'isLoadingMenuProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as num;
    return isLoadingMenu(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsLoadingMenuProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isLoadingMenuHash() => r'47605eb6f9598d50bc5783dc1dc04cd99201e005';

final class IsLoadingMenuFamily extends $Family
    with $FunctionalFamilyOverride<bool, num> {
  IsLoadingMenuFamily._()
    : super(
        retry: null,
        name: r'isLoadingMenuProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsLoadingMenuProvider call(num restaurantId) =>
      IsLoadingMenuProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'isLoadingMenuProvider';
}

@ProviderFor(restaurantsError)
final restaurantsErrorProvider = RestaurantsErrorProvider._();

final class RestaurantsErrorProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  RestaurantsErrorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantsErrorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantsErrorHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return restaurantsError(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$restaurantsErrorHash() => r'7d83e479c8729394c6f4c3c65b395da28c16fec3';

@ProviderFor(restaurantDetailError)
final restaurantDetailErrorProvider = RestaurantDetailErrorFamily._();

final class RestaurantDetailErrorProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  RestaurantDetailErrorProvider._({
    required RestaurantDetailErrorFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'restaurantDetailErrorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$restaurantDetailErrorHash();

  @override
  String toString() {
    return r'restaurantDetailErrorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    final argument = this.argument as num;
    return restaurantDetailError(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RestaurantDetailErrorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$restaurantDetailErrorHash() =>
    r'e735c2870ef1d9759b33194ab173ff15cac52be7';

final class RestaurantDetailErrorFamily extends $Family
    with $FunctionalFamilyOverride<String?, num> {
  RestaurantDetailErrorFamily._()
    : super(
        retry: null,
        name: r'restaurantDetailErrorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RestaurantDetailErrorProvider call(num restaurantId) =>
      RestaurantDetailErrorProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'restaurantDetailErrorProvider';
}

@ProviderFor(hasRestaurants)
final hasRestaurantsProvider = HasRestaurantsProvider._();

final class HasRestaurantsProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  HasRestaurantsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasRestaurantsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasRestaurantsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasRestaurants(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasRestaurantsHash() => r'bb85b43390512e7d0f984621c2dc5bb8fc66e850';

@ProviderFor(hasRestaurantDetail)
final hasRestaurantDetailProvider = HasRestaurantDetailFamily._();

final class HasRestaurantDetailProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  HasRestaurantDetailProvider._({
    required HasRestaurantDetailFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'hasRestaurantDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hasRestaurantDetailHash();

  @override
  String toString() {
    return r'hasRestaurantDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as num;
    return hasRestaurantDetail(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HasRestaurantDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hasRestaurantDetailHash() =>
    r'0620680b81a8c822a6b2556eff3a264b078e7cea';

final class HasRestaurantDetailFamily extends $Family
    with $FunctionalFamilyOverride<bool, num> {
  HasRestaurantDetailFamily._()
    : super(
        retry: null,
        name: r'hasRestaurantDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HasRestaurantDetailProvider call(num restaurantId) =>
      HasRestaurantDetailProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'hasRestaurantDetailProvider';
}

@ProviderFor(hasMenuItems)
final hasMenuItemsProvider = HasMenuItemsFamily._();

final class HasMenuItemsProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  HasMenuItemsProvider._({
    required HasMenuItemsFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'hasMenuItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hasMenuItemsHash();

  @override
  String toString() {
    return r'hasMenuItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as num;
    return hasMenuItems(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HasMenuItemsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hasMenuItemsHash() => r'6992539d9d98037ed4b7de32090c6881af7c972b';

final class HasMenuItemsFamily extends $Family
    with $FunctionalFamilyOverride<bool, num> {
  HasMenuItemsFamily._()
    : super(
        retry: null,
        name: r'hasMenuItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HasMenuItemsProvider call(num restaurantId) =>
      HasMenuItemsProvider._(argument: restaurantId, from: this);

  @override
  String toString() => r'hasMenuItemsProvider';
}
