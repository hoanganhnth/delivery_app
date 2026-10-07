import 'dart:convert';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/storage/secure_value_store.dart';
import 'package:delivery_app/features/auth/data/datasources/token_local_data_source.dart';
import 'package:delivery_app/features/auth/data/datasources/token_local_data_source_impl.dart';
import 'package:delivery_app/features/auth/data/datasources/biometric_local_datasource_impl.dart';
import 'package:delivery_app/features/auth/data/models/token_model.dart';
import 'package:delivery_app/features/auth/data/repositories_impl/token_storage_repository_impl.dart';
import 'package:delivery_app/features/auth/data/repositories_impl/biometric_repository_impl.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/entities/biometric_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart' as native;
import 'package:mockito/mockito.dart';

class SecureMemory implements SecureValueStore {
  final values = <String, String>{};
  bool broken = false;
  void check() {
    if (broken) throw StateError('keystore unavailable');
  }

  @override
  Future<String?> read(String key) async {
    check();
    return values[key];
  }

  @override
  Future<void> write(String key, String value) async {
    check();
    values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    check();
    values.remove(key);
  }
}

class MemoryBox extends Mock implements Box<dynamic> {
  final entries = <dynamic, dynamic>{};
  bool broken = false;
  void check() {
    if (broken) throw StateError('box unavailable');
  }

  @override
  dynamic get(dynamic key, {dynamic defaultValue}) {
    check();
    return entries[key] ?? defaultValue;
  }

  @override
  Future<void> put(dynamic key, dynamic value) async {
    check();
    entries[key] = value;
  }

  @override
  Future<void> delete(dynamic key) async {
    check();
    entries.remove(key);
  }
}

class NativeBiometrics extends Mock implements native.LocalAuthentication {
  bool broken = false;
  bool accepted = true;
  String? reason;
  native.AuthenticationOptions? options;
  void check() {
    if (broken) throw StateError('sensor unavailable');
  }

  @override
  Future<bool> get canCheckBiometrics async {
    check();
    return accepted;
  }

  @override
  Future<bool> isDeviceSupported() async {
    check();
    return accepted;
  }

  @override
  Future<List<native.BiometricType>> getAvailableBiometrics() async {
    check();
    return native.BiometricType.values;
  }

  @override
  Future<bool> authenticate({
    required String localizedReason,
    Iterable<dynamic> authMessages = const [],
    native.AuthenticationOptions options = const native.AuthenticationOptions(),
  }) async {
    check();
    reason = localizedReason;
    this.options = options;
    return accepted;
  }
}

class ThrowingTokenSource implements TokenLocalDataSource {
  @override
  Future<Either<Failure, void>> storeTokens(TokenModel tokens) async =>
      throw StateError('write');
  @override
  Future<Either<Failure, TokenModel?>> getTokens() async =>
      throw StateError('read');
  @override
  Future<Either<Failure, void>> clearTokens() async =>
      throw StateError('clear');
  @override
  Future<Either<Failure, bool>> hasTokens() async => throw StateError('has');
  @override
  Future<Either<Failure, void>> updateAccessToken(String token) async =>
      throw StateError('update');
}

