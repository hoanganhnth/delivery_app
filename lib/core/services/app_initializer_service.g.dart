// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_initializer_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appInitializerService)
final appInitializerServiceProvider = AppInitializerServiceProvider._();

final class AppInitializerServiceProvider
    extends
        $FunctionalProvider<
          AppInitializerService,
          AppInitializerService,
          AppInitializerService
        >
    with $Provider<AppInitializerService> {
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
  $ProviderElement<AppInitializerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppInitializerService create(Ref ref) {
    return appInitializerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppInitializerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppInitializerService>(value),
    );
  }
}

String _$appInitializerServiceHash() =>
    r'4891afcb9c0b22175c1469d9516c57b2c36af37b';
