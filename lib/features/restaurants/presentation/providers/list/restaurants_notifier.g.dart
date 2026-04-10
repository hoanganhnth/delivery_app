// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurants_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RestaurantsNotifier)
final restaurantsProvider = RestaurantsNotifierProvider._();

final class RestaurantsNotifierProvider
    extends $NotifierProvider<RestaurantsNotifier, RestaurantsState> {
  RestaurantsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restaurantsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restaurantsNotifierHash();

  @$internal
  @override
  RestaurantsNotifier create() => RestaurantsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestaurantsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestaurantsState>(value),
    );
  }
}

String _$restaurantsNotifierHash() =>
    r'd21a1fb1f81a2b9236fc954aff9511b638800471';

abstract class _$RestaurantsNotifier extends $Notifier<RestaurantsState> {
  RestaurantsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RestaurantsState, RestaurantsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RestaurantsState, RestaurantsState>,
              RestaurantsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
