import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/token_model.dart';
import '../repositories/biometric_repository.dart';

/// UseCase to get saved auth session for biometric login
class GetAuthSessionUseCase extends UseCase<TokenModel?, NoParams> {
  final BiometricRepository repository;

  GetAuthSessionUseCase(this.repository);

  @override
  Future<Either<Failure, TokenModel?>> call(NoParams params) async {
    return await repository.getAuthSession();
  }
}
