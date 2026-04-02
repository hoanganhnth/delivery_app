import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/purchase_entity.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case to purchase a subscription
class PurchaseSubscriptionUseCase {
  final IapRepository repository;

  PurchaseSubscriptionUseCase(this.repository);

  Future<Either<Failure, PurchaseEntity>> call(SubscriptionTier tier) async {
    return await repository.purchaseSubscription(tier);
  }
}
