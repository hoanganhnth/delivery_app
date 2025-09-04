import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserProfileParams {
  final bool forceRefresh;
  final bool useCache;

  const GetUserProfileParams({
    this.forceRefresh = false,
    this.useCache = true,
  });
}

class GetUserProfileUseCase implements UseCase<UserEntity, GetUserProfileParams> {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(GetUserProfileParams params) async {
    // If force refresh is requested, skip cache
    if (params.forceRefresh || !params.useCache) {
      return await _fetchFromRemote();
    }

    // First try to get cached profile
    final cachedResult = await repository.getCachedUserProfile();
    
    // If cached profile exists, return it
    if (cachedResult.isRight()) {
      final cachedUser = cachedResult.fold((l) => null, (r) => r);
      if (cachedUser != null) {
        return right(cachedUser);
      }
    }
    
    // Otherwise, fetch from remote
    return await _fetchFromRemote();
  }

  Future<Either<Failure, UserEntity>> _fetchFromRemote() async {
    final remoteResult = await repository.getUserProfile();
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return remoteResult;
  }

  // bool _isCacheValid(UserEntity user) {
  //   if (user.updatedAt == null) return false;
    
  //   final now = DateTime.now();
  //   final cacheAge = now.difference(user.updatedAt!);
    
  //   // Cache is valid for 1 hour
  //   return cacheAge.inHours < 1;
  // }
}
