import 'package:equatable/equatable.dart';

sealed class LoginEffect extends Equatable {
  const LoginEffect();
}

final class LoginAuthenticationSucceeded extends LoginEffect {
  const LoginAuthenticationSucceeded();

  @override
  List<Object?> get props => const [];
}

final class LoginNavigateToRegister extends LoginEffect {
  const LoginNavigateToRegister();

  @override
  List<Object?> get props => const [];
}

final class LoginShowError extends LoginEffect {
  const LoginShowError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
