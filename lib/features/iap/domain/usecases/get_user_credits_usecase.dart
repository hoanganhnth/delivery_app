import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for getting user's current credits balance
class GetUserCreditsUseCase {
  final IapRepository _repository;

  GetUserCreditsUseCase(this._repository);

  Future<Either<Failure, int>> call() async {
    return await _repository.getUserCredits();
  }
}
