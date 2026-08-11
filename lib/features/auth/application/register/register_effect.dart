import 'package:equatable/equatable.dart';

sealed class RegisterEffect extends Equatable {
  const RegisterEffect();
}

final class RegisterSucceeded extends RegisterEffect {
  const RegisterSucceeded();

  @override
  List<Object?> get props => const [];
}

final class RegisterNavigateBack extends RegisterEffect {
  const RegisterNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class RegisterShowError extends RegisterEffect {
  const RegisterShowError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
