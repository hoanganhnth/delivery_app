// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for LocalAuthentication instance

@ProviderFor(localAuth)
final localAuthProvider = LocalAuthProvider._();

/// Provider for LocalAuthentication instance

final class LocalAuthProvider
    extends
        $FunctionalProvider<
          local_auth.LocalAuthentication,
          local_auth.LocalAuthentication,
          local_auth.LocalAuthentication
        >
    with $Provider<local_auth.LocalAuthentication> {
  /// Provider for LocalAuthentication instance
  LocalAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localAuthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localAuthHash();

  @$internal
  @override
  $ProviderElement<local_auth.LocalAuthentication> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  local_auth.LocalAuthentication create(Ref ref) {
    return localAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(local_auth.LocalAuthentication value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<local_auth.LocalAuthentication>(
        value,
      ),
    );
  }
}

String _$localAuthHash() => r'574caf8d72951cb1a9a1d5b3eadbf9af36a5701c';

/// Provider for Hive box for biometric credentials

@ProviderFor(biometricBox)
final biometricBoxProvider = BiometricBoxProvider._();

/// Provider for Hive box for biometric credentials

final class BiometricBoxProvider
    extends $FunctionalProvider<Box<dynamic>, Box<dynamic>, Box<dynamic>>
    with $Provider<Box<dynamic>> {
  /// Provider for Hive box for biometric credentials
  BiometricBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricBoxHash();

  @$internal
  @override
  $ProviderElement<Box<dynamic>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Box<dynamic> create(Ref ref) {
    return biometricBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<dynamic>>(value),
    );
  }
}

String _$biometricBoxHash() => r'90bfa10da57538b2200ed4b0c2d178463432f896';

/// Provider for biometric local datasource

@ProviderFor(biometricLocalDataSource)
final biometricLocalDataSourceProvider = BiometricLocalDataSourceProvider._();

/// Provider for biometric local datasource

final class BiometricLocalDataSourceProvider
    extends
        $FunctionalProvider<
          BiometricLocalDataSource,
          BiometricLocalDataSource,
          BiometricLocalDataSource
        >
    with $Provider<BiometricLocalDataSource> {
  /// Provider for biometric local datasource
  BiometricLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<BiometricLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BiometricLocalDataSource create(Ref ref) {
    return biometricLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricLocalDataSource>(value),
    );
  }
}

String _$biometricLocalDataSourceHash() =>
    r'dc4c55c70d83442cc45fa0a06c0994889515c282';

/// Provider for biometric repository

@ProviderFor(biometricRepository)
final biometricRepositoryProvider = BiometricRepositoryProvider._();

/// Provider for biometric repository

final class BiometricRepositoryProvider
    extends
        $FunctionalProvider<
          BiometricRepository,
          BiometricRepository,
          BiometricRepository
        >
    with $Provider<BiometricRepository> {
  /// Provider for biometric repository
  BiometricRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricRepositoryHash();

  @$internal
  @override
  $ProviderElement<BiometricRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BiometricRepository create(Ref ref) {
    return biometricRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiometricRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiometricRepository>(value),
    );
  }
}

String _$biometricRepositoryHash() =>
    r'4b07cea0100b30a5f7acdd3e8fe5cb7eb8ab279b';

/// Provider for check biometric availability usecase

@ProviderFor(checkBiometricAvailabilityUseCase)
final checkBiometricAvailabilityUseCaseProvider =
    CheckBiometricAvailabilityUseCaseProvider._();

/// Provider for check biometric availability usecase

final class CheckBiometricAvailabilityUseCaseProvider
    extends
        $FunctionalProvider<
          CheckBiometricAvailabilityUseCase,
          CheckBiometricAvailabilityUseCase,
          CheckBiometricAvailabilityUseCase
        >
    with $Provider<CheckBiometricAvailabilityUseCase> {
  /// Provider for check biometric availability usecase
  CheckBiometricAvailabilityUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkBiometricAvailabilityUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$checkBiometricAvailabilityUseCaseHash();

  @$internal
  @override
  $ProviderElement<CheckBiometricAvailabilityUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CheckBiometricAvailabilityUseCase create(Ref ref) {
    return checkBiometricAvailabilityUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CheckBiometricAvailabilityUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CheckBiometricAvailabilityUseCase>(
        value,
      ),
    );
  }
}

String _$checkBiometricAvailabilityUseCaseHash() =>
    r'ad6550bfdb2b3e794095843d18a22cf1bd87f0c7';

/// Provider for get available biometrics usecase

@ProviderFor(getAvailableBiometricsUseCase)
final getAvailableBiometricsUseCaseProvider =
    GetAvailableBiometricsUseCaseProvider._();

/// Provider for get available biometrics usecase

