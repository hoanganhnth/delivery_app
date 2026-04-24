import 'package:flutter/foundation.dart';

/// Reads auth state at a point in time.
/// Pure Dart interface — no Riverpod/BLoC dependency.
abstract interface class IAuthChecker {
  bool get isAuthenticated;
  UserRole get userRole;
}

/// Auth-aware [Listenable] for GoRouter refresh.
/// Combines [IAuthChecker] (readable state) with [Listenable] (reactive).
/// Implement this in the framework layer (Riverpod adapter, BLoC adapter, etc.).
abstract interface class IAuthNotifier implements IAuthChecker, Listenable {}

/// User roles for role-based access control.
enum UserRole {
  guest,
  regular,
  premium,
  admin;

  bool get isGuest => this == UserRole.guest;
  bool get isRegular => this == UserRole.regular;
  bool get isPremium => this == UserRole.premium;
  bool get isAdmin => this == UserRole.admin;

  bool get canAccessAdmin => isAdmin;
  bool get canAccessPremium => isPremium || isAdmin;
}
