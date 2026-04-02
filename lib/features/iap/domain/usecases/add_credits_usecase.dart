import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for adding credits to user's balance after purchase
class AddCreditsUseCase {
  final IapRepository _repository;

  AddCreditsUseCase(this._repository);

  Future<Either<Failure, int>> call(int amount) async {
    if (amount <= 0) {
      return left(const ValidationFailure('Amount must be greater than 0'));
    }
    return await _repository.addCredits(amount);
  }
}
