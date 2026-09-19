import 'package:delivery_app/core/storage/secure_value_store.dart';
import 'package:delivery_app/features/auth/data/datasources/token_local_data_source_impl.dart';
import 'package:delivery_app/features/auth/data/models/token_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class MemorySecureValueStore implements SecureValueStore {
  final Map<String, String> values = {};
  Object? readError;

  @override
  Future<String?> read(String key) async {
    if (readError case final error?) throw error;
    return values[key];
  }

  @override
  Future<void> write(String key, String value) async {
    values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    values.remove(key);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'stores one token pair only in secure storage and purges plaintext legacy copies',
    () async {
      SharedPreferences.setMockInitialValues({
        'auth_tokens': 'legacy-json',
        'access_token': 'legacy-access',
        'refresh_token': 'legacy-refresh',
      });
      final preferences = await SharedPreferences.getInstance();
      final secure = MemorySecureValueStore();
      final source = TokenLocalDataSourceImpl(
        secure,
        legacyPreferences: preferences,
      );

      final write = await source.storeTokens(
        const TokenModel(
          accessToken: 'access-secret',
          refreshToken: 'refresh-secret',
        ),
      );
      expect(write.isRight(), isTrue);
      expect(secure.values.values.single, contains('access-secret'));
      expect(preferences.getString('auth_tokens'), isNull);
      expect(preferences.getString('access_token'), isNull);
      expect(preferences.getString('refresh_token'), isNull);

      final read = await source.getTokens();
      read.fold((failure) => fail(failure.message), (tokens) {
        expect(tokens?.accessToken, 'access-secret');
        expect(tokens?.refreshToken, 'refresh-secret');
      });
    },
  );

  test('fails closed when secure storage cannot be read', () async {
    final secure = MemorySecureValueStore()
      ..readError = StateError('keystore unavailable');
    final result = await TokenLocalDataSourceImpl(secure).getTokens();
    expect(result.isLeft(), isTrue);
  });
}
