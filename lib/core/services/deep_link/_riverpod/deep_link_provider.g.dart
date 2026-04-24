// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_link_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deepLinkService)
final deepLinkServiceProvider = DeepLinkServiceProvider._();

final class DeepLinkServiceProvider
    extends
        $FunctionalProvider<
          IDeepLinkService,
          IDeepLinkService,
          IDeepLinkService
        >
    with $Provider<IDeepLinkService> {
  DeepLinkServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deepLinkServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deepLinkServiceHash();

  @$internal
  @override
  $ProviderElement<IDeepLinkService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IDeepLinkService create(Ref ref) {
    return deepLinkService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IDeepLinkService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IDeepLinkService>(value),
    );
  }
}

String _$deepLinkServiceHash() => r'09d94a5c50cae93fa01d0be75bf684a1aa7a15c1';