void main() {
  final tokens = AuthEntity(accessToken: 'access', refreshToken: 'refresh');
  test(
    'secure token repository roundtrip, rotation, existence and deletion',
    () async {
      final secure = SecureMemory();
      final repo = TokenStorageRepositoryImpl(TokenLocalDataSourceImpl(secure));
      (await repo.getTokens()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isNull),
      );
      (await repo.hasTokens()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isFalse),
      );
      expect((await repo.updateAccessToken('new')).isLeft(), isTrue);
      expect((await repo.storeTokens(tokens)).isRight(), isTrue);
      expect(jsonDecode(secure.values.values.single), {
        'accessToken': 'access',
        'refreshToken': 'refresh',
      });
      (await repo.getTokens()).fold((f) => fail(f.message), (v) {
        expect(v?.accessToken, 'access');
        expect(v?.refreshToken, 'refresh');
      });
      (await repo.hasTokens()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isTrue),
      );
      expect((await repo.updateAccessToken('new')).isRight(), isTrue);
      (await repo.getTokens()).fold((f) => fail(f.message), (v) {
        expect(v?.accessToken, 'new');
        expect(v?.refreshToken, 'refresh');
      });
      expect((await repo.clearTokens()).isRight(), isTrue);
      expect(secure.values, isEmpty);
    },
  );
  for (final thrown in [false, true]) {
    test(
      'token repository preserves cache failures and catches thrown errors: $thrown',
      () async {
        final repo = TokenStorageRepositoryImpl(
          thrown
              ? ThrowingTokenSource()
              : TokenLocalDataSourceImpl(SecureMemory()..broken = true),
        );
        for (final result in [
          await repo.storeTokens(tokens),
          await repo.getTokens(),
          await repo.clearTokens(),
          await repo.hasTokens(),
          await repo.updateAccessToken('new'),
        ]) {
          result.fold((f) {
            expect(f, isA<CacheFailure>());
            expect(f.message, contains('Failed'));
          }, (_) => fail('Expected cache failure'));
        }
      },
    );
  }
  test('malformed secure token JSON fails closed', () async {
    final secure = SecureMemory()
      ..values['delivery.auth.tokens.v1'] = '{broken';
    expect(
      (await TokenLocalDataSourceImpl(secure).getTokens()).isLeft(),
      isTrue,
    );
  });
  test(
    'biometric repository maps native types and stores sessions only in secure storage',
    () async {
      final secure = SecureMemory();
      final box = MemoryBox();
      final sensor = NativeBiometrics();
      final repo = BiometricRepositoryImpl(
        BiometricLocalDataSourceImpl(sensor, box, secure),
      );
      (await repo.isBiometricAvailable()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isTrue),
      );
      (await repo.getAvailableBiometrics()).fold(
        (f) => fail(f.message),
        (v) => expect(
          v,
          containsAll([
            BiometricType.face,
            BiometricType.fingerprint,
            BiometricType.iris,
          ]),
        ),
      );
      (await repo.authenticate(
        'Unlock session',
      )).fold((f) => fail(f.message), (v) => expect(v, isTrue));
      expect(sensor.reason, 'Unlock session');
      expect(sensor.options?.biometricOnly, isTrue);
      expect(sensor.options?.stickyAuth, isTrue);
      sensor.accepted = false;
      (await repo.authenticate(
        'Retry',
      )).fold((f) => fail(f.message), (v) => expect(v, isFalse));
      (await repo.isBiometricAvailable()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isFalse),
      );
      (await repo.getAuthSession()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isNull),
      );
      box.entries['biometric_auth_session'] = 'legacy plaintext';
      expect(
        (await repo.saveAuthSession(
          accessToken: 'access',
          refreshToken: 'refresh',
        )).isRight(),
        isTrue,
      );
      expect(box.entries.containsKey('biometric_auth_session'), isFalse);
      expect(box.entries, {'biometric_enabled': true});
      (await repo.getAuthSession()).fold((f) => fail(f.message), (v) {
        expect(v?.accessToken, 'access');
        expect(v?.refreshToken, 'refresh');
      });
      (await repo.isBiometricEnabled()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isTrue),
      );
      expect((await repo.setBiometricEnabled(false)).isRight(), isTrue);
      expect(secure.values, isEmpty);
      expect((await repo.setBiometricEnabled(true)).isRight(), isTrue);
      expect(
        (await repo.saveAuthSession(accessToken: 'access')).isRight(),
        isTrue,
      );
      (await repo.getAuthSession()).fold(
        (f) => fail(f.message),
        (v) => expect(v?.refreshToken, ''),
      );
      expect((await repo.clearAuthSession()).isRight(), isTrue);
      expect(box.entries['biometric_enabled'], isFalse);
      expect(secure.values, isEmpty);
    },
  );
  test(
    'biometric datasource errors are mapped; enabled flag reads fail closed',
    () async {
      final box = MemoryBox()..broken = true;
      final sensor = NativeBiometrics()..broken = true;
      final repo = BiometricRepositoryImpl(
        BiometricLocalDataSourceImpl(
          sensor,
          box,
          SecureMemory()..broken = true,
        ),
      );
      for (final result in [
        await repo.isBiometricAvailable(),
        await repo.getAvailableBiometrics(),
        await repo.authenticate('Unlock'),
        await repo.saveAuthSession(accessToken: 'access'),
        await repo.getAuthSession(),
        await repo.clearAuthSession(),
        await repo.setBiometricEnabled(true),
      ]) {
        result.fold(
          (f) => expect(f, isA<UnexpectedFailure>()),
          (_) => fail('Expected mapped failure'),
        );
      }
      (await repo.isBiometricEnabled()).fold(
        (f) => fail(f.message),
        (v) => expect(v, isFalse),
      );
    },
  );
}
