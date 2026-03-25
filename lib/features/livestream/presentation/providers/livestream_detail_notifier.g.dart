// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Livestream detail notifier

@ProviderFor(LivestreamDetail)
final livestreamDetailProvider = LivestreamDetailFamily._();

/// Livestream detail notifier
final class LivestreamDetailProvider
    extends $NotifierProvider<LivestreamDetail, LivestreamDetailState> {
  /// Livestream detail notifier
  LivestreamDetailProvider._({
    required LivestreamDetailFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'livestreamDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$livestreamDetailHash();

  @override
  String toString() {
    return r'livestreamDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LivestreamDetail create() => LivestreamDetail();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LivestreamDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$livestreamDetailHash() => r'c41ce49304f49d8f39f0dc1e5f66e42a57830349';

/// Livestream detail notifier

final class LivestreamDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          LivestreamDetail,
          LivestreamDetailState,
          LivestreamDetailState,
          LivestreamDetailState,
          num
        > {
  LivestreamDetailFamily._()
    : super(
        retry: null,
        name: r'livestreamDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Livestream detail notifier

  LivestreamDetailProvider call(num id) =>
      LivestreamDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'livestreamDetailProvider';
}

/// Livestream detail notifier

abstract class _$LivestreamDetail extends $Notifier<LivestreamDetailState> {
  late final _$args = ref.$arg as num;
  num get id => _$args;

  LivestreamDetailState build(num id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LivestreamDetailState, LivestreamDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LivestreamDetailState, LivestreamDetailState>,
              LivestreamDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Livestream interaction notifier

@ProviderFor(LivestreamInteraction)
final livestreamInteractionProvider = LivestreamInteractionFamily._();

/// Livestream interaction notifier
final class LivestreamInteractionProvider
    extends
        $NotifierProvider<LivestreamInteraction, LivestreamInteractionState> {
  /// Livestream interaction notifier
  LivestreamInteractionProvider._({
    required LivestreamInteractionFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'livestreamInteractionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$livestreamInteractionHash();

  @override
  String toString() {
    return r'livestreamInteractionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LivestreamInteraction create() => LivestreamInteraction();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamInteractionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamInteractionState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LivestreamInteractionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$livestreamInteractionHash() =>
    r'bf8f78f08b2e41df070e809450b0278350dad525';

/// Livestream interaction notifier

final class LivestreamInteractionFamily extends $Family
    with
        $ClassFamilyOverride<
          LivestreamInteraction,
          LivestreamInteractionState,
          LivestreamInteractionState,
          LivestreamInteractionState,
          num
        > {
  LivestreamInteractionFamily._()
    : super(
        retry: null,
        name: r'livestreamInteractionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Livestream interaction notifier

  LivestreamInteractionProvider call(num id) =>
      LivestreamInteractionProvider._(argument: id, from: this);

  @override
  String toString() => r'livestreamInteractionProvider';
}

/// Livestream interaction notifier

abstract class _$LivestreamInteraction
    extends $Notifier<LivestreamInteractionState> {
  late final _$args = ref.$arg as num;
  num get id => _$args;

  LivestreamInteractionState build(num id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<LivestreamInteractionState, LivestreamInteractionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                LivestreamInteractionState,
                LivestreamInteractionState
              >,
              LivestreamInteractionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
