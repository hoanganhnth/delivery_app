import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for purchasing a non-consumable product (unlock feature)
/// Note: Purchase result will be delivered via purchaseStream, not the return value
class PurchaseNonConsumableUseCase {
  final IapRepository _repository;

  PurchaseNonConsumableUseCase(this._repository);

  Future<Either<Failure, void>> call(FeatureType featureType) async {
    // Check if feature is already unlocked
    final unlockedResult = await _repository.isFeatureUnlocked(featureType);
    
    return unlockedResult.fold(
      (failure) => left(failure),
      (isUnlocked) async {
        if (isUnlocked) {
          return left(const ValidationFailure('Feature is already unlocked'));
        }
        return _repository.purchaseNonConsumable(featureType.productId);
      },
    );
  }
}
