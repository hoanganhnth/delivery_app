// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storage)
final storageProvider = StorageProvider._();

final class StorageProvider
    extends $FunctionalProvider<IStorage, IStorage, IStorage>
    with $Provider<IStorage> {
  StorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageHash();

  @$internal
  @override
  $ProviderElement<IStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IStorage create(Ref ref) {
    return storage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IStorage>(value),
    );
  }
}

String _$storageHash() => r'025a7b082d9afc28b1a16ed8d7160630b2127dda';

/// Specialized storage for auth/secure data if needed

@ProviderFor(authStorage)
final authStorageProvider = AuthStorageProvider._();

/// Specialized storage for auth/secure data if needed

final class AuthStorageProvider
    extends $FunctionalProvider<IStorage, IStorage, IStorage>
    with $Provider<IStorage> {
  /// Specialized storage for auth/secure data if needed
  AuthStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStorageHash();

  @$internal
  @override
  $ProviderElement<IStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IStorage create(Ref ref) {
    return authStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IStorage>(value),
    );
  }
}

String _$authStorageHash() => r'b01365438236258633950e3e75e6f9548f6ee131';
