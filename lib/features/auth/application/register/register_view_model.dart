import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/utils/validators.dart';
import 'package:delivery_app/features/auth/application/session/auth_notifier.dart';

import 'register_effect.dart';
import 'register_intent.dart';
import 'register_state.dart';

final registerViewModelProvider =
    NotifierProvider<RegisterViewModel, RegisterViewState>(
      RegisterViewModel.new,
    );

class RegisterViewModel extends Notifier<RegisterViewState> {
  int _nextEffectId = 0;

  @override
  RegisterViewState build() => const RegisterViewState();

  Future<void> dispatch(RegisterIntent intent) async {
    switch (intent) {
      case RegisterNameChanged(:final value):
        state = state.copyWith(name: value);
      case RegisterEmailChanged(:final value):
        state = state.copyWith(email: value, clearEmailError: true);
      case RegisterPasswordChanged(:final value):
        state = state.copyWith(
          password: value,
          clearPasswordError: true,
          clearConfirmationError: true,
        );
      case RegisterConfirmationChanged(:final value):
        state = state.copyWith(
          confirmation: value,
          clearConfirmationError: true,
        );
      case RegisterPasswordVisibilityToggled():
        state = state.copyWith(obscurePassword: !state.obscurePassword);
      case RegisterConfirmationVisibilityToggled():
        state = state.copyWith(obscureConfirmation: !state.obscureConfirmation);
      case RegisterSubmitted():
        await _submit();
      case RegisterBackRequested():
        _emit(const RegisterNavigateBack());
      case RegisterEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _submit() async {
    if (state.isSubmitting) return;
    final emailError = _emailError(state.email);
    final passwordError = _passwordError(state.password);
    final confirmationError = _confirmationError(
      state.password,
      state.confirmation,
    );
    if (emailError != null ||
        passwordError != null ||
        confirmationError != null) {
      state = state.copyWith(
        emailError: emailError,
        passwordError: passwordError,
        confirmationError: confirmationError,
      );
      return;
    }

    state = state.copyWith(
      isSubmitting: true,
      clearEmailError: true,
      clearPasswordError: true,
      clearConfirmationError: true,
    );
    final registration = await ref
        .read(authProvider.notifier)
        .register(
          name: state.name.trim(),
          email: state.email.trim(),
          password: state.password,
          confirmPassword: state.confirmation,
        );
    if (!ref.mounted) return;

    state = state.copyWith(isSubmitting: false);
    if (registration?.profileCreated == true) {
      _emit(const RegisterSucceeded());
    } else if (registration != null) {
      _emit(
        RegisterShowError(
          registration.recoveryMessage ??
              'Registration is still being completed. Please submit again.',
        ),
      );
    } else {
      final message = ref.read(authProvider).errorMessage;
      if (message != null && message.isNotEmpty) {
        _emit(RegisterShowError(message));
      }
    }
  }

  RegisterFieldError? _emailError(String value) {
    if (value.trim().isEmpty) return RegisterFieldError.emailRequired;
    if (!Validators.isEmailValid(value.trim())) {
      return RegisterFieldError.emailInvalid;
    }
    return null;
  }

  RegisterFieldError? _passwordError(String value) {
    if (value.isEmpty) return RegisterFieldError.passwordRequired;
    if (value.length < 6) return RegisterFieldError.passwordTooShort;
    return null;
  }

  RegisterFieldError? _confirmationError(String password, String confirmation) {
    if (confirmation.isEmpty) return RegisterFieldError.confirmationRequired;
    if (confirmation != password) {
      return RegisterFieldError.passwordsDoNotMatch;
    }
    return null;
  }

  void _emit(RegisterEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
