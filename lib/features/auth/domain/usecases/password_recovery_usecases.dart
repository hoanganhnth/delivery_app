import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:delivery_app/core/utils/validators.dart';
import 'package:delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RequestPasswordResetUseCase
    extends UseCase<void, RequestPasswordResetParams> {
  RequestPasswordResetUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(RequestPasswordResetParams params) {
    final email = params.email.trim();
    if (!Validators.isEmailValid(email)) {
      return Future.value(left(const ValidationFailure('Invalid email format')));
    }
    return repository.requestPasswordReset(email);
  }
}

class RequestPasswordResetParams {
  const RequestPasswordResetParams({required this.email});

  final String email;
}

class ResetPasswordUseCase extends UseCase<void, ResetPasswordParams> {
  ResetPasswordUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) {
    if (params.token.trim().length < 32) {
      return Future.value(left(const ValidationFailure('Invalid reset token')));
    }
    if (!Validators.isPasswordValid(params.newPassword)) {
      return Future.value(left(const ValidationFailure('Invalid password')));
    }
    return repository.resetPassword(params.token.trim(), params.newPassword);
  }
}

class ResetPasswordParams {
  const ResetPasswordParams({required this.token, required this.newPassword});

  final String token;
  final String newPassword;
}
