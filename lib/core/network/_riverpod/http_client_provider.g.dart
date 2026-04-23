// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Unauthenticated HTTP client

@ProviderFor(httpClient)
final httpClientProvider = HttpClientProvider._();

/// Unauthenticated HTTP client

final class HttpClientProvider
    extends $FunctionalProvider<IHttpClient, IHttpClient, IHttpClient>
    with $Provider<IHttpClient> {
  /// Unauthenticated HTTP client
  HttpClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpClientHash();

  @$internal
  @override
  $ProviderElement<IHttpClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IHttpClient create(Ref ref) {
    return httpClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IHttpClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IHttpClient>(value),
    );
  }
}

String _$httpClientHash() => r'ef5fcef01da9cd066818cb235931a931cb02126c';

/// Authenticated HTTP client

@ProviderFor(authenticatedHttpClient)
final authenticatedHttpClientProvider = AuthenticatedHttpClientProvider._();

/// Authenticated HTTP client

final class AuthenticatedHttpClientProvider
    extends $FunctionalProvider<IHttpClient, IHttpClient, IHttpClient>
    with $Provider<IHttpClient> {
  /// Authenticated HTTP client
  AuthenticatedHttpClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authenticatedHttpClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authenticatedHttpClientHash();

  @$internal
  @override
  $ProviderElement<IHttpClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IHttpClient create(Ref ref) {
    return authenticatedHttpClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IHttpClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IHttpClient>(value),
    );
  }
}

String _$authenticatedHttpClientHash() =>
    r'09749e7864e09a0ba98d893f01e05069925ec1a5';
