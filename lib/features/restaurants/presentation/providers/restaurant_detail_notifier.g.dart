// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RestaurantDetailNotifier)
final restaurantDetailProvider = RestaurantDetailNotifierProvider._();

final class RestaurantDetailNotifierProvider
    extends $NotifierProvider<RestaurantDetailNotifier, RestaurantDetailState> {
  RestaurantDetailNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantDetailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantDetailNotifierHash();

  @$internal
  @override
  RestaurantDetailNotifier create() => RestaurantDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantDetailState>(value),
    );
  }
}

String _$restaurantDetailNotifierHash() =>
    r'6302887bac94fdcf894cfa8dd6e1bb4dd9780597';

abstract class _$RestaurantDetailNotifier
    extends $Notifier<RestaurantDetailState> {
  RestaurantDetailState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RestaurantDetailState, RestaurantDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RestaurantDetailState, RestaurantDetailState>,
              RestaurantDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
