// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_tracking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier để quản lý delivery tracking

@ProviderFor(DeliveryTracking)
final deliveryTrackingProvider = DeliveryTrackingProvider._();

/// Notifier để quản lý delivery tracking
final class DeliveryTrackingProvider
    extends $NotifierProvider<DeliveryTracking, DeliveryTrackingState> {
  /// Notifier để quản lý delivery tracking
  DeliveryTrackingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deliveryTrackingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deliveryTrackingHash();

  @$internal
  @override
  DeliveryTracking create() => DeliveryTracking();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeliveryTrackingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeliveryTrackingState>(value),
    );
  }
}

String _$deliveryTrackingHash() => r'074a2c8e4bad412734160dbef58fce96f77b1507';

/// Notifier để quản lý delivery tracking

abstract class _$DeliveryTracking extends $Notifier<DeliveryTrackingState> {
  DeliveryTrackingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DeliveryTrackingState, DeliveryTrackingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DeliveryTrackingState, DeliveryTrackingState>,
              DeliveryTrackingState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
