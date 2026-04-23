// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iap_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for InAppPurchase instance

@ProviderFor(inAppPurchase)
final inAppPurchaseProvider = InAppPurchaseProvider._();

/// Provider for InAppPurchase instance

final class InAppPurchaseProvider
    extends $FunctionalProvider<InAppPurchase, InAppPurchase, InAppPurchase>
    with $Provider<InAppPurchase> {
  /// Provider for InAppPurchase instance
  InAppPurchaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inAppPurchaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inAppPurchaseHash();

  @$internal
  @override
  $ProviderElement<InAppPurchase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InAppPurchase create(Ref ref) {
    return inAppPurchase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InAppPurchase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InAppPurchase>(value),
    );
  }
}

String _$inAppPurchaseHash() => r'fb3c7e600ea6835241b4be249fabfd992de703ff';

/// Provider for IAP API service

@ProviderFor(iapApiService)
final iapApiServiceProvider = IapApiServiceProvider._();

/// Provider for IAP API service

final class IapApiServiceProvider
    extends $FunctionalProvider<IapApiService, IapApiService, IapApiService>
    with $Provider<IapApiService> {
  /// Provider for IAP API service
  IapApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iapApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iapApiServiceHash();

  @$internal
  @override
  $ProviderElement<IapApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IapApiService create(Ref ref) {
    return iapApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IapApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IapApiService>(value),
    );
  }
}

String _$iapApiServiceHash() => r'55502956d0604743edc0b5ee3e5a8e415a1de22e';

/// Provider for IAP remote data source

@ProviderFor(iapRemoteDataSource)
final iapRemoteDataSourceProvider = IapRemoteDataSourceProvider._();

/// Provider for IAP remote data source

final class IapRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          IapRemoteDataSource,
          IapRemoteDataSource,
          IapRemoteDataSource
        >
    with $Provider<IapRemoteDataSource> {
  /// Provider for IAP remote data source
  IapRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iapRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iapRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<IapRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IapRemoteDataSource create(Ref ref) {
    return iapRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IapRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IapRemoteDataSource>(value),
    );
  }
}

String _$iapRemoteDataSourceHash() =>
    r'56fd0ca8f111d95d008a28b3dcccd111d6f87e71';

/// Provider for IAP repository

@ProviderFor(iapRepository)
final iapRepositoryProvider = IapRepositoryProvider._();

/// Provider for IAP repository

final class IapRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<IapRepository>,
          IapRepository,
          FutureOr<IapRepository>
        >
    with $FutureModifier<IapRepository>, $FutureProvider<IapRepository> {
  /// Provider for IAP repository
  IapRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iapRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iapRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<IapRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IapRepository> create(Ref ref) {
    return iapRepository(ref);
  }
}

String _$iapRepositoryHash() => r'273bf9c0f19d638299d912dab5d61edd887a39fd';

/// Provider for GetSubscriptionTiersUseCase

@ProviderFor(getSubscriptionTiersUseCase)
final getSubscriptionTiersUseCaseProvider =
    GetSubscriptionTiersUseCaseProvider._();

/// Provider for GetSubscriptionTiersUseCase

final class GetSubscriptionTiersUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetSubscriptionTiersUseCase>,
          GetSubscriptionTiersUseCase,
          FutureOr<GetSubscriptionTiersUseCase>
        >
    with
        $FutureModifier<GetSubscriptionTiersUseCase>,
        $FutureProvider<GetSubscriptionTiersUseCase> {
  /// Provider for GetSubscriptionTiersUseCase
  GetSubscriptionTiersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSubscriptionTiersUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSubscriptionTiersUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetSubscriptionTiersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetSubscriptionTiersUseCase> create(Ref ref) {
    return getSubscriptionTiersUseCase(ref);
  }
}

String _$getSubscriptionTiersUseCaseHash() =>
    r'52c66f3a6ff7ead834d07897d0b8a8fd307298d6';

/// Provider for GetActiveSubscriptionUseCase

