sealed class RegisterIntent {
  const RegisterIntent();
}

final class RegisterNameChanged extends RegisterIntent {
  const RegisterNameChanged(this.value);

  final String value;
}

final class RegisterEmailChanged extends RegisterIntent {
  const RegisterEmailChanged(this.value);

  final String value;
}

final class RegisterPasswordChanged extends RegisterIntent {
  const RegisterPasswordChanged(this.value);

  final String value;
}

final class RegisterConfirmationChanged extends RegisterIntent {
  const RegisterConfirmationChanged(this.value);

  final String value;
}

final class RegisterPasswordVisibilityToggled extends RegisterIntent {
  const RegisterPasswordVisibilityToggled();
}

final class RegisterConfirmationVisibilityToggled extends RegisterIntent {
  const RegisterConfirmationVisibilityToggled();
}

final class RegisterSubmitted extends RegisterIntent {
  const RegisterSubmitted();
}

final class RegisterBackRequested extends RegisterIntent {
  const RegisterBackRequested();
}

final class RegisterEffectConsumed extends RegisterIntent {
  const RegisterEffectConsumed(this.effectId);

  final int effectId;
}
