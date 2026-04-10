// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for biometric authentication state

@ProviderFor(BiometricNotifier)
final biometricProvider = BiometricNotifierProvider._();

/// Notifier for biometric authentication state
final class BiometricNotifierProvider
    extends $NotifierProvider<BiometricNotifier, BiometricState> {
  /// Notifier for biometric authentication state
  BiometricNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricNotifierHash();

  @$internal
  @override
  BiometricNotifier create() => BiometricNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricState>(value),
    );
  }
}

String _$biometricNotifierHash() => r'a692fe4b5d71cb7b567753988e4e9dcbc15f9900';

/// Notifier for biometric authentication state

abstract class _$BiometricNotifier extends $Notifier<BiometricState> {
  BiometricState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BiometricState, BiometricState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BiometricState, BiometricState>,
              BiometricState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
