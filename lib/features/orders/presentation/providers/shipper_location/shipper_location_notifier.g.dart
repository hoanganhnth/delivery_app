// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_location_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier để quản lý shipper location tracking

@ProviderFor(ShipperLocation)
final shipperLocationProvider = ShipperLocationProvider._();

/// Notifier để quản lý shipper location tracking
final class ShipperLocationProvider
    extends $NotifierProvider<ShipperLocation, ShipperLocationState> {
  /// Notifier để quản lý shipper location tracking
  ShipperLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shipperLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shipperLocationHash();

  @$internal
  @override
  ShipperLocation create() => ShipperLocation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShipperLocationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShipperLocationState>(value),
    );
  }
}

String _$shipperLocationHash() => r'c20537a323fbb227f46f1e83dee1c90b0df93815';

/// Notifier để quản lý shipper location tracking

abstract class _$ShipperLocation extends $Notifier<ShipperLocationState> {
  ShipperLocationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ShipperLocationState, ShipperLocationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ShipperLocationState, ShipperLocationState>,
              ShipperLocationState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
