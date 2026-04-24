import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/core/routing/models/i_auth_checker.dart';
import 'package:delivery_app/core/routing/constants/app_routes.dart';

/// Centralized guard manager for easy guard application.
/// Framework-agnostic: depends on [IAuthChecker], not on Riverpod Ref.
/// Riverpod injects the concrete [IAuthChecker] via the provider.
class GuardManager {
  final IAuthChecker _authChecker;

  GuardManager(this._authChecker);

  /// Apply auth guard to a route
  String? applyAuthGuard(BuildContext context, GoRouterState state) {
    final publicRoutes = [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.splash,
      AppRoutes.root,
    ];

    final currentPath = state.uri.path;
    final isPublicRoute = publicRoutes.contains(currentPath);

    if (!_authChecker.isAuthenticated && !isPublicRoute) {
      return AppRoutes.login;
    }

    if (_authChecker.isAuthenticated &&
        (currentPath == AppRoutes.login ||
            currentPath == AppRoutes.register)) {
      return AppRoutes.home;
    }

    return null;
  }

  /// Apply guest guard to a route
  String? applyGuestGuard(BuildContext context, GoRouterState state) {
    if (_authChecker.isAuthenticated) {
      return AppRoutes.home;
    }
    return null;
  }

  /// Check if user can access a specific route (for UI logic)
  bool canAccessRoute(String routePath) {
    final publicRoutes = [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.splash,
      AppRoutes.root,
    ];

    if (publicRoutes.contains(routePath)) {
      return true;
    }

    return _authChecker.isAuthenticated;
  }

  /// Get user role for UI logic
  UserRole getUserRole() => _authChecker.userRole;
}
