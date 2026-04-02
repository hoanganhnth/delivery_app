import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/domain/repositories/iap_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Use case for checking if a specific feature is unlocked
class CheckFeatureUnlockedUseCase {
  final IapRepository _repository;

  CheckFeatureUnlockedUseCase(this._repository);

  Future<Either<Failure, bool>> call(FeatureType featureType) async {
    return await _repository.isFeatureUnlocked(featureType);
  }
}
