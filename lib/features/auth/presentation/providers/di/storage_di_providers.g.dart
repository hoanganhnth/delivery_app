// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for SharedPreferences

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// Provider for SharedPreferences

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Provider for SharedPreferences
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'ef084c2911768d9da63bd78375bf223ff3d71dd3';

/// Provider for TokenLocalDataSource

@ProviderFor(tokenLocalDataSource)
final tokenLocalDataSourceProvider = TokenLocalDataSourceProvider._();

/// Provider for TokenLocalDataSource

final class TokenLocalDataSourceProvider
    extends
        $FunctionalProvider<
          TokenLocalDataSource,
          TokenLocalDataSource,
          TokenLocalDataSource
        >
    with $Provider<TokenLocalDataSource> {
  /// Provider for TokenLocalDataSource
  TokenLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<TokenLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TokenLocalDataSource create(Ref ref) {
    return tokenLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenLocalDataSource>(value),
    );
  }
}

String _$tokenLocalDataSourceHash() =>
    r'5a11f5b0e263524807a6a46bee005e7cdd352b64';

/// Provider for TokenStorageRepository

@ProviderFor(tokenStorageRepository)
final tokenStorageRepositoryProvider = TokenStorageRepositoryProvider._();

/// Provider for TokenStorageRepository

final class TokenStorageRepositoryProvider
    extends
        $FunctionalProvider<
          TokenStorageRepository,
          TokenStorageRepository,
          TokenStorageRepository
        >
    with $Provider<TokenStorageRepository> {
  /// Provider for TokenStorageRepository
  TokenStorageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStorageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStorageRepositoryHash();

  @$internal
  @override
  $ProviderElement<TokenStorageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TokenStorageRepository create(Ref ref) {
    return tokenStorageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStorageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenStorageRepository>(value),
    );
  }
}

String _$tokenStorageRepositoryHash() =>
    r'bfedd5b52b6b8d3991dad18921521f6a8dfc1335';

/// Provider for StoreTokensUseCase

@ProviderFor(storeTokensUseCase)
final storeTokensUseCaseProvider = StoreTokensUseCaseProvider._();

/// Provider for StoreTokensUseCase

final class StoreTokensUseCaseProvider
    extends
        $FunctionalProvider<
          StoreTokensUseCase,
          StoreTokensUseCase,
          StoreTokensUseCase
        >
    with $Provider<StoreTokensUseCase> {
  /// Provider for StoreTokensUseCase
  StoreTokensUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storeTokensUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storeTokensUseCaseHash();

  @$internal
  @override
  $ProviderElement<StoreTokensUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StoreTokensUseCase create(Ref ref) {
    return storeTokensUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StoreTokensUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StoreTokensUseCase>(value),
    );
  }
}

String _$storeTokensUseCaseHash() =>
    r'246ef3a23d5d1c6645700601809c9620d7f455c5';

/// Provider for GetTokensUseCase

@ProviderFor(getTokensUseCase)
final getTokensUseCaseProvider = GetTokensUseCaseProvider._();

/// Provider for GetTokensUseCase

final class GetTokensUseCaseProvider
    extends
        $FunctionalProvider<
          GetTokensUseCase,
          GetTokensUseCase,
          GetTokensUseCase
        >
    with $Provider<GetTokensUseCase> {
  /// Provider for GetTokensUseCase
  GetTokensUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTokensUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTokensUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTokensUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTokensUseCase create(Ref ref) {
    return getTokensUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTokensUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTokensUseCase>(value),
    );
  }
}

String _$getTokensUseCaseHash() => r'352cf016a53d81e8d7715608675c91558a9fa957';

/// Provider for ClearTokensUseCase

@ProviderFor(clearTokensUseCase)
final clearTokensUseCaseProvider = ClearTokensUseCaseProvider._();

/// Provider for ClearTokensUseCase

final class ClearTokensUseCaseProvider
    extends
        $FunctionalProvider<
          ClearTokensUseCase,
          ClearTokensUseCase,
          ClearTokensUseCase
        >
    with $Provider<ClearTokensUseCase> {
  /// Provider for ClearTokensUseCase
  ClearTokensUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearTokensUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearTokensUseCaseHash();

  @$internal
  @override
  $ProviderElement<ClearTokensUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClearTokensUseCase create(Ref ref) {
    return clearTokensUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClearTokensUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClearTokensUseCase>(value),
    );
  }
}

String _$clearTokensUseCaseHash() =>
    r'544d5d0e46f22a567cb56f6618f6a1324af6ca44';
