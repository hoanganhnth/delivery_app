// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubscriptionNotifier)
final subscriptionProvider = SubscriptionNotifierProvider._();

final class SubscriptionNotifierProvider
    extends $NotifierProvider<SubscriptionNotifier, SubscriptionState> {
  SubscriptionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionNotifierHash();

  @$internal
  @override
  SubscriptionNotifier create() => SubscriptionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubscriptionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubscriptionState>(value),
    );
  }
}

String _$subscriptionNotifierHash() =>
    r'22650bd07fabb098b1013dfd84ab76d55aef4cb3';

abstract class _$SubscriptionNotifier extends $Notifier<SubscriptionState> {
  SubscriptionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SubscriptionState, SubscriptionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SubscriptionState, SubscriptionState>,
              SubscriptionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
