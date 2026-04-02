import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case to restore previous purchases
class RestorePurchasesUseCase {
  final IapRepository repository;

  RestorePurchasesUseCase(this.repository);

  Future<Either<Failure, List<PurchaseEntity>>> call() async {
    return await repository.restorePurchases();
  }
}
