import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'login_effect.dart';

enum LoginFieldError {
  emailRequired,
  emailInvalid,
  passwordRequired,
  passwordTooShort,
}

final class LoginViewState extends Equatable {
  const LoginViewState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
    this.isSubmitting = false,
    this.emailError,
    this.passwordError,
    this.authError,
    this.effects = const <UiEffectEnvelope<LoginEffect>>[],
  });

  final String email;
  final String password;
  final bool obscurePassword;
  final bool isSubmitting;
  final LoginFieldError? emailError;
  final LoginFieldError? passwordError;
  final String? authError;
  final List<UiEffectEnvelope<LoginEffect>> effects;

  LoginViewState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
    bool? isSubmitting,
    LoginFieldError? emailError,
    bool clearEmailError = false,
    LoginFieldError? passwordError,
    bool clearPasswordError = false,
    String? authError,
    bool clearAuthError = false,
    List<UiEffectEnvelope<LoginEffect>>? effects,
  }) {
    return LoginViewState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError
          ? null
          : (passwordError ?? this.passwordError),
      authError: clearAuthError ? null : (authError ?? this.authError),
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    obscurePassword,
    isSubmitting,
    emailError,
    passwordError,
    authError,
    effects,
  ];
}
