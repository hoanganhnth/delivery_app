// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agora_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod-managed AgoraService — auto-disposes with ref.onDispose
/// Family provider: one instance per livestreamId

@ProviderFor(agoraServiceForViewer)
final agoraServiceForViewerProvider = AgoraServiceForViewerFamily._();

/// Riverpod-managed AgoraService — auto-disposes with ref.onDispose
/// Family provider: one instance per livestreamId

final class AgoraServiceForViewerProvider
    extends $FunctionalProvider<IAgoraService, IAgoraService, IAgoraService>
    with $Provider<IAgoraService> {
  /// Riverpod-managed AgoraService — auto-disposes with ref.onDispose
  /// Family provider: one instance per livestreamId
  AgoraServiceForViewerProvider._({
    required AgoraServiceForViewerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'agoraServiceForViewerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$agoraServiceForViewerHash();

  @override
  String toString() {
    return r'agoraServiceForViewerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<IAgoraService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IAgoraService create(Ref ref) {
    final argument = this.argument as String;
    return agoraServiceForViewer(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IAgoraService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IAgoraService>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AgoraServiceForViewerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$agoraServiceForViewerHash() =>
    r'0a4fb217ac205498847234f3adab98faa7c72bd1';

/// Riverpod-managed AgoraService — auto-disposes with ref.onDispose
/// Family provider: one instance per livestreamId

final class AgoraServiceForViewerFamily extends $Family
    with $FunctionalFamilyOverride<IAgoraService, String> {
  AgoraServiceForViewerFamily._()
    : super(
        retry: null,
        name: r'agoraServiceForViewerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Riverpod-managed AgoraService — auto-disposes with ref.onDispose
  /// Family provider: one instance per livestreamId

  AgoraServiceForViewerProvider call(String livestreamId) =>
      AgoraServiceForViewerProvider._(argument: livestreamId, from: this);

  @override
  String toString() => r'agoraServiceForViewerProvider';
}
