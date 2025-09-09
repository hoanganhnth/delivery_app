import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/core/error/error_mapper.dart';
import 'package:delivery_app/features/profile/data/dtos/user_profile_dto.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';
import '../dtos/update_profile_request_dto.dart';
import '../models/user_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserProfile() async {
    try {
      AppLogger.i('Repository: Getting user profile');

      final response = await remoteDataSource.getUserProfile();

      if (response.isSuccess && response.data != null) {
        AppLogger.i('Repository: Get user profile successful');
        final user = response.data!.toEntity();

        // Cache the user profile
        final userModel = UserModelExtension.fromEntity(user);
        localDataSource.cacheUserProfile(userModel);

        return right(user);
      } else {
        AppLogger.e(
          'Repository: Get user profile failed - ${response.message}',
        );
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      AppLogger.e('Repository: Failed to get user profile - $e');
      return left(mapExceptionToFailure(e));
    } catch (e) {
      AppLogger.e('Repository: Unexpected error during get user profile - $e');
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile(UserEntity user) async {
    try {
      AppLogger.i('Repository: Updating user profile');

      final request = UpdateProfileRequestDtoExtension.fromEntity(user);
      final response = await remoteDataSource.updateUserProfile(request);

      if (response.isSuccess && response.data != null) {
        AppLogger.i('Repository: Update user profile successful');
        final updatedUser = response.data!.toEntity();

        // Cache the updated user profile
        final userModel = UserModelExtension.fromEntity(updatedUser);
        localDataSource.cacheUserProfile(userModel);

        return right(updatedUser);
      } else {
        AppLogger.e(
          'Repository: Update user profile failed - ${response.message}',
        );
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      AppLogger.e('Repository: Failed to update user profile - $e');
      return left(mapExceptionToFailure(e));
    } catch (e) {
      AppLogger.e(
        'Repository: Unexpected error during update user profile - $e',
      );
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCachedUserProfile() async {
    try {
      AppLogger.i('Repository: Getting cached user profile');

      final result = await localDataSource.getCachedUserProfile();

      return result.fold(
        (exception) {
          AppLogger.e(
            'Repository: Failed to get cached user profile - $exception',
          );
          return left(CacheFailure('Failed to get cached profile'));
        },
        (userModel) {
          if (userModel != null) {
            AppLogger.i('Repository: Cached user profile found');
            return right(userModel.toEntity());
          } else {
            AppLogger.i('Repository: No cached user profile found');
            return right(null);
          }
        },
      );
    } catch (e) {
      AppLogger.e(
        'Repository: Unexpected error during get cached user profile - $e',
      );
      return left(const CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> cacheUserProfile(UserEntity user) async {
    try {
      AppLogger.i('Repository: Caching user profile');

      final userModel = UserModelExtension.fromEntity(user);
      final result = await localDataSource.cacheUserProfile(userModel);

      return result.fold(
        (exception) {
          AppLogger.e('Repository: Failed to cache user profile - $exception');
          return left(CacheFailure('Failed to cache profile'));
        },
        (_) {
          AppLogger.i('Repository: User profile cached successfully');
          return right(null);
        },
      );
    } catch (e) {
      AppLogger.e(
        'Repository: Unexpected error during cache user profile - $e',
      );
      return left(const CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCachedUserProfile() async {
    try {
      AppLogger.i('Repository: Clearing cached user profile');

      final result = await localDataSource.clearCachedUserProfile();

      return result.fold(
        (exception) {
          AppLogger.e(
            'Repository: Failed to clear cached user profile - $exception',
          );
          return left(CacheFailure('Failed to clear cached profile'));
        },
        (_) {
          AppLogger.i('Repository: Cached user profile cleared successfully');
          return right(null);
        },
      );
    } catch (e) {
      AppLogger.e(
        'Repository: Unexpected error during clear cached user profile - $e',
      );
      return left(const CacheFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(String imagePath) async {
    try {
      AppLogger.i('Repository: Uploading avatar');

      final response = await remoteDataSource.uploadAvatar(imagePath);

      if (response.isSuccess && response.data != null) {
        AppLogger.i('Repository: Upload avatar successful');
        return right(response.data!);
      } else {
        AppLogger.e('Repository: Upload avatar failed - ${response.message}');
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      AppLogger.e('Repository: Failed to upload avatar - $e');
      return left(mapExceptionToFailure(e));
    } catch (e) {
      AppLogger.e('Repository: Unexpected error during upload avatar - $e');
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
