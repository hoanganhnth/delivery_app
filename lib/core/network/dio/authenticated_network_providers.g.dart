// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_network_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for authenticated Dio instance
/// This should be overridden by features that need authentication
///
/// Usage example:
/// ```dart
/// // In auth module, override this provider
/// @riverpod
/// Dio authenticatedDio(Ref ref) {
///   final dioClient = DioClient(
///     getToken: () async {
///       final authState = ref.read(authProvider);
///       return authState.user?.accessToken;
///     },
///     onRefreshToken: () async {
///       final authNotifier = ref.read(authProvider.notifier);
///       return await authNotifier.refreshToken();
///     },
///   );
///   return dioClient.dio;
/// }
/// ```

@ProviderFor(authenticatedDio)
final authenticatedDioProvider = AuthenticatedDioProvider._();

/// Provider for authenticated Dio instance
/// This should be overridden by features that need authentication
///
/// Usage example:
/// ```dart
/// // In auth module, override this provider
/// @riverpod
/// Dio authenticatedDio(Ref ref) {
///   final dioClient = DioClient(
///     getToken: () async {
///       final authState = ref.read(authProvider);
///       return authState.user?.accessToken;
///     },
///     onRefreshToken: () async {
///       final authNotifier = ref.read(authProvider.notifier);
///       return await authNotifier.refreshToken();
///     },
///   );
///   return dioClient.dio;
/// }
/// ```

final class AuthenticatedDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Provider for authenticated Dio instance
  /// This should be overridden by features that need authentication
  ///
  /// Usage example:
  /// ```dart
  /// // In auth module, override this provider
  /// @riverpod
  /// Dio authenticatedDio(Ref ref) {
  ///   final dioClient = DioClient(
  ///     getToken: () async {
  ///       final authState = ref.read(authProvider);
  ///       return authState.user?.accessToken;
  ///     },
  ///     onRefreshToken: () async {
  ///       final authNotifier = ref.read(authProvider.notifier);
  ///       return await authNotifier.refreshToken();
  ///     },
  ///   );
  ///   return dioClient.dio;
  /// }
  /// ```
  AuthenticatedDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authenticatedDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authenticatedDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return authenticatedDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$authenticatedDioHash() => r'92f60f29d69704fdee1d19a84dcd35d0c3ec7ef3';
