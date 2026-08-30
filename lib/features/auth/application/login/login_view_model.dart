import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/utils/validators.dart';
import 'package:delivery_app/features/auth/application/session/auth_notifier.dart';
import 'package:delivery_app/features/auth/application/session/auth_state.dart';

import 'login_effect.dart';
import 'login_intent.dart';
import 'login_state.dart';

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginViewState>(
  LoginViewModel.new,
);

class LoginViewModel extends Notifier<LoginViewState> {
  int _nextEffectId = 0;
  bool _wasAuthenticated = false;
  String? _lastError;

  @override
  LoginViewState build() {
    final authState = ref.read(authProvider);
    _wasAuthenticated = authState.isAuthenticated;
    ref.listen<AuthState>(authProvider, (_, next) => _onAuthChanged(next));
    return LoginViewState(
      isSubmitting: authState.isLoginLoading,
      authError: authState.errorMessage,
    );
  }

  Future<void> dispatch(LoginIntent intent) async {
    switch (intent) {
      case LoginEmailChanged(:final value):
        state = state.copyWith(
          email: value,
          clearEmailError: true,
          clearAuthError: true,
        );
      case LoginPasswordChanged(:final value):
        state = state.copyWith(
          password: value,
          clearPasswordError: true,
          clearAuthError: true,
        );
      case LoginPasswordVisibilityToggled():
        state = state.copyWith(obscurePassword: !state.obscurePassword);
      case LoginForgotPasswordRequested():
        _emit(const LoginNavigateToForgotPassword());
      case LoginSubmitted():
        await _submit();
      case LoginGoogleRequested():
        await _googleLogin();
      case LoginRegisterRequested():
        _emit(const LoginNavigateToRegister());
      case LoginEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _submit() async {
    if (state.isSubmitting) return;
    final emailError = _emailError(state.email);
    final passwordError = _passwordError(state.password);
    if (emailError != null || passwordError != null) {
      state = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
      );
      return;
    }

    state = state.copyWith(
      isSubmitting: true,
      clearEmailError: true,
      clearPasswordError: true,
      clearAuthError: true,
    );
    await ref
        .read(authProvider.notifier)
        .login(email: state.email.trim(), password: state.password);
  }

  Future<void> _googleLogin() async {
    if (state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true, clearAuthError: true);
    await ref.read(authProvider.notifier).loginWithGoogle();
  }

  void _onAuthChanged(AuthState next) {
    if (!ref.mounted) return;
    state = state.copyWith(
      isSubmitting: next.isLoginLoading,
      authError: next.errorMessage,
      clearAuthError: next.errorMessage == null,
    );

    final error = next.errorMessage;
    if (error != null && !next.isLoginLoading && error != _lastError) {
      _lastError = error;
      _emit(LoginShowError(error));
    }
    if (next.isAuthenticated && !_wasAuthenticated) {
      _emit(const LoginAuthenticationSucceeded());
    }
    if (error == null) _lastError = null;
    _wasAuthenticated = next.isAuthenticated;
  }

  LoginFieldError? _emailError(String value) {
    if (value.trim().isEmpty) return LoginFieldError.emailRequired;
    if (!Validators.isEmailValid(value.trim())) {
      return LoginFieldError.emailInvalid;
    }
    return null;
  }

  LoginFieldError? _passwordError(String value) {
    if (value.isEmpty) return LoginFieldError.passwordRequired;
    if (value.length < 6) return LoginFieldError.passwordTooShort;
    return null;
  }

  void _emit(LoginEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
