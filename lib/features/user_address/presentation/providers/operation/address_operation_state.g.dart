// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_operation_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// StateNotifier for operation results

@ProviderFor(AddressOperationNotifier)
final addressOperationProvider = AddressOperationNotifierProvider._();

/// StateNotifier for operation results
final class AddressOperationNotifierProvider
    extends
        $NotifierProvider<AddressOperationNotifier, AddressOperationResult?> {
  /// StateNotifier for operation results
  AddressOperationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addressOperationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addressOperationNotifierHash();

  @$internal
  @override
  AddressOperationNotifier create() => AddressOperationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddressOperationResult? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddressOperationResult?>(value),
    );
  }
}

String _$addressOperationNotifierHash() =>
    r'5a0d473c8a10913b2d85eda32c6b32ba7daf791b';

/// StateNotifier for operation results

abstract class _$AddressOperationNotifier
    extends $Notifier<AddressOperationResult?> {
  AddressOperationResult? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AddressOperationResult?, AddressOperationResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AddressOperationResult?, AddressOperationResult?>,
              AddressOperationResult?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
