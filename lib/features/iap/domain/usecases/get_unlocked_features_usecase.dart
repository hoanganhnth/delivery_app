import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for getting list of unlocked features
class GetUnlockedFeaturesUseCase {
  final IapRepository _repository;

  GetUnlockedFeaturesUseCase(this._repository);

  Future<Either<Failure, List<FeatureType>>> call() async {
    return await _repository.getUnlockedFeatures();
  }
}
