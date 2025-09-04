import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../models/token_model.dart';
import 'token_local_data_source.dart';

/// Implementation of TokenLocalDataSource using SharedPreferences
class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final SharedPreferences _prefs;

  TokenLocalDataSourceImpl(this._prefs);

  static const String _tokenKey = 'auth_tokens';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  @override
  Future<Either<Failure, void>> storeTokens(TokenModel tokens) async {
    try {
      AppLogger.d('TokenLocalDataSource: Storing tokens');
      
      // Store as JSON
      final tokenJson = tokens.toJson();
      final tokenString = json.encode(tokenJson);
      
      final success = await _prefs.setString(_tokenKey, tokenString);
      
      if (!success) {
        AppLogger.e('TokenLocalDataSource: Failed to store tokens');
        return left(const CacheFailure('Failed to store tokens'));
      }
      
      // Also store individual tokens for easy access
      await Future.wait([
        _prefs.setString(_accessTokenKey, tokens.accessToken),
        _prefs.setString(_refreshTokenKey, tokens.refreshToken),
      ]);
      
      AppLogger.d('TokenLocalDataSource: Tokens stored successfully');
      return right(null);
    } catch (e) {
      AppLogger.e('TokenLocalDataSource: Error storing tokens - $e');
      return left(CacheFailure('Failed to store tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, TokenModel?>> getTokens() async {
    try {
      AppLogger.d('TokenLocalDataSource: Getting tokens');
      
      final tokenString = _prefs.getString(_tokenKey);
      
      if (tokenString == null) {
        AppLogger.d('TokenLocalDataSource: No tokens found');
        return right(null);
      }
      
      final tokenJson = json.decode(tokenString) as Map<String, dynamic>;
      final tokens = TokenModel.fromJson(tokenJson);
      
      AppLogger.d('TokenLocalDataSource: Tokens retrieved successfully');
      return right(tokens);
    } catch (e) {
      AppLogger.e('TokenLocalDataSource: Error getting tokens - $e');
      return left(CacheFailure('Failed to get tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clearTokens() async {
    try {
      AppLogger.d('TokenLocalDataSource: Clearing tokens');
      
      await Future.wait([
        _prefs.remove(_tokenKey),
        _prefs.remove(_accessTokenKey),
        _prefs.remove(_refreshTokenKey),
      ]);
      
      AppLogger.d('TokenLocalDataSource: Tokens cleared successfully');
      return right(null);
    } catch (e) {
      AppLogger.e('TokenLocalDataSource: Error clearing tokens - $e');
      return left(CacheFailure('Failed to clear tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasTokens() async {
    try {
      final hasTokens = _prefs.containsKey(_tokenKey) || 
                       _prefs.containsKey(_accessTokenKey);
      
      AppLogger.d('TokenLocalDataSource: Has tokens - $hasTokens');
      return right(hasTokens);
    } catch (e) {
      AppLogger.e('TokenLocalDataSource: Error checking tokens - $e');
      return left(CacheFailure('Failed to check tokens: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAccessToken(String accessToken) async {
    try {
      AppLogger.d('TokenLocalDataSource: Updating access token');
      
      // Get current tokens
      final currentResult = await getTokens();
      
      return currentResult.fold(
        (failure) => left(failure),
        (currentTokens) async {
          if (currentTokens == null) {
            return left(const CacheFailure('No existing tokens to update'));
          }
          
          // Create updated tokens
          final updatedTokens = currentTokens.copyWith(
            accessToken: accessToken,
          );
          
          // Store updated tokens
          return await storeTokens(updatedTokens);
        },
      );
    } catch (e) {
      AppLogger.e('TokenLocalDataSource: Error updating access token - $e');
      return left(CacheFailure('Failed to update access token: $e'));
    }
  }

  /// Get access token directly
  Future<String?> getAccessToken() async {
    return _prefs.getString(_accessTokenKey);
  }

  /// Get refresh token directly
  Future<String?> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey);
  }
}
