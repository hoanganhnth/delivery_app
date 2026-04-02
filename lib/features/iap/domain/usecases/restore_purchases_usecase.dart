import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case to restore previous purchases
/// Note: Restored purchases will be delivered via purchaseStream, not the return value
class RestorePurchasesUseCase {
  final IapRepository repository;

  RestorePurchasesUseCase(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.restorePurchases();
  }
}
