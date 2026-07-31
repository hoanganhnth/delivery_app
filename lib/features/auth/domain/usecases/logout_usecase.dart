import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase extends UseCase<void, LogoutParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LogoutParams params) {
    if (params.refreshToken.isEmpty) {
      return Future.value(
        left(const ValidationFailure('Refresh token cannot be empty')),
      );
    }
    return repository.logout(params.refreshToken);
  }
}

class LogoutParams {
  final String refreshToken;

  const LogoutParams({required this.refreshToken});

  @override
  String toString() => 'LogoutParams(refreshToken: [HIDDEN])';
}
