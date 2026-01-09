import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biometric_repository.dart';

/// UseCase to authenticate user using biometric
class AuthenticateWithBiometricUseCase
    extends UseCase<bool, AuthenticateWithBiometricParams> {
  final BiometricRepository repository;

  AuthenticateWithBiometricUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(
    AuthenticateWithBiometricParams params,
  ) async {
    return await repository.authenticate(params.reason);
  }
}

/// Parameters for biometric authentication
class AuthenticateWithBiometricParams {
  final String reason;

  AuthenticateWithBiometricParams({required this.reason});
}
