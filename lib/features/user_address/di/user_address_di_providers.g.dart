// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_di_providers.dart';

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
        isAutoDispose: false,
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
    r'e76ea82f297bd65dae45c1cc745aab72fee23188';

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
        isAutoDispose: false,
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
    r'e11753aeaf1b3685c8d5316a9161d77f740a5343';

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
        isAutoDispose: false,
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
    r'b5b43b39788abf67b4c3d2e6a7e57fc2ee4bdf3e';

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
        isAutoDispose: false,
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
    r'3a753dfe8d9b3932eae9d3ea4a00cd25170bb44a';

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
        isAutoDispose: false,
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
    r'a6881d9a4523d72405d3ee1a74806e82e6a01ea7';

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
        isAutoDispose: false,
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
    r'70b39dca2e23b77ba0f0644b22847b58c2f7c3ff';

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
        isAutoDispose: false,
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
    r'be7dd7f308351b546bb4d2e2b1d46d52c44bd104';

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
        isAutoDispose: false,
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
    r'd34504d6229babc8b9f63def529290eb4364f8ab';

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
        isAutoDispose: false,
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
    r'287068788cb649ec1bbd3cc95aa43ea9dc75b446';

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
