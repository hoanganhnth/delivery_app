// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(promotionBaseUrl)
final promotionBaseUrlProvider = PromotionBaseUrlProvider._();

final class PromotionBaseUrlProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  PromotionBaseUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotionBaseUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotionBaseUrlHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return promotionBaseUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$promotionBaseUrlHash() => r'23538284bf83684f25186fdd8853a6400384d874';

@ProviderFor(promotionDataSource)
final promotionDataSourceProvider = PromotionDataSourceProvider._();

final class PromotionDataSourceProvider
    extends
        $FunctionalProvider<
          PromotionDataSource,
          PromotionDataSource,
          PromotionDataSource
        >
    with $Provider<PromotionDataSource> {
  PromotionDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotionDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotionDataSourceHash();

  @$internal
  @override
  $ProviderElement<PromotionDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PromotionDataSource create(Ref ref) {
    return promotionDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PromotionDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PromotionDataSource>(value),
    );
  }
}

String _$promotionDataSourceHash() =>
    r'44f400337e0f9fade9332bc38280f6d9f7ba9f9d';

@ProviderFor(promotionRepository)
final promotionRepositoryProvider = PromotionRepositoryProvider._();

final class PromotionRepositoryProvider
    extends
        $FunctionalProvider<
          PromotionRepository,
          PromotionRepository,
          PromotionRepository
        >
    with $Provider<PromotionRepository> {
  PromotionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotionRepositoryHash();

  @$internal
  @override
  $ProviderElement<PromotionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PromotionRepository create(Ref ref) {
    return promotionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PromotionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PromotionRepository>(value),
    );
  }
}

String _$promotionRepositoryHash() =>
    r'5baba46ecfdc83208b8a26a6c72a502b39556c7e';

@ProviderFor(CollectVoucherNotifier)
final collectVoucherProvider = CollectVoucherNotifierProvider._();

final class CollectVoucherNotifierProvider
    extends $NotifierProvider<CollectVoucherNotifier, AsyncValue<void>> {
  CollectVoucherNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectVoucherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectVoucherNotifierHash();

  @$internal
  @override
  CollectVoucherNotifier create() => CollectVoucherNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$collectVoucherNotifierHash() =>
    r'b2a453effe34528b6f2cfbeaaf8c87a1d0b3d8b5';

abstract class _$CollectVoucherNotifier extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
