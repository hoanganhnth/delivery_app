import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'register_effect.dart';

enum RegisterFieldError {
  emailRequired,
  emailInvalid,
  passwordRequired,
  passwordTooShort,
  confirmationRequired,
  passwordsDoNotMatch,
}

final class RegisterViewState extends Equatable {
  const RegisterViewState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmation = '',
    this.obscurePassword = true,
    this.obscureConfirmation = true,
    this.isSubmitting = false,
    this.emailError,
    this.passwordError,
    this.confirmationError,
    this.effects = const <UiEffectEnvelope<RegisterEffect>>[],
  });

  final String name;
  final String email;
  final String password;
  final String confirmation;
  final bool obscurePassword;
  final bool obscureConfirmation;
  final bool isSubmitting;
  final RegisterFieldError? emailError;
  final RegisterFieldError? passwordError;
  final RegisterFieldError? confirmationError;
  final List<UiEffectEnvelope<RegisterEffect>> effects;

  RegisterViewState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmation,
    bool? obscurePassword,
    bool? obscureConfirmation,
    bool? isSubmitting,
    RegisterFieldError? emailError,
    bool clearEmailError = false,
    RegisterFieldError? passwordError,
    bool clearPasswordError = false,
    RegisterFieldError? confirmationError,
    bool clearConfirmationError = false,
    List<UiEffectEnvelope<RegisterEffect>>? effects,
  }) {
    return RegisterViewState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmation: confirmation ?? this.confirmation,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmation: obscureConfirmation ?? this.obscureConfirmation,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError
          ? null
          : (passwordError ?? this.passwordError),
      confirmationError: clearConfirmationError
          ? null
          : (confirmationError ?? this.confirmationError),
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmation,
    obscurePassword,
    obscureConfirmation,
    isSubmitting,
    emailError,
    passwordError,
    confirmationError,
    effects,
  ];
}
