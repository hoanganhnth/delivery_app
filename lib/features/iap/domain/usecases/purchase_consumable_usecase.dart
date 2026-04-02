import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for purchasing a consumable product
/// Note: Purchase result will be delivered via purchaseStream, not the return value
class PurchaseConsumableUseCase {
  final IapRepository _repository;

  PurchaseConsumableUseCase(this._repository);

  Future<Either<Failure, void>> call(String productId) async {
    if (productId.isEmpty) {
      return left(const ValidationFailure('Product ID cannot be empty'));
    }
    return await _repository.purchaseConsumable(productId);
  }
}
