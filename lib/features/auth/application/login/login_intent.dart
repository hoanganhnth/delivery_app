sealed class LoginIntent {
  const LoginIntent();
}

final class LoginEmailChanged extends LoginIntent {
  const LoginEmailChanged(this.value);

  final String value;
}

final class LoginPasswordChanged extends LoginIntent {
  const LoginPasswordChanged(this.value);

  final String value;
}

final class LoginPasswordVisibilityToggled extends LoginIntent {
  const LoginPasswordVisibilityToggled();
}

final class LoginForgotPasswordRequested extends LoginIntent {
  const LoginForgotPasswordRequested();
}

final class LoginSubmitted extends LoginIntent {
  const LoginSubmitted();
}

final class LoginGoogleRequested extends LoginIntent {
  const LoginGoogleRequested();
}

final class LoginRegisterRequested extends LoginIntent {
  const LoginRegisterRequested();
}

final class LoginEffectConsumed extends LoginIntent {
  const LoginEffectConsumed(this.effectId);

  final int effectId;
}
