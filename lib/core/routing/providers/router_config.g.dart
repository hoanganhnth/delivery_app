// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Router configuration provider.
/// Wiring point: selects the correct config based on environment.

@ProviderFor(routerConfig)
final routerConfigProvider = RouterConfigProvider._();

/// Router configuration provider.
/// Wiring point: selects the correct config based on environment.

final class RouterConfigProvider
    extends
        $FunctionalProvider<AppRouterConfig, AppRouterConfig, AppRouterConfig>
    with $Provider<AppRouterConfig> {
  /// Router configuration provider.
  /// Wiring point: selects the correct config based on environment.
  RouterConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerConfigHash();

  @$internal
  @override
  $ProviderElement<AppRouterConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouterConfig create(Ref ref) {
    return routerConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouterConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouterConfig>(value),
    );
  }
}

String _$routerConfigHash() => r'3876716f39d9e861d38bc70013f19d8f30febd5a';

/// Development router config

@ProviderFor(devRouterConfig)
final devRouterConfigProvider = DevRouterConfigProvider._();

/// Development router config

final class DevRouterConfigProvider
    extends
        $FunctionalProvider<AppRouterConfig, AppRouterConfig, AppRouterConfig>
    with $Provider<AppRouterConfig> {
  /// Development router config
  DevRouterConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devRouterConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devRouterConfigHash();

  @$internal
  @override
  $ProviderElement<AppRouterConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouterConfig create(Ref ref) {
    return devRouterConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouterConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouterConfig>(value),
    );
  }
}

String _$devRouterConfigHash() => r'eae74a28c10c3a2e0596ee32ec9e543167113344';

/// Production router config

@ProviderFor(prodRouterConfig)
final prodRouterConfigProvider = ProdRouterConfigProvider._();

/// Production router config

final class ProdRouterConfigProvider
    extends
        $FunctionalProvider<AppRouterConfig, AppRouterConfig, AppRouterConfig>
    with $Provider<AppRouterConfig> {
  /// Production router config
  ProdRouterConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prodRouterConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prodRouterConfigHash();

  @$internal
  @override
  $ProviderElement<AppRouterConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouterConfig create(Ref ref) {
    return prodRouterConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouterConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouterConfig>(value),
    );
  }
}

String _$prodRouterConfigHash() => r'e69ee17e8ab6a4f42bf2f28391d7a476c6b8da3b';

/// Test router config

@ProviderFor(testRouterConfig)
final testRouterConfigProvider = TestRouterConfigProvider._();

/// Test router config

final class TestRouterConfigProvider
    extends
        $FunctionalProvider<AppRouterConfig, AppRouterConfig, AppRouterConfig>
    with $Provider<AppRouterConfig> {
  /// Test router config
  TestRouterConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testRouterConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testRouterConfigHash();

  @$internal
  @override
  $ProviderElement<AppRouterConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouterConfig create(Ref ref) {
    return testRouterConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouterConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouterConfig>(value),
    );
  }
}

String _$testRouterConfigHash() => r'15ae828cf8e2373f0e87bbd72cff603774d8ea8d';
