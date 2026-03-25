// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Network providers

@ProviderFor(userAddressApiService)
final userAddressApiServiceProvider = UserAddressApiServiceProvider._();

/// Network providers

final class UserAddressApiServiceProvider
    extends
        $FunctionalProvider<
          UserAddressApiService,
          UserAddressApiService,
          UserAddressApiService
        >
    with $Provider<UserAddressApiService> {
  /// Network providers
  UserAddressApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAddressApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAddressApiServiceHash();

  @$internal
  @override
  $ProviderElement<UserAddressApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserAddressApiService create(Ref ref) {
    return userAddressApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAddressApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAddressApiService>(value),
    );
  }
}

String _$userAddressApiServiceHash() =>
    r'0b6dd092d863e41d621b3ef09395261e0d736a59';

@ProviderFor(userAddressRemoteDataSource)
final userAddressRemoteDataSourceProvider =
    UserAddressRemoteDataSourceProvider._();

final class UserAddressRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          UserAddressRemoteDataSource,
          UserAddressRemoteDataSource,
          UserAddressRemoteDataSource
        >
    with $Provider<UserAddressRemoteDataSource> {
  UserAddressRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAddressRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAddressRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserAddressRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserAddressRemoteDataSource create(Ref ref) {
    return userAddressRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAddressRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAddressRemoteDataSource>(value),
    );
  }
}

String _$userAddressRemoteDataSourceHash() =>
    r'5be01cee242122dd3298d1b41c778a7bb0d44621';

/// Repository provider

@ProviderFor(userAddressRepository)
final userAddressRepositoryProvider = UserAddressRepositoryProvider._();

/// Repository provider

final class UserAddressRepositoryProvider
    extends
        $FunctionalProvider<
          UserAddressRepository,
          UserAddressRepository,
          UserAddressRepository
        >
    with $Provider<UserAddressRepository> {
  /// Repository provider
  UserAddressRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAddressRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAddressRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserAddressRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserAddressRepository create(Ref ref) {
    return userAddressRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAddressRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAddressRepository>(value),
    );
  }
}

String _$userAddressRepositoryHash() =>
    r'85ad630ae48afd01fbdaaa23fa07e2e32f5eb0ee';

/// UseCase providers

@ProviderFor(getUserAddressesUseCase)
final getUserAddressesUseCaseProvider = GetUserAddressesUseCaseProvider._();

/// UseCase providers

final class GetUserAddressesUseCaseProvider
    extends
        $FunctionalProvider<
          GetUserAddressesUseCase,
          GetUserAddressesUseCase,
          GetUserAddressesUseCase
        >
    with $Provider<GetUserAddressesUseCase> {
  /// UseCase providers
  GetUserAddressesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserAddressesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserAddressesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetUserAddressesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUserAddressesUseCase create(Ref ref) {
    return getUserAddressesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserAddressesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserAddressesUseCase>(value),
    );
  }
}

String _$getUserAddressesUseCaseHash() =>
    r'be8f790d9c1d66272b5c8c5e3c33ff86999f7150';

@ProviderFor(getAddressByIdUseCase)
final getAddressByIdUseCaseProvider = GetAddressByIdUseCaseProvider._();

final class GetAddressByIdUseCaseProvider
    extends
        $FunctionalProvider<
          GetAddressByIdUseCase,
          GetAddressByIdUseCase,
          GetAddressByIdUseCase
        >
    with $Provider<GetAddressByIdUseCase> {
  GetAddressByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAddressByIdUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAddressByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAddressByIdUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAddressByIdUseCase create(Ref ref) {
    return getAddressByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAddressByIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAddressByIdUseCase>(value),
    );
  }
}

String _$getAddressByIdUseCaseHash() =>
    r'5232c3fd868da5de4b4976e0f3c7082802aff92a';

@ProviderFor(createAddressUseCase)
final createAddressUseCaseProvider = CreateAddressUseCaseProvider._();

