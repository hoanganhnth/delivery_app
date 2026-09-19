import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/storage/secure_value_store.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../models/token_model.dart';
import 'token_local_data_source.dart';

/// Token persistence backed only by Keychain/Keystore secure storage.
class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  TokenLocalDataSourceImpl(
    this._secureStore, {
    SharedPreferences? legacyPreferences,
  }) : _legacyPreferences = legacyPreferences;

  static const String _tokenKey = 'delivery.auth.tokens.v1';
  static const List<String> _legacyKeys = [
    'auth_tokens',
    'access_token',
    'refresh_token',
  ];
  final SecureValueStore _secureStore;
  final SharedPreferences? _legacyPreferences;

  Future<void> _purgeLegacyCopies() async {
    final preferences = _legacyPreferences;
    if (preferences == null) return;
    for (final key in _legacyKeys) {
      await preferences.remove(key);
    }
  }

  @override
  Future<Either<Failure, void>> storeTokens(TokenModel tokens) async {
    try {
      await _purgeLegacyCopies();
      await _secureStore.write(_tokenKey, json.encode(tokens.toJson()));
      return right(null);
    } catch (error) {
      AppLogger.e('Secure token write failed', error);
      return left(CacheFailure('Failed to securely store tokens: $error'));
    }
  }

  @override
  Future<Either<Failure, TokenModel?>> getTokens() async {
    try {
      await _purgeLegacyCopies();
      final encoded = await _secureStore.read(_tokenKey);
      if (encoded == null) return right(null);
      return right(
        TokenModel.fromJson(json.decode(encoded) as Map<String, dynamic>),
      );
    } catch (error) {
      AppLogger.e('Secure token read failed', error);
      return left(CacheFailure('Failed to securely read tokens: $error'));
    }
  }

  @override
  Future<Either<Failure, void>> clearTokens() async {
    try {
      await _secureStore.delete(_tokenKey);
      await _purgeLegacyCopies();
      return right(null);
    } catch (error) {
      AppLogger.e('Secure token clear failed', error);
      return left(CacheFailure('Failed to securely clear tokens: $error'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasTokens() async {
    final result = await getTokens();
    return result.map((tokens) => tokens != null);
  }

  @override
  Future<Either<Failure, void>> updateAccessToken(String accessToken) async {
    final current = await getTokens();
    return current.fold(
      left,
      (tokens) => tokens == null
          ? left(const CacheFailure('No existing tokens to update'))
          : storeTokens(tokens.copyWith(accessToken: accessToken)),
    );
  }
}
