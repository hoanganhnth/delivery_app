// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_initializer_provider.dart';

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
          IAppInitializerService,
          IAppInitializerService,
          IAppInitializerService
        >
    with $Provider<IAppInitializerService> {
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
    r'9507d4c5a3c4b982377f4ccef3a6300edbfc4e97';
