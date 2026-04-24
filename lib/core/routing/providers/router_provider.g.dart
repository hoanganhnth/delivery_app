// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod wiring point for the application router.
///
/// Responsibilities:
/// 1. Creates [RiverpodAuthNotifier] from [AuthState].
/// 2. Keeps the notifier alive and in sync via [ref.listen].
/// 3. Calls [createAppRouter] (pure Dart factory) with interfaces.
/// 4. Initialises deep link service once the router is created.

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// Riverpod wiring point for the application router.
///
/// Responsibilities:
/// 1. Creates [RiverpodAuthNotifier] from [AuthState].
/// 2. Keeps the notifier alive and in sync via [ref.listen].
/// 3. Calls [createAppRouter] (pure Dart factory) with interfaces.
/// 4. Initialises deep link service once the router is created.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Riverpod wiring point for the application router.
  ///
  /// Responsibilities:
  /// 1. Creates [RiverpodAuthNotifier] from [AuthState].
  /// 2. Keeps the notifier alive and in sync via [ref.listen].
  /// 3. Calls [createAppRouter] (pure Dart factory) with interfaces.
  /// 4. Initialises deep link service once the router is created.
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'fd98cdab0e2e82d4d29c72dcdc5518d4ea6058d7';
