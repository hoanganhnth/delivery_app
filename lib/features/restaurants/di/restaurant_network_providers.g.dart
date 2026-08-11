// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_network_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(restaurantApiService)
final restaurantApiServiceProvider = RestaurantApiServiceProvider._();

final class RestaurantApiServiceProvider
    extends
        $FunctionalProvider<
          RestaurantApiService,
          RestaurantApiService,
          RestaurantApiService
        >
    with $Provider<RestaurantApiService> {
  RestaurantApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantApiServiceHash();

  @$internal
  @override
  $ProviderElement<RestaurantApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantApiService create(Ref ref) {
    return restaurantApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantApiService>(value),
    );
  }
}

String _$restaurantApiServiceHash() =>
    r'2ac75f26c8a6db727e183bed72477ee350e4c447';

@ProviderFor(restaurantRemoteDataSource)
final restaurantRemoteDataSourceProvider =
    RestaurantRemoteDataSourceProvider._();

final class RestaurantRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          RestaurantRemoteDataSource,
          RestaurantRemoteDataSource,
          RestaurantRemoteDataSource
        >
    with $Provider<RestaurantRemoteDataSource> {
  RestaurantRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<RestaurantRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RestaurantRemoteDataSource create(Ref ref) {
    return restaurantRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantRemoteDataSource>(value),
    );
  }
}

String _$restaurantRemoteDataSourceHash() =>
    r'129c4395fbe86199ce06fe2730a0f23bd2894414';
