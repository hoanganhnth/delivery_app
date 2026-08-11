import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/biometric_repository.dart';

/// UseCase to get saved auth session for biometric login
class GetAuthSessionUseCase extends UseCase<AuthEntity?, NoParams> {
  final BiometricRepository repository;

  GetAuthSessionUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity?>> call(NoParams params) async {
    return await repository.getAuthSession();
  }
}