@ProviderFor(getActiveSubscriptionUseCase)
final getActiveSubscriptionUseCaseProvider =
    GetActiveSubscriptionUseCaseProvider._();

/// Provider for GetActiveSubscriptionUseCase

final class GetActiveSubscriptionUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetActiveSubscriptionUseCase>,
          GetActiveSubscriptionUseCase,
          FutureOr<GetActiveSubscriptionUseCase>
        >
    with
        $FutureModifier<GetActiveSubscriptionUseCase>,
        $FutureProvider<GetActiveSubscriptionUseCase> {
  /// Provider for GetActiveSubscriptionUseCase
  GetActiveSubscriptionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getActiveSubscriptionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getActiveSubscriptionUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetActiveSubscriptionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetActiveSubscriptionUseCase> create(Ref ref) {
    return getActiveSubscriptionUseCase(ref);
  }
}

String _$getActiveSubscriptionUseCaseHash() =>
    r'7383b10f5fa434316289a16b35a4fc0977be88e1';

/// Provider for PurchaseSubscriptionUseCase

@ProviderFor(purchaseSubscriptionUseCase)
final purchaseSubscriptionUseCaseProvider =
    PurchaseSubscriptionUseCaseProvider._();

/// Provider for PurchaseSubscriptionUseCase

final class PurchaseSubscriptionUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<PurchaseSubscriptionUseCase>,
          PurchaseSubscriptionUseCase,
          FutureOr<PurchaseSubscriptionUseCase>
        >
    with
        $FutureModifier<PurchaseSubscriptionUseCase>,
        $FutureProvider<PurchaseSubscriptionUseCase> {
  /// Provider for PurchaseSubscriptionUseCase
  PurchaseSubscriptionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseSubscriptionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseSubscriptionUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<PurchaseSubscriptionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PurchaseSubscriptionUseCase> create(Ref ref) {
    return purchaseSubscriptionUseCase(ref);
  }
}

String _$purchaseSubscriptionUseCaseHash() =>
    r'c1b28e1f4947d6bf90597c4613e249e5009b49af';

/// Provider for RestorePurchasesUseCase

@ProviderFor(restorePurchasesUseCase)
final restorePurchasesUseCaseProvider = RestorePurchasesUseCaseProvider._();

/// Provider for RestorePurchasesUseCase

final class RestorePurchasesUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<RestorePurchasesUseCase>,
          RestorePurchasesUseCase,
          FutureOr<RestorePurchasesUseCase>
        >
    with
        $FutureModifier<RestorePurchasesUseCase>,
        $FutureProvider<RestorePurchasesUseCase> {
  /// Provider for RestorePurchasesUseCase
  RestorePurchasesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restorePurchasesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restorePurchasesUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<RestorePurchasesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RestorePurchasesUseCase> create(Ref ref) {
    return restorePurchasesUseCase(ref);
  }
}

String _$restorePurchasesUseCaseHash() =>
    r'227792779bae293271b13ee387826641bd1f75ed';

/// Provider for GetConsumableProductsUseCase

@ProviderFor(getConsumableProductsUseCase)
final getConsumableProductsUseCaseProvider =
    GetConsumableProductsUseCaseProvider._();

/// Provider for GetConsumableProductsUseCase

final class GetConsumableProductsUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetConsumableProductsUseCase>,
          GetConsumableProductsUseCase,
          FutureOr<GetConsumableProductsUseCase>
        >
    with
        $FutureModifier<GetConsumableProductsUseCase>,
        $FutureProvider<GetConsumableProductsUseCase> {
  /// Provider for GetConsumableProductsUseCase
  GetConsumableProductsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getConsumableProductsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getConsumableProductsUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetConsumableProductsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetConsumableProductsUseCase> create(Ref ref) {
    return getConsumableProductsUseCase(ref);
  }
}

String _$getConsumableProductsUseCaseHash() =>
    r'6f8020fa458c75c6c7c6a8b089ea831f4a8f834d';

