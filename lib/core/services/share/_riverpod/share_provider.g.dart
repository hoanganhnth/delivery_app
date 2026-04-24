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
        isAutoDispose: true,
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

String _$shareServiceHash() => r'9d6823c38db1ff558ed60143ab35b5d7bda525c2';
