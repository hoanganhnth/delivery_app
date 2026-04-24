import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/core/routing/models/i_auth_checker.dart';
import 'package:delivery_app/core/routing/constants/app_routes.dart';

/// Base class for route guards.
/// Framework-agnostic: depends on [IAuthChecker], not on WidgetRef.
abstract class RouteGuard {
  /// Check if the route should be redirected.
  /// Returns null if no redirect is needed, or the redirect path.
  String? checkRedirect(
    BuildContext context,
    GoRouterState state,
    IAuthChecker authChecker,
  );
}

/// Route guard for authentication.
/// Redirects to login if user is not authenticated.
class AuthGuard implements RouteGuard {
  @override
  String? checkRedirect(
    BuildContext context,
    GoRouterState state,
    IAuthChecker authChecker,
  ) {
    final publicRoutes = [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.splash,
      AppRoutes.root,
    ];

    final currentPath = state.uri.path;
    final isPublicRoute = publicRoutes.contains(currentPath);

    if (!authChecker.isAuthenticated && !isPublicRoute) {
      return AppRoutes.login;
    }

    if (authChecker.isAuthenticated &&
        (currentPath == AppRoutes.login ||
            currentPath == AppRoutes.register)) {
      return AppRoutes.home;
    }

    return null;
  }
}

/// Route guard for guest users (not authenticated).
/// Redirects to home if user is already authenticated.
class GuestGuard implements RouteGuard {
  @override
  String? checkRedirect(
    BuildContext context,
    GoRouterState state,
    IAuthChecker authChecker,
  ) {
    if (authChecker.isAuthenticated) {
      return AppRoutes.home;
    }
    return null;
  }
}

/// Route guard for admin users.
class AdminGuard implements RouteGuard {
  @override
  String? checkRedirect(
    BuildContext context,
    GoRouterState state,
    IAuthChecker authChecker,
  ) {
    if (!authChecker.isAuthenticated) {
      return AppRoutes.login;
    }

    if (!authChecker.userRole.canAccessAdmin) {
      return AppRoutes.home;
    }

    return null;
  }
}

/// Route guard for premium features.
class PremiumGuard implements RouteGuard {
  @override
  String? checkRedirect(
    BuildContext context,
    GoRouterState state,
    IAuthChecker authChecker,
  ) {
    if (!authChecker.isAuthenticated) {
      return AppRoutes.login;
    }

    if (!authChecker.userRole.canAccessPremium) {
      return AppRoutes.home;
    }

    return null;
  }
}

/// Composite guard that can combine multiple guards.
class CompositeGuard implements RouteGuard {
  final List<RouteGuard> guards;

  CompositeGuard(this.guards);

  @override
  String? checkRedirect(
    BuildContext context,
    GoRouterState state,
    IAuthChecker authChecker,
  ) {
    for (final guard in guards) {
      final redirect = guard.checkRedirect(context, state, authChecker);
      if (redirect != null) {
        return redirect;
      }
    }
    return null;
  }
}
