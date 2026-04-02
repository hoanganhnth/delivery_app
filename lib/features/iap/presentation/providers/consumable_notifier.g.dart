// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConsumableNotifier)
final consumableProvider = ConsumableNotifierProvider._();

final class ConsumableNotifierProvider
    extends $AsyncNotifierProvider<ConsumableNotifier, ConsumableState> {
  ConsumableNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'consumableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$consumableNotifierHash();

  @$internal
  @override
  ConsumableNotifier create() => ConsumableNotifier();
}

String _$consumableNotifierHash() =>
    r'69599dee5f0afb7bc8350ecb48a4b8cfecde7b11';

abstract class _$ConsumableNotifier extends $AsyncNotifier<ConsumableState> {
  FutureOr<ConsumableState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ConsumableState>, ConsumableState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ConsumableState>, ConsumableState>,
              AsyncValue<ConsumableState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
