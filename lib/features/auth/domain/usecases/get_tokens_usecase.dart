import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/token_storage_repository.dart';

/// Use case for getting stored authentication tokens
class GetTokensUseCase implements UseCase<AuthEntity?, NoParams> {
  final TokenStorageRepository _repository;

  GetTokensUseCase(this._repository);

  @override
  Future<Either<Failure, AuthEntity?>> call(NoParams params) {
    return _repository.getTokens();
  }
}
