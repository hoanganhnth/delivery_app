import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

class ClearProfileCacheUseCase implements UseCase<void, NoParams> {
  final ProfileRepository repository;

  ClearProfileCacheUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearCachedUserProfile();
  }
}
