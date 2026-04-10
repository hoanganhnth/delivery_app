// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_viewer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Orchestrates the entire viewer join flow:
/// Load Detail → Join API → Init Agora → Join Channel
///
/// Screen only needs: ref.watch(livestreamViewerProvider(id))

@ProviderFor(LivestreamViewer)
final livestreamViewerProvider = LivestreamViewerFamily._();

/// Orchestrates the entire viewer join flow:
/// Load Detail → Join API → Init Agora → Join Channel
///
/// Screen only needs: ref.watch(livestreamViewerProvider(id))
final class LivestreamViewerProvider
    extends $NotifierProvider<LivestreamViewer, LivestreamViewerState> {
  /// Orchestrates the entire viewer join flow:
  /// Load Detail → Join API → Init Agora → Join Channel
  ///
  /// Screen only needs: ref.watch(livestreamViewerProvider(id))
  LivestreamViewerProvider._({
    required LivestreamViewerFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'livestreamViewerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$livestreamViewerHash();

  @override
  String toString() {
    return r'livestreamViewerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LivestreamViewer create() => LivestreamViewer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamViewerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamViewerState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LivestreamViewerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$livestreamViewerHash() => r'0bcccd48b4f2fc4959279c9cce8dfed40232022b';

/// Orchestrates the entire viewer join flow:
/// Load Detail → Join API → Init Agora → Join Channel
///
/// Screen only needs: ref.watch(livestreamViewerProvider(id))

final class LivestreamViewerFamily extends $Family
    with
        $ClassFamilyOverride<
          LivestreamViewer,
          LivestreamViewerState,
          LivestreamViewerState,
          LivestreamViewerState,
          num
        > {
  LivestreamViewerFamily._()
    : super(
        retry: null,
        name: r'livestreamViewerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Orchestrates the entire viewer join flow:
  /// Load Detail → Join API → Init Agora → Join Channel
  ///
  /// Screen only needs: ref.watch(livestreamViewerProvider(id))

  LivestreamViewerProvider call(num livestreamId) =>
      LivestreamViewerProvider._(argument: livestreamId, from: this);

  @override
  String toString() => r'livestreamViewerProvider';
}

/// Orchestrates the entire viewer join flow:
/// Load Detail → Join API → Init Agora → Join Channel
///
/// Screen only needs: ref.watch(livestreamViewerProvider(id))

abstract class _$LivestreamViewer extends $Notifier<LivestreamViewerState> {
  late final _$args = ref.$arg as num;
  num get livestreamId => _$args;

  LivestreamViewerState build(num livestreamId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LivestreamViewerState, LivestreamViewerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LivestreamViewerState, LivestreamViewerState>,
              LivestreamViewerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
