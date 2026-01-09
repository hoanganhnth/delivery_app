import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biometric_repository.dart';

/// UseCase to disable biometric login by clearing saved auth session
class DisableBiometricUseCase extends UseCase<void, NoParams> {
  final BiometricRepository repository;

  DisableBiometricUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearAuthSession();
  }
}
