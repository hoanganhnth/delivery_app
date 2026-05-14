// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_sale_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// API Service provider

@ProviderFor(flashSaleApiService)
final flashSaleApiServiceProvider = FlashSaleApiServiceProvider._();

/// API Service provider

final class FlashSaleApiServiceProvider
    extends
        $FunctionalProvider<
          FlashSaleApiService,
          FlashSaleApiService,
          FlashSaleApiService
        >
    with $Provider<FlashSaleApiService> {
  /// API Service provider
  FlashSaleApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flashSaleApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flashSaleApiServiceHash();

  @$internal
  @override
  $ProviderElement<FlashSaleApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlashSaleApiService create(Ref ref) {
    return flashSaleApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlashSaleApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlashSaleApiService>(value),
    );
  }
}

String _$flashSaleApiServiceHash() =>
    r'66d606446096a853a49bbd91560664c9afeddc67';

/// Repository provider

@ProviderFor(flashSaleRepository)
final flashSaleRepositoryProvider = FlashSaleRepositoryProvider._();

/// Repository provider

final class FlashSaleRepositoryProvider
    extends
        $FunctionalProvider<
          FlashSaleRepository,
          FlashSaleRepository,
          FlashSaleRepository
        >
    with $Provider<FlashSaleRepository> {
  /// Repository provider
  FlashSaleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flashSaleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flashSaleRepositoryHash();

  @$internal
  @override
  $ProviderElement<FlashSaleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlashSaleRepository create(Ref ref) {
    return flashSaleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlashSaleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlashSaleRepository>(value),
    );
  }
}

String _$flashSaleRepositoryHash() =>
    r'8ff5f1203ab079de16085a46be31b12808c37b8b';

/// Lấy danh sách campaign active

@ProviderFor(getActiveCampaignsUseCase)
final getActiveCampaignsUseCaseProvider = GetActiveCampaignsUseCaseProvider._();

/// Lấy danh sách campaign active

final class GetActiveCampaignsUseCaseProvider
    extends
        $FunctionalProvider<
          GetActiveCampaignsUseCase,
          GetActiveCampaignsUseCase,
          GetActiveCampaignsUseCase
        >
    with $Provider<GetActiveCampaignsUseCase> {
  /// Lấy danh sách campaign active
  GetActiveCampaignsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getActiveCampaignsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getActiveCampaignsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetActiveCampaignsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetActiveCampaignsUseCase create(Ref ref) {
    return getActiveCampaignsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetActiveCampaignsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetActiveCampaignsUseCase>(value),
    );
  }
}

String _$getActiveCampaignsUseCaseHash() =>
    r'0250b829e61c7e6ead455002824517259a80d24a';

/// Lấy danh sách item trong campaign

@ProviderFor(getCampaignItemsUseCase)
final getCampaignItemsUseCaseProvider = GetCampaignItemsUseCaseProvider._();

/// Lấy danh sách item trong campaign

final class GetCampaignItemsUseCaseProvider
    extends
        $FunctionalProvider<
          GetCampaignItemsUseCase,
          GetCampaignItemsUseCase,
          GetCampaignItemsUseCase
        >
    with $Provider<GetCampaignItemsUseCase> {
  /// Lấy danh sách item trong campaign
  GetCampaignItemsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCampaignItemsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCampaignItemsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCampaignItemsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCampaignItemsUseCase create(Ref ref) {
    return getCampaignItemsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCampaignItemsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCampaignItemsUseCase>(value),
    );
  }
}

String _$getCampaignItemsUseCaseHash() =>
    r'1448d88ee07656adbd0ea44e119a5917d6f7ebd2';
