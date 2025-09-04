import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/token_storage_repository.dart';

/// Use case for clearing stored authentication tokens
class ClearTokensUseCase implements UseCase<void, NoParams> {
  final TokenStorageRepository _repository;

  ClearTokensUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _repository.clearTokens();
  }
}
