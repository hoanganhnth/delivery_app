import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/biometric_entity.dart';
import '../repositories/biometric_repository.dart';

/// UseCase to get list of available biometric types on the device
class GetAvailableBiometricsUseCase
    extends UseCase<List<BiometricType>, NoParams> {
  final BiometricRepository repository;

  GetAvailableBiometricsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BiometricType>>> call(NoParams params) async {
    return await repository.getAvailableBiometrics();
  }
}
