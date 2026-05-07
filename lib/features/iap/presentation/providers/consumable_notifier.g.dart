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
    r'11e47d90224f8479cd0274b35d8bd3f7e823d6bb';

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
