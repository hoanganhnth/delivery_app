// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_interaction_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Livestream interaction notifier — manages comments and likes via Firebase

@ProviderFor(LivestreamInteraction)
final livestreamInteractionProvider = LivestreamInteractionFamily._();

/// Livestream interaction notifier — manages comments and likes via Firebase
final class LivestreamInteractionProvider
    extends
        $NotifierProvider<LivestreamInteraction, LivestreamInteractionState> {
  /// Livestream interaction notifier — manages comments and likes via Firebase
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
    r'b9f30610321a52ee99176b34610a89cfebb5fc13';

/// Livestream interaction notifier — manages comments and likes via Firebase

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

  /// Livestream interaction notifier — manages comments and likes via Firebase

  LivestreamInteractionProvider call(num id) =>
      LivestreamInteractionProvider._(argument: id, from: this);

  @override
  String toString() => r'livestreamInteractionProvider';
}

/// Livestream interaction notifier — manages comments and likes via Firebase

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
