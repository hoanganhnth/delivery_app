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
        isAutoDispose: false,
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

String _$authAwareDioHash() => r'1a6c8a73c0167de8a973f02832869f252f9fd41e';
