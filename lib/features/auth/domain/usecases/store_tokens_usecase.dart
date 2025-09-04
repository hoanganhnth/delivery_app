import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/token_storage_repository.dart';

/// Use case for storing authentication tokens
class StoreTokensUseCase implements UseCase<void, StoreTokensParams> {
  final TokenStorageRepository _repository;

  StoreTokensUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(StoreTokensParams params) {
    return _repository.storeTokens(params.tokens);
  }
}

/// Parameters for storing tokens
class StoreTokensParams {
  final AuthEntity tokens;

  StoreTokensParams({required this.tokens});
}
