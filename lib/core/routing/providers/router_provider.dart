import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/core/routing/app_router.dart';
import 'package:delivery_app/core/routing/providers/riverpod_auth_notifier.dart';
import 'package:delivery_app/core/routing/providers/router_config.dart';
import 'package:delivery_app/core/services/deep_link/_riverpod/deep_link_provider.dart';

part 'router_provider.g.dart';

/// Riverpod wiring point for the application router.
///
/// Responsibilities:
/// 1. Creates [RiverpodAuthNotifier] from [AuthState].
/// 2. Keeps the notifier alive and in sync via [ref.listen].
/// 3. Calls [createAppRouter] (pure Dart factory) with interfaces.
/// 4. Initialises deep link service once the router is created.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final config = ref.watch(routerConfigProvider);
  final initialAuthState = ref.read(authProvider);

  // Create the adapter — holds state + notifies GoRouter on change
  final authNotifier = RiverpodAuthNotifier(initialAuthState);

  // Keep adapter in sync with Riverpod auth state
  ref.listen<AuthState>(authProvider, (_, next) {
    authNotifier.updateState(next);
  });

  // Clean up the notifier when provider is disposed
  ref.onDispose(authNotifier.dispose);

  // Build the router using pure-Dart factory
  final router = createAppRouter(
    authNotifier: authNotifier,
    config: config,
  );

  // Initialise deep links
  ref.read(deepLinkServiceProvider).initialize(router);

  return router;
}
