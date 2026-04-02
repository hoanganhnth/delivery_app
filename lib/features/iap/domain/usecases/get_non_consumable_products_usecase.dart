import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for getting available non-consumable products
class GetNonConsumableProductsUseCase {
  final IapRepository _repository;

  GetNonConsumableProductsUseCase(this._repository);

  Future<Either<Failure, List<NonConsumableEntity>>> call() async {
    return await _repository.getNonConsumableProducts();
  }
}