final class GetAvailableBiometricsUseCaseProvider
    extends
        $FunctionalProvider<
          GetAvailableBiometricsUseCase,
          GetAvailableBiometricsUseCase,
          GetAvailableBiometricsUseCase
        >
    with $Provider<GetAvailableBiometricsUseCase> {
  /// Provider for get available biometrics usecase
  GetAvailableBiometricsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAvailableBiometricsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAvailableBiometricsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAvailableBiometricsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAvailableBiometricsUseCase create(Ref ref) {
    return getAvailableBiometricsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAvailableBiometricsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAvailableBiometricsUseCase>(
        value,
      ),
    );
  }
}

String _$getAvailableBiometricsUseCaseHash() =>
    r'548bf50e377f7d35233bfb48e8a448d20c246b91';

/// Provider for authenticate with biometric usecase

@ProviderFor(authenticateWithBiometricUseCase)
final authenticateWithBiometricUseCaseProvider =
    AuthenticateWithBiometricUseCaseProvider._();

/// Provider for authenticate with biometric usecase

final class AuthenticateWithBiometricUseCaseProvider
    extends
        $FunctionalProvider<
          AuthenticateWithBiometricUseCase,
          AuthenticateWithBiometricUseCase,
          AuthenticateWithBiometricUseCase
        >
    with $Provider<AuthenticateWithBiometricUseCase> {
  /// Provider for authenticate with biometric usecase
  AuthenticateWithBiometricUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authenticateWithBiometricUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authenticateWithBiometricUseCaseHash();

  @$internal
  @override
  $ProviderElement<AuthenticateWithBiometricUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthenticateWithBiometricUseCase create(Ref ref) {
    return authenticateWithBiometricUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthenticateWithBiometricUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthenticateWithBiometricUseCase>(
        value,
      ),
    );
  }
}

String _$authenticateWithBiometricUseCaseHash() =>
    r'7e05c70cdd10449874a92aa6c0cb457a07387819';

/// Provider for enable biometric usecase

@ProviderFor(enableBiometricUseCase)
final enableBiometricUseCaseProvider = EnableBiometricUseCaseProvider._();

/// Provider for enable biometric usecase

final class EnableBiometricUseCaseProvider
    extends
        $FunctionalProvider<
          EnableBiometricUseCase,
          EnableBiometricUseCase,
          EnableBiometricUseCase
        >
    with $Provider<EnableBiometricUseCase> {
  /// Provider for enable biometric usecase
  EnableBiometricUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enableBiometricUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enableBiometricUseCaseHash();

  @$internal
  @override
  $ProviderElement<EnableBiometricUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnableBiometricUseCase create(Ref ref) {
    return enableBiometricUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnableBiometricUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnableBiometricUseCase>(value),
    );
  }
}

String _$enableBiometricUseCaseHash() =>
    r'd5459949921a7144cb04937b3c4433d152c57792';

/// Provider for disable biometric usecase

@ProviderFor(disableBiometricUseCase)
final disableBiometricUseCaseProvider = DisableBiometricUseCaseProvider._();

/// Provider for disable biometric usecase

final class DisableBiometricUseCaseProvider
    extends
        $FunctionalProvider<
          DisableBiometricUseCase,
          DisableBiometricUseCase,
          DisableBiometricUseCase
        >
    with $Provider<DisableBiometricUseCase> {
  /// Provider for disable biometric usecase
  DisableBiometricUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'disableBiometricUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$disableBiometricUseCaseHash();

  @$internal
  @override
  $ProviderElement<DisableBiometricUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DisableBiometricUseCase create(Ref ref) {
    return disableBiometricUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DisableBiometricUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DisableBiometricUseCase>(value),
    );
  }
}

String _$disableBiometricUseCaseHash() =>
    r'cae99e8a73081bbb5856c9ca5222cc4d06d77dbc';

/// Provider for GetAuthSessionUseCase

@ProviderFor(getAuthSessionUseCase)
final getAuthSessionUseCaseProvider = GetAuthSessionUseCaseProvider._();

/// Provider for GetAuthSessionUseCase

final class GetAuthSessionUseCaseProvider
    extends
        $FunctionalProvider<
          GetAuthSessionUseCase,
          GetAuthSessionUseCase,
          GetAuthSessionUseCase
        >
    with $Provider<GetAuthSessionUseCase> {
  /// Provider for GetAuthSessionUseCase
  GetAuthSessionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAuthSessionUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAuthSessionUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAuthSessionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAuthSessionUseCase create(Ref ref) {
    return getAuthSessionUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAuthSessionUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAuthSessionUseCase>(value),
    );
  }
}

String _$getAuthSessionUseCaseHash() =>
    r'3e71e775b4d69293b839c23eb46fbb8e3660e886';
