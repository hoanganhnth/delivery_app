// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'non_consumable_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NonConsumableNotifier)
final nonConsumableProvider = NonConsumableNotifierProvider._();

final class NonConsumableNotifierProvider
    extends $AsyncNotifierProvider<NonConsumableNotifier, NonConsumableState> {
  NonConsumableNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nonConsumableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nonConsumableNotifierHash();

  @$internal
  @override
  NonConsumableNotifier create() => NonConsumableNotifier();
}

String _$nonConsumableNotifierHash() =>
    r'3a915946d24a727b481cbf36519aa67a2a70aa84';

abstract class _$NonConsumableNotifier
    extends $AsyncNotifier<NonConsumableState> {
  FutureOr<NonConsumableState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<NonConsumableState>, NonConsumableState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NonConsumableState>, NonConsumableState>,
              AsyncValue<NonConsumableState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
