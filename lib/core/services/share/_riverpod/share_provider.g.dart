// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shareService)
final shareServiceProvider = ShareServiceProvider._();

final class ShareServiceProvider
    extends $FunctionalProvider<IShareService, IShareService, IShareService>
    with $Provider<IShareService> {
  ShareServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shareServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shareServiceHash();

  @$internal
  @override
  $ProviderElement<IShareService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IShareService create(Ref ref) {
    return shareService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IShareService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IShareService>(value),
    );
  }
}

String _$shareServiceHash() => r'dd997be8115c6d3733aa4e0d7e4c9bb18dea2aae';
