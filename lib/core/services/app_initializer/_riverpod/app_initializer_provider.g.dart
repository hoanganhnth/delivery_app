// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_initializer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The provider is the "wiring point" where Feature-layer dependencies
/// are injected into the domain-agnostic Core service.

@ProviderFor(appInitializerService)
final appInitializerServiceProvider = AppInitializerServiceProvider._();

/// The provider is the "wiring point" where Feature-layer dependencies
/// are injected into the domain-agnostic Core service.

final class AppInitializerServiceProvider
    extends
        $FunctionalProvider<
          IAppInitializerService,
          IAppInitializerService,
          IAppInitializerService
        >
    with $Provider<IAppInitializerService> {
  /// The provider is the "wiring point" where Feature-layer dependencies
  /// are injected into the domain-agnostic Core service.
  AppInitializerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInitializerServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInitializerServiceHash();

  @$internal
  @override
  $ProviderElement<IAppInitializerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IAppInitializerService create(Ref ref) {
    return appInitializerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IAppInitializerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IAppInitializerService>(value),
    );
  }
}

String _$appInitializerServiceHash() =>
    r'ad68384385abe72ee4f1148b3f5294425e1c63a4';
