// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_vouchers_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedVouchersNotifier)
final selectedVouchersProvider = SelectedVouchersNotifierProvider._();

final class SelectedVouchersNotifierProvider
    extends $NotifierProvider<SelectedVouchersNotifier, List<int>> {
  SelectedVouchersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedVouchersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedVouchersNotifierHash();

  @$internal
  @override
  SelectedVouchersNotifier create() => SelectedVouchersNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<int>>(value),
    );
  }
}

String _$selectedVouchersNotifierHash() =>
    r'b21de406a53f74e64517862b59b252bd36332158';

abstract class _$SelectedVouchersNotifier extends $Notifier<List<int>> {
  List<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<int>, List<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<int>, List<int>>,
              List<int>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
