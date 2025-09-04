import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserProfileUseCase implements UseCase<UserEntity, NoParams> {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    // First try to get cached profile
    final cachedResult = await repository.getCachedUserProfile();
    
    // If cached profile exists and is recent, return it
    if (cachedResult.isRight()) {
      final cachedUser = cachedResult.fold((l) => null, (r) => r);
      if (cachedUser != null 
      // && _isCacheValid(cachedUser)
      ) {
        return right(cachedUser);
      }
    }
    
    // Otherwise, fetch from remote
    final remoteResult = await repository.getUserProfile();
    
    return remoteResult.fold(
      (failure) {
        // If remote fails, return cached profile if available
        final cachedUser = cachedResult.fold((l) => null, (r) => r);
        if (cachedUser != null) {
          return right(cachedUser);
        }
        return left(failure);
      },
      (user) {
        // Cache the fresh data
        repository.cacheUserProfile(user);
        return right(user);
      },
    );
  }

  // bool _isCacheValid(UserEntity user) {
  //   if (user.updatedAt == null) return false;
    
  //   final now = DateTime.now();
  //   final cacheAge = now.difference(user.updatedAt!);
    
  //   // Cache is valid for 1 hour
  //   return cacheAge.inHours < 1;
  // }
}
