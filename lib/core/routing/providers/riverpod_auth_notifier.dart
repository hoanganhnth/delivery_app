import 'package:flutter/foundation.dart';
import 'package:delivery_app/core/routing/models/i_auth_checker.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';

/// Riverpod adapter for [IAuthNotifier].
///
/// Lives in the Riverpod layer — knows about [AuthState].
/// The core router only sees [IAuthNotifier] and never imports this class.
///
/// Usage in provider:
/// ```dart
/// @riverpod
/// GoRouter router(Ref ref) {
///   final notifier = ref.watch(authNotifierProvider.notifier);
///   return createAppRouter(authNotifier: notifier, config: ...);
/// }
/// ```
class RiverpodAuthNotifier extends ChangeNotifier implements IAuthNotifier {
  AuthState _state;

  RiverpodAuthNotifier(this._state);

  /// Called by the provider whenever [AuthState] changes.
  void updateState(AuthState newState) {
    if (_state.isAuthenticated != newState.isAuthenticated) {
      _state = newState;
      notifyListeners(); // GoRouter re-evaluates redirect
    }
  }

  @override
  bool get isAuthenticated => _state.isAuthenticated;

  @override
  UserRole get userRole {
    if (!isAuthenticated) return UserRole.guest;
    // Extend with real role logic from _state.user as needed
    return UserRole.regular;
  }
}
