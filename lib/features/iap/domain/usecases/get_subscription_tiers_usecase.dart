import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case to get available subscription tiers
class GetSubscriptionTiersUseCase {
  final IapRepository repository;

  GetSubscriptionTiersUseCase(this.repository);

  Future<Either<Failure, List<SubscriptionEntity>>> call() async {
    return await repository.getSubscriptionTiers();
  }
}
