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
        isAutoDispose: true,
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

String _$inAppPurchaseHash() => r'd2388a0c220ac74d20580556be0896d1eac71cdc';

/// Provider for SharedPreferences

@ProviderFor(iapSharedPreferences)
final iapSharedPreferencesProvider = IapSharedPreferencesProvider._();

/// Provider for SharedPreferences

final class IapSharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  /// Provider for SharedPreferences
  IapSharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iapSharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iapSharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return iapSharedPreferences(ref);
  }
}

String _$iapSharedPreferencesHash() =>
    r'508379ef114da0076a377323673af24ab42f338a';

/// Provider for IAP remote data source

@ProviderFor(iapRemoteDataSource)
final iapRemoteDataSourceProvider = IapRemoteDataSourceProvider._();

/// Provider for IAP remote data source

final class IapRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<IapRemoteDataSource>,
          IapRemoteDataSource,
          FutureOr<IapRemoteDataSource>
        >
    with
        $FutureModifier<IapRemoteDataSource>,
        $FutureProvider<IapRemoteDataSource> {
  /// Provider for IAP remote data source
  IapRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iapRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iapRemoteDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<IapRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IapRemoteDataSource> create(Ref ref) {
    return iapRemoteDataSource(ref);
  }
}

String _$iapRemoteDataSourceHash() =>
    r'a8ddcc7c9abf97aea869e81372568edec77571ae';

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
        isAutoDispose: true,
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

String _$iapRepositoryHash() => r'340d1ab9a98560b3e06bf646410b722f23443816';

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
        isAutoDispose: true,
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
    r'40ef6d2c5fa2e0244fc93c8deddf720e91a865b6';

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
        isAutoDispose: true,
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
    r'f26deac31e8ceb7277e12ce6cbcbb545b3022502';

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
        isAutoDispose: true,
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
    r'a5e2bbc163e2ec1573a1b685461041bdb1df3b94';

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
        isAutoDispose: true,
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
    r'45edb69af8103e38460e2ec4253d2a6ab4d20630';

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
        isAutoDispose: true,
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
    r'8bc8c1553a875fea3bc5e4fbcf1d61a5b8793644';

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
        isAutoDispose: true,
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
    r'54881b8694abf5ef787e37463f0976758a58d9b6';

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
        isAutoDispose: true,
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
    r'd970edcdca9e19f7f9049cda51ca22f4d948edc1';

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
        isAutoDispose: true,
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

String _$addCreditsUseCaseHash() => r'de7e6f9a05ba8ab32fa1224600baaf8106299d0c';

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
        isAutoDispose: true,
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
    r'15ca818cd780b64042f6b21a86e6c55494872444';

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
        isAutoDispose: true,
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
    r'5d2b450d590bb6869c32b28d7684bcc80ea4f002';

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
        isAutoDispose: true,
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
    r'7266ddb35a23f8a3e9338d6a4bd8aeb3322d562c';

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
        isAutoDispose: true,
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
    r'9686c875346a9ac88069450a9986e2d4e77ee934';

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
        isAutoDispose: true,
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
    r'6798f6e4fa9aa59ba0b3e74486a58e292c2dd9d0';
