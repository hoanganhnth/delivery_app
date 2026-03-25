// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_network_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Auth-aware Dio provider that includes authentication
/// This provider will be used by other features that need authenticated requests

@ProviderFor(authAwareDio)
final authAwareDioProvider = AuthAwareDioProvider._();

/// Auth-aware Dio provider that includes authentication
/// This provider will be used by other features that need authenticated requests

final class AuthAwareDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Auth-aware Dio provider that includes authentication
  /// This provider will be used by other features that need authenticated requests
  AuthAwareDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authAwareDioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authAwareDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return authAwareDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$authAwareDioHash() => r'7b9f8ae421f0eb125207029e8298d3eb78965bb1';

/// Provider override for the entire app
/// Use this in your main app to enable authenticated networking

@ProviderFor(getAuthenticatedDioOverride)
final getAuthenticatedDioOverrideProvider =
    GetAuthenticatedDioOverrideProvider._();

/// Provider override for the entire app
/// Use this in your main app to enable authenticated networking

final class GetAuthenticatedDioOverrideProvider
    extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Provider override for the entire app
  /// Use this in your main app to enable authenticated networking
  GetAuthenticatedDioOverrideProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAuthenticatedDioOverrideProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAuthenticatedDioOverrideHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return getAuthenticatedDioOverride(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$getAuthenticatedDioOverrideHash() =>
    r'1549bc7e78ebd3317bf334abedf0c6d779ea2853';