/// Provider for PurchaseConsumableUseCase

@ProviderFor(purchaseConsumableUseCase)
final purchaseConsumableUseCaseProvider = PurchaseConsumableUseCaseProvider._();

/// Provider for PurchaseConsumableUseCase

final class PurchaseConsumableUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<PurchaseConsumableUseCase>,
          PurchaseConsumableUseCase,
          FutureOr<PurchaseConsumableUseCase>
        >
    with
        $FutureModifier<PurchaseConsumableUseCase>,
        $FutureProvider<PurchaseConsumableUseCase> {
  /// Provider for PurchaseConsumableUseCase
  PurchaseConsumableUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseConsumableUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseConsumableUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<PurchaseConsumableUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PurchaseConsumableUseCase> create(Ref ref) {
    return purchaseConsumableUseCase(ref);
  }
}

String _$purchaseConsumableUseCaseHash() =>
    r'b18c47535210dac75e68189a4531f0e992ab5fb6';

/// Provider for GetUserCreditsUseCase

@ProviderFor(getUserCreditsUseCase)
final getUserCreditsUseCaseProvider = GetUserCreditsUseCaseProvider._();

/// Provider for GetUserCreditsUseCase

final class GetUserCreditsUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetUserCreditsUseCase>,
          GetUserCreditsUseCase,
          FutureOr<GetUserCreditsUseCase>
        >
    with
        $FutureModifier<GetUserCreditsUseCase>,
        $FutureProvider<GetUserCreditsUseCase> {
  /// Provider for GetUserCreditsUseCase
  GetUserCreditsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserCreditsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserCreditsUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetUserCreditsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetUserCreditsUseCase> create(Ref ref) {
    return getUserCreditsUseCase(ref);
  }
}

String _$getUserCreditsUseCaseHash() =>
    r'637da1eb155b7d042e4b724a97076ad9f90f442a';

/// Provider for AddCreditsUseCase

@ProviderFor(addCreditsUseCase)
final addCreditsUseCaseProvider = AddCreditsUseCaseProvider._();

/// Provider for AddCreditsUseCase

final class AddCreditsUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<AddCreditsUseCase>,
          AddCreditsUseCase,
          FutureOr<AddCreditsUseCase>
        >
    with
        $FutureModifier<AddCreditsUseCase>,
        $FutureProvider<AddCreditsUseCase> {
  /// Provider for AddCreditsUseCase
  AddCreditsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addCreditsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addCreditsUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<AddCreditsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AddCreditsUseCase> create(Ref ref) {
    return addCreditsUseCase(ref);
  }
}

String _$addCreditsUseCaseHash() => r'f5c6e47e2178411e9fd39c7013c4514e54dc222e';

/// Provider for DeductCreditsUseCase

@ProviderFor(deductCreditsUseCase)
final deductCreditsUseCaseProvider = DeductCreditsUseCaseProvider._();

/// Provider for DeductCreditsUseCase

final class DeductCreditsUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeductCreditsUseCase>,
          DeductCreditsUseCase,
          FutureOr<DeductCreditsUseCase>
        >
    with
        $FutureModifier<DeductCreditsUseCase>,
        $FutureProvider<DeductCreditsUseCase> {
  /// Provider for DeductCreditsUseCase
  DeductCreditsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deductCreditsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deductCreditsUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<DeductCreditsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeductCreditsUseCase> create(Ref ref) {
    return deductCreditsUseCase(ref);
  }
}

String _$deductCreditsUseCaseHash() =>
    r'9bab0450efdc7b7419ee8350e7aed1c7e0474012';

/// Provider for GetNonConsumableProductsUseCase

@ProviderFor(getNonConsumableProductsUseCase)
final getNonConsumableProductsUseCaseProvider =
    GetNonConsumableProductsUseCaseProvider._();

/// Provider for GetNonConsumableProductsUseCase