final class CreateAddressUseCaseProvider
    extends
        $FunctionalProvider<
          CreateAddressUseCase,
          CreateAddressUseCase,
          CreateAddressUseCase
        >
    with $Provider<CreateAddressUseCase> {
  CreateAddressUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createAddressUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createAddressUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateAddressUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateAddressUseCase create(Ref ref) {
    return createAddressUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateAddressUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateAddressUseCase>(value),
    );
  }
}

String _$createAddressUseCaseHash() =>
    r'd22cddf870987bac09492fe335352d31f33e7c52';

@ProviderFor(updateAddressUseCase)
final updateAddressUseCaseProvider = UpdateAddressUseCaseProvider._();

final class UpdateAddressUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateAddressUseCase,
          UpdateAddressUseCase,
          UpdateAddressUseCase
        >
    with $Provider<UpdateAddressUseCase> {
  UpdateAddressUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateAddressUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateAddressUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateAddressUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateAddressUseCase create(Ref ref) {
    return updateAddressUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateAddressUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateAddressUseCase>(value),
    );
  }
}

String _$updateAddressUseCaseHash() =>
    r'7cc44399c8abb2c30aa738d1d03db75f1a8f9ab5';

@ProviderFor(deleteAddressUseCase)
final deleteAddressUseCaseProvider = DeleteAddressUseCaseProvider._();

final class DeleteAddressUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteAddressUseCase,
          DeleteAddressUseCase,
          DeleteAddressUseCase
        >
    with $Provider<DeleteAddressUseCase> {
  DeleteAddressUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAddressUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAddressUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteAddressUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteAddressUseCase create(Ref ref) {
    return deleteAddressUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteAddressUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteAddressUseCase>(value),
    );
  }
}

String _$deleteAddressUseCaseHash() =>
    r'bea061e7b9f7df66de8f964be78ce77f705c1382';

@ProviderFor(setDefaultAddressUseCase)
final setDefaultAddressUseCaseProvider = SetDefaultAddressUseCaseProvider._();

final class SetDefaultAddressUseCaseProvider
    extends
        $FunctionalProvider<
          SetDefaultAddressUseCase,
          SetDefaultAddressUseCase,
          SetDefaultAddressUseCase
        >
    with $Provider<SetDefaultAddressUseCase> {
  SetDefaultAddressUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setDefaultAddressUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setDefaultAddressUseCaseHash();

  @$internal
  @override
  $ProviderElement<SetDefaultAddressUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetDefaultAddressUseCase create(Ref ref) {
    return setDefaultAddressUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetDefaultAddressUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetDefaultAddressUseCase>(value),
    );
  }
}

String _$setDefaultAddressUseCaseHash() =>
    r'e20e28fac5ecf15c6379569e8831075612fa2e51';

/// Helper providers

@ProviderFor(defaultAddress)
final defaultAddressProvider = DefaultAddressProvider._();

/// Helper providers

final class DefaultAddressProvider
    extends
        $FunctionalProvider<
          UserAddressEntity?,
          UserAddressEntity?,
          UserAddressEntity?
        >
    with $Provider<UserAddressEntity?> {
  /// Helper providers
  DefaultAddressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'defaultAddressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$defaultAddressHash();

  @$internal
  @override
  $ProviderElement<UserAddressEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserAddressEntity? create(Ref ref) {
    return defaultAddress(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAddressEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAddressEntity?>(value),
    );
  }
}

String _$defaultAddressHash() => r'8b7e373ba2b7b6e299dbd5e461e82fecc5ccf612';

@ProviderFor(hasAddresses)
final hasAddressesProvider = HasAddressesProvider._();

final class HasAddressesProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  HasAddressesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasAddressesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasAddressesHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return hasAddresses(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hasAddressesHash() => r'b54bbde11abe7d474909f35baeacfba9f47b1afc';
