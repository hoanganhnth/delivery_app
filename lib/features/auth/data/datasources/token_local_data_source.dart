import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../models/token_model.dart';

/// Abstract interface for local token storage
abstract class TokenLocalDataSource {
  /// Store authentication tokens locally
  Future<Either<Failure, void>> storeTokens(TokenModel tokens);
  
  /// Get stored authentication tokens
  Future<Either<Failure, TokenModel?>> getTokens();
  
  /// Clear all stored tokens
  Future<Either<Failure, void>> clearTokens();
  
  /// Check if tokens exist
  Future<Either<Failure, bool>> hasTokens();
  
  /// Update access token only
  Future<Either<Failure, void>> updateAccessToken(String accessToken);
}
