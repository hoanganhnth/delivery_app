import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biometric_repository.dart';

/// UseCase to enable biometric login by saving auth session
class EnableBiometricUseCase extends UseCase<void, EnableBiometricParams> {
  final BiometricRepository repository;

  EnableBiometricUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(EnableBiometricParams params) async {
    // Validate inputs
    if (params.accessToken.isEmpty) {
      return left(const ValidationFailure('Access token cannot be empty'));
    }

    return await repository.saveAuthSession(
      accessToken: params.accessToken,
      refreshToken: params.refreshToken,
    );
  }
}

/// Parameters for enabling biometric login
class EnableBiometricParams {
  final String accessToken;
  final String? refreshToken;

  EnableBiometricParams({required this.accessToken, this.refreshToken});
}
