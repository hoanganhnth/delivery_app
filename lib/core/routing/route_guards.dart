import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import 'app_routes.dart';

/// Base class for route guards
abstract class RouteGuard {
  /// Check if the route should be redirected
  /// Returns null if no redirect is needed, or the redirect path
  String? checkRedirect(BuildContext context, GoRouterState state, WidgetRef ref);
}

/// Route guard for authentication
/// Redirects to login if user is not authenticated
class AuthGuard implements RouteGuard {
  @override
  String? checkRedirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    final authState = ref.read(authStateProvider);
    final isAuthenticated = authState.isAuthenticated;

    // List of routes that don't require authentication
    final publicRoutes = [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.splash,
      AppRoutes.root,
    ];

    final currentPath = state.uri.path;
    final isPublicRoute = publicRoutes.contains(currentPath);

    // If user is not authenticated and trying to access protected route
    if (!isAuthenticated && !isPublicRoute) {
      return AppRoutes.login;
    }

    // If user is authenticated and trying to access auth routes, redirect to home
    if (isAuthenticated && (currentPath == AppRoutes.login || currentPath == AppRoutes.register)) {
      return AppRoutes.home;
    }

    // No redirect needed
    return null;
  }
}

/// Route guard for guest users (not authenticated)
/// Redirects to home if user is already authenticated
class GuestGuard implements RouteGuard {
  @override
  String? checkRedirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    final authState = ref.read(authStateProvider);
    final isAuthenticated = authState.isAuthenticated;

    // If user is authenticated, redirect to home
    if (isAuthenticated) {
      return AppRoutes.home;
    }

    // No redirect needed
    return null;
  }
}

/// Route guard for admin users
/// Can be extended for role-based access control
class AdminGuard implements RouteGuard {
  @override
  String? checkRedirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    final authState = ref.read(profileStateProvider);
    final user = authState.user;

    // First check if user is authenticated
    if (user == null) {
      return AppRoutes.login;
    }

    // Check if user has admin role (you can implement this based on your user model)
    // For demo purposes, let's say admin users have email containing 'admin'
    final isAdmin = user.email.contains('admin');

    if (!isAdmin) {
      return AppRoutes.home; // Redirect non-admin users to home
    }

    return null;
  }
}

/// Route guard for premium features
/// Redirects to subscription page if user doesn't have premium access
class PremiumGuard implements RouteGuard {
  @override
  String? checkRedirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    final authState = ref.read(profileStateProvider);
    final user = authState.user;

    // First check if user is authenticated
    if (user == null) {
      return AppRoutes.login;
    }

    // Check if user has premium access (implement based on your user model)
    // For demo purposes, let's say premium users have email containing 'premium'
    final hasPremium = user.email.contains('premium');

    if (!hasPremium) {
      // Redirect to subscription page (you would create this route)
      return AppRoutes.home; // For now redirect to home
    }

    return null;
  }
}

/// Route guard for onboarding
/// Redirects new users to onboarding flow
class OnboardingGuard implements RouteGuard {
  @override
  String? checkRedirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    final authState = ref.read(profileStateProvider);
    final user = authState.user;

    // Check if user is authenticated
    if (user == null) {
      return AppRoutes.login;
    }

    // Check if user has completed onboarding (implement based on your user model)
    // For demo purposes, let's say users with name completed onboarding
    final hasCompletedOnboarding = user.fullName != null && user.fullName!.isNotEmpty;

    if (!hasCompletedOnboarding) {
      // Redirect to onboarding (you would create this route)
      return AppRoutes.profile; // For now redirect to profile to complete
    }

    return null;
  }
}

/// Composite guard that can combine multiple guards
class CompositeGuard implements RouteGuard {
  final List<RouteGuard> guards;

  CompositeGuard(this.guards);

  @override
  String? checkRedirect(BuildContext context, GoRouterState state, WidgetRef ref) {
    // Check each guard in order, return first redirect found
    for (final guard in guards) {
      final redirect = guard.checkRedirect(context, state, ref);
      if (redirect != null) {
        return redirect;
      }
    }
    return null;
  }
}

/// Example of how to use guards in other contexts (outside router)
///
/// ```dart
/// class SomeWidget extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final authGuard = AuthGuard();
///     final canAccess = authGuard.checkRedirect(context, state, ref) == null;
///
///     if (!canAccess) {
///       return UnauthorizedWidget();
///     }
///
///     return AuthorizedContent();
///   }
/// }
/// ```
