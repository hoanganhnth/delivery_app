import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biometric_repository.dart';

/// UseCase to check if biometric authentication is available on the device
class CheckBiometricAvailabilityUseCase extends UseCase<bool, NoParams> {
  final BiometricRepository repository;

  CheckBiometricAvailabilityUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isBiometricAvailable();
  }
}
