// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Livestream list notifier

@ProviderFor(LivestreamList)
final livestreamListProvider = LivestreamListProvider._();

/// Livestream list notifier
final class LivestreamListProvider
    extends $NotifierProvider<LivestreamList, LivestreamListState> {
  /// Livestream list notifier
  LivestreamListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livestreamListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livestreamListHash();

  @$internal
  @override
  LivestreamList create() => LivestreamList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamListState>(value),
    );
  }
}

String _$livestreamListHash() => r'cbb434eb39fc7c2d6742450067144b5a11d0952c';

/// Livestream list notifier

abstract class _$LivestreamList extends $Notifier<LivestreamListState> {
  LivestreamListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LivestreamListState, LivestreamListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LivestreamListState, LivestreamListState>,
              LivestreamListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
