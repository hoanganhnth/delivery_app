// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Livestream list notifier

@ProviderFor(LivestreamNotifier)
final livestreamProvider = LivestreamNotifierProvider._();

/// Livestream list notifier
final class LivestreamNotifierProvider
    extends $NotifierProvider<LivestreamNotifier, LivestreamState> {
  /// Livestream list notifier
  LivestreamNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livestreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livestreamNotifierHash();

  @$internal
  @override
  LivestreamNotifier create() => LivestreamNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamState>(value),
    );
  }
}

String _$livestreamNotifierHash() =>
    r'e3c4780f4b90eec62ad8a10a7a687ba183bae5a4';

/// Livestream list notifier

abstract class _$LivestreamNotifier extends $Notifier<LivestreamState> {
  LivestreamState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LivestreamState, LivestreamState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LivestreamState, LivestreamState>,
              LivestreamState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
