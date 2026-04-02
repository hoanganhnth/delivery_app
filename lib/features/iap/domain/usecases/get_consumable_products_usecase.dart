import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for getting available consumable products
class GetConsumableProductsUseCase {
  final IapRepository _repository;

  GetConsumableProductsUseCase(this._repository);

  Future<Either<Failure, List<ConsumableEntity>>> call() async {
    return await _repository.getConsumableProducts();
  }
}
