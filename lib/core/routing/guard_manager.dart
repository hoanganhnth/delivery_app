import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import 'app_routes.dart';

/// Centralized guard manager for easy guard application
/// This provides a clean API for applying guards to routes
class GuardManager {
  final Ref _ref;

  GuardManager(this._ref);

  /// Apply auth guard to a route
  String? applyAuthGuard(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authStateProvider);
    final isAuthenticated = authState.isAuthenticated;

    final publicRoutes = [
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.forgotPassword,
      AppRoutes.splash,
      AppRoutes.root,
    ];

    final currentPath = state.uri.path;
    final isPublicRoute = publicRoutes.contains(currentPath);

    if (!isAuthenticated && !isPublicRoute) {
      return AppRoutes.login;
    }

    if (isAuthenticated && (currentPath == AppRoutes.login || currentPath == AppRoutes.register)) {
      return AppRoutes.home;
    }

    return null;
  }

  /// Apply guest guard to a route
  String? applyGuestGuard(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authStateProvider);
    final isAuthenticated = authState.isAuthenticated;

    if (isAuthenticated) {
      return AppRoutes.home;
    }

    return null;
  }

  /// Apply admin guard to a route
  // String? applyAdminGuard(BuildContext context, GoRouterState state) {
  //   final authState = _ref.read(authStateProvider);
  //   final user = authState.user;

  //   if (user == null) {
  //     return AppRoutes.login;
  //   }

  //   final isAdmin = user.email.contains('admin');
  //   if (!isAdmin) {
  //     return AppRoutes.home;
  //   }

  //   return null;
  // }

  // /// Apply premium guard to a route
  // String? applyPremiumGuard(BuildContext context, GoRouterState state) {
  //   final authState = _ref.read(authStateProvider);
  //   final user = authState.user;

  //   if (user == null) {
  //     return AppRoutes.login;
  //   }

  //   final hasPremium = user.email.contains('premium');
  //   if (!hasPremium) {
  //     return AppRoutes.home; // Or redirect to subscription page
  //   }

  //   return null;
  // }

  /// Apply onboarding guard to a route
  // String? applyOnboardingGuard(BuildContext context, GoRouterState state) {
  //   final authState = _ref.read(authStateProvider);
  //   final user = authState.user;

  //   if (user == null) {
  //     return AppRoutes.login;
  //   }

  //   final hasCompletedOnboarding = user.name != null && user.name!.isNotEmpty;
  //   if (!hasCompletedOnboarding) {
  //     return AppRoutes.profile;
  //   }

  //   return null;
  // }

  /// Common guard combinations
  // String? applyAuthAndOnboarding(BuildContext context, GoRouterState state) {
  //   // First check auth
  //   final authRedirect = applyAuthGuard(context, state);
  //   if (authRedirect != null) return authRedirect;

  //   // Then check onboarding
  //   return applyOnboardingGuard(context, state);
  // }

  // String? applyAuthAndAdmin(BuildContext context, GoRouterState state) {
  //   // First check auth
  //   final authRedirect = applyAuthGuard(context, state);
  //   if (authRedirect != null) return authRedirect;

  //   // Then check admin
  //   return applyAdminGuard(context, state);
  // }

  // String? applyAuthAndPremium(BuildContext context, GoRouterState state) {
  //   // First check auth
  //   final authRedirect = applyAuthGuard(context, state);
  //   if (authRedirect != null) return authRedirect;

  //   // Then check premium
  //   return applyPremiumGuard(context, state);
  // }
  
  /// Check if user can access a specific route (for UI logic)
  bool canAccessRoute(String routePath) {
    final authState = _ref.read(authStateProvider);
    
    // Public routes
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
    
    // Check authentication
    if (!authState.isAuthenticated) {
      return false;
    }
    
    // Check admin routes
    // if (routePath == AppRoutes.admin) {
    //   return authState.user?.email.contains('admin') ?? false;
    // }
    
    // Check onboarding for profile
    // if (routePath == AppRoutes.profile) {
    //   return authState.user?.name?.isNotEmpty ?? false;
    // }
    
    // All other protected routes require authentication
    return true;
  }
  
  /// Get user role for UI logic
  UserRole getUserRole() {
    final authState = _ref.read(authStateProvider);
    
    if (!authState.isAuthenticated) {
      return UserRole.guest;
    }
    
    // final user = authState.user!;
    
    // if (user.email.contains('admin')) {
    //   return UserRole.admin;
    // }
    
    // if (user.email.contains('premium')) {
    //   return UserRole.premium;
    // }
    
    return UserRole.regular;
  }
  
  /// Check if user has completed onboarding
  // bool hasCompletedOnboarding() {
  //   final authState = _ref.read(authStateProvider);
  //   return authState.user?.name?.isNotEmpty ?? false;
  // }
}

/// User roles for easier role checking
enum UserRole {
  guest,
  regular,
  premium,
  admin,
}

/// Extension for easy role checking
extension UserRoleExtension on UserRole {
  bool get isGuest => this == UserRole.guest;
  bool get isRegular => this == UserRole.regular;
  bool get isPremium => this == UserRole.premium;
  bool get isAdmin => this == UserRole.admin;
  
  bool get canAccessAdmin => isAdmin;
  bool get canAccessPremium => isPremium || isAdmin;
  bool get isAuthenticated => this != UserRole.guest;
}

/// Provider for GuardManager
final guardManagerProvider = Provider<GuardManager>((ref) {
  return GuardManager(ref);
});
