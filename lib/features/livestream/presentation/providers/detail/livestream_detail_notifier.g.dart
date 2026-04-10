// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Livestream detail notifier — manages livestream metadata

@ProviderFor(LivestreamDetail)
final livestreamDetailProvider = LivestreamDetailFamily._();

/// Livestream detail notifier — manages livestream metadata
final class LivestreamDetailProvider
    extends $NotifierProvider<LivestreamDetail, LivestreamDetailState> {
  /// Livestream detail notifier — manages livestream metadata
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

String _$livestreamDetailHash() => r'a91d2d14490d720bdcc5a41400fe854c01d107b2';

/// Livestream detail notifier — manages livestream metadata

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

  /// Livestream detail notifier — manages livestream metadata

  LivestreamDetailProvider call(num id) =>
      LivestreamDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'livestreamDetailProvider';
}

/// Livestream detail notifier — manages livestream metadata

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
