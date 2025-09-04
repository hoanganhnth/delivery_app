import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_entity.dart';

/// Abstract repository for token storage operations
abstract class TokenStorageRepository {
  /// Store authentication tokens
  Future<Either<Failure, void>> storeTokens(AuthEntity tokens);
  
  /// Get stored authentication tokens
  Future<Either<Failure, AuthEntity?>> getTokens();
  
  /// Clear all stored tokens
  Future<Either<Failure, void>> clearTokens();
  
  /// Check if tokens exist
  Future<Either<Failure, bool>> hasTokens();
  
  /// Update access token
  Future<Either<Failure, void>> updateAccessToken(String accessToken);
}
