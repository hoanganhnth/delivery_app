import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for deducting credits from user's balance when used
class DeductCreditsUseCase {
  final IapRepository _repository;

  DeductCreditsUseCase(this._repository);

  Future<Either<Failure, int>> call(int amount) async {
    if (amount <= 0) {
      return left(const ValidationFailure('Amount must be greater than 0'));
    }
    
    // First check if user has enough credits
    final balanceResult = await _repository.getUserCredits();
    return balanceResult.fold(
      (failure) => left(failure),
      (balance) {
        if (balance < amount) {
          return left(const ValidationFailure('Insufficient credits'));
        }
        return _repository.deductCredits(amount);
      },
    );
  }
}
