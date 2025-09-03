import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class ProfileRepository {
  /// Get user profile from remote server
  Future<Either<Failure, UserEntity>> getUserProfile();
  
  /// Update user profile on remote server
  Future<Either<Failure, UserEntity>> updateUserProfile(UserEntity user);
  
  /// Get cached user profile from local storage
  Future<Either<Failure, UserEntity?>> getCachedUserProfile();
  
  /// Cache user profile to local storage
  Future<Either<Failure, void>> cacheUserProfile(UserEntity user);
  
  /// Clear cached user profile
  Future<Either<Failure, void>> clearCachedUserProfile();
  
  /// Upload user avatar
  Future<Either<Failure, String>> uploadAvatar(String imagePath);
  
}