final class GetNonConsumableProductsUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetNonConsumableProductsUseCase>,
          GetNonConsumableProductsUseCase,
          FutureOr<GetNonConsumableProductsUseCase>
        >
    with
        $FutureModifier<GetNonConsumableProductsUseCase>,
        $FutureProvider<GetNonConsumableProductsUseCase> {
  /// Provider for GetNonConsumableProductsUseCase
  GetNonConsumableProductsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getNonConsumableProductsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getNonConsumableProductsUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetNonConsumableProductsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetNonConsumableProductsUseCase> create(Ref ref) {
    return getNonConsumableProductsUseCase(ref);
  }
}

String _$getNonConsumableProductsUseCaseHash() =>
    r'05334eea85dc601b8545cfc94c30c35c546596df';

/// Provider for PurchaseNonConsumableUseCase

@ProviderFor(purchaseNonConsumableUseCase)
final purchaseNonConsumableUseCaseProvider =
    PurchaseNonConsumableUseCaseProvider._();

/// Provider for PurchaseNonConsumableUseCase

final class PurchaseNonConsumableUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<PurchaseNonConsumableUseCase>,
          PurchaseNonConsumableUseCase,
          FutureOr<PurchaseNonConsumableUseCase>
        >
    with
        $FutureModifier<PurchaseNonConsumableUseCase>,
        $FutureProvider<PurchaseNonConsumableUseCase> {
  /// Provider for PurchaseNonConsumableUseCase
  PurchaseNonConsumableUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseNonConsumableUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseNonConsumableUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<PurchaseNonConsumableUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PurchaseNonConsumableUseCase> create(Ref ref) {
    return purchaseNonConsumableUseCase(ref);
  }
}

String _$purchaseNonConsumableUseCaseHash() =>
    r'cd8c37ad87f0b68b830e5ddc65d3cde1a74e6775';

/// Provider for GetUnlockedFeaturesUseCase

@ProviderFor(getUnlockedFeaturesUseCase)
final getUnlockedFeaturesUseCaseProvider =
    GetUnlockedFeaturesUseCaseProvider._();

/// Provider for GetUnlockedFeaturesUseCase

final class GetUnlockedFeaturesUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetUnlockedFeaturesUseCase>,
          GetUnlockedFeaturesUseCase,
          FutureOr<GetUnlockedFeaturesUseCase>
        >
    with
        $FutureModifier<GetUnlockedFeaturesUseCase>,
        $FutureProvider<GetUnlockedFeaturesUseCase> {
  /// Provider for GetUnlockedFeaturesUseCase
  GetUnlockedFeaturesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUnlockedFeaturesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUnlockedFeaturesUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetUnlockedFeaturesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetUnlockedFeaturesUseCase> create(Ref ref) {
    return getUnlockedFeaturesUseCase(ref);
  }
}

String _$getUnlockedFeaturesUseCaseHash() =>
    r'143b2e4e977feec8d60b17496e2f93b8875448ef';

/// Provider for CheckFeatureUnlockedUseCase

@ProviderFor(checkFeatureUnlockedUseCase)
final checkFeatureUnlockedUseCaseProvider =
    CheckFeatureUnlockedUseCaseProvider._();

/// Provider for CheckFeatureUnlockedUseCase

final class CheckFeatureUnlockedUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<CheckFeatureUnlockedUseCase>,
          CheckFeatureUnlockedUseCase,
          FutureOr<CheckFeatureUnlockedUseCase>
        >
    with
        $FutureModifier<CheckFeatureUnlockedUseCase>,
        $FutureProvider<CheckFeatureUnlockedUseCase> {
  /// Provider for CheckFeatureUnlockedUseCase
  CheckFeatureUnlockedUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkFeatureUnlockedUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkFeatureUnlockedUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<CheckFeatureUnlockedUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CheckFeatureUnlockedUseCase> create(Ref ref) {
    return checkFeatureUnlockedUseCase(ref);
  }
}

String _$checkFeatureUnlockedUseCaseHash() =>
    r'7c552b5e2bd18bcb08bcb47475699b65b8003990';
