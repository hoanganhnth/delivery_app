import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/token_storage_repository.dart';
import '../datasources/token_local_data_source.dart';
import '../models/token_model.dart';

/// Implementation of TokenStorageRepository
class TokenStorageRepositoryImpl implements TokenStorageRepository {
  final TokenLocalDataSource _localDataSource;

  TokenStorageRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, void>> storeTokens(AuthEntity tokens) async {
    try {
      AppLogger.d('TokenStorageRepository: Storing tokens');
      
      final tokenModel = tokens.toModel();
      final result = await _localDataSource.storeTokens(tokenModel);
      
      return result.fold(
        (failure) {
          AppLogger.e('TokenStorageRepository: Failed to store tokens - ${failure.message}');
          return left(failure);
        },
        (success) {
          AppLogger.d('TokenStorageRepository: Tokens stored successfully');
          return right(null);
        },
      );
    } catch (e) {
      AppLogger.e('TokenStorageRepository: Error storing tokens - $e');
      return left(CacheFailure('Failed to store tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity?>> getTokens() async {
    try {
      AppLogger.d('TokenStorageRepository: Getting tokens');
      
      final result = await _localDataSource.getTokens();
      
      return result.fold(
        (failure) {
          AppLogger.e('TokenStorageRepository: Failed to get tokens - ${failure.message}');
          return left(failure);
        },
        (tokenModel) {
          if (tokenModel == null) {
            AppLogger.d('TokenStorageRepository: No tokens found');
            return right(null);
          }
          
          final tokenEntity = tokenModel.toEntity();
          AppLogger.d('TokenStorageRepository: Tokens retrieved successfully');
          return right(tokenEntity);
        },
      );
    } catch (e) {
      AppLogger.e('TokenStorageRepository: Error getting tokens - $e');
      return left(CacheFailure('Failed to get tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clearTokens() async {
    try {
      AppLogger.d('TokenStorageRepository: Clearing tokens');
      
      final result = await _localDataSource.clearTokens();
      
      return result.fold(
        (failure) {
          AppLogger.e('TokenStorageRepository: Failed to clear tokens - ${failure.message}');
          return left(failure);
        },
        (success) {
          AppLogger.d('TokenStorageRepository: Tokens cleared successfully');
          return right(null);
        },
      );
    } catch (e) {
      AppLogger.e('TokenStorageRepository: Error clearing tokens - $e');
      return left(CacheFailure('Failed to clear tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasTokens() async {
    try {
      AppLogger.d('TokenStorageRepository: Checking if tokens exist');
      
      final result = await _localDataSource.hasTokens();
      
      return result.fold(
        (failure) {
          AppLogger.e('TokenStorageRepository: Failed to check tokens - ${failure.message}');
          return left(failure);
        },
        (hasTokens) {
          AppLogger.d('TokenStorageRepository: Has tokens - $hasTokens');
          return right(hasTokens);
        },
      );
    } catch (e) {
      AppLogger.e('TokenStorageRepository: Error checking tokens - $e');
      return left(CacheFailure('Failed to check tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccessToken(String accessToken) async {
    try {
      AppLogger.d('TokenStorageRepository: Updating access token');
      
      final result = await _localDataSource.updateAccessToken(accessToken);
      
      return result.fold(
        (failure) {
          AppLogger.e('TokenStorageRepository: Failed to update access token - ${failure.message}');
          return left(failure);
        },
        (success) {
          AppLogger.d('TokenStorageRepository: Access token updated successfully');
          return right(null);
        },
      );
    } catch (e) {
      AppLogger.e('TokenStorageRepository: Error updating access token - $e');
      return left(CacheFailure('Failed to update access token: $e'));
    }
  }
}
