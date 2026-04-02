import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case to get active subscription
class GetActiveSubscriptionUseCase {
  final IapRepository repository;

  GetActiveSubscriptionUseCase(this.repository);

  Future<Either<Failure, SubscriptionEntity?>> call() async {
    return await repository.getActiveSubscription();
  }
}
