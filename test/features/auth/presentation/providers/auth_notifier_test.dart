import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/services/app_initializer/i_app_initializer_service.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:delivery_app/features/auth/domain/repositories/token_storage_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/auth_di_providers.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/storage_di_providers.dart';
import 'package:delivery_app/features/auth/presentation/providers/session/auth_notifier.dart';
import 'package:delivery_app/features/auth/presentation/providers/session/auth_state.dart';
import 'package:delivery_app/core/services/app_initializer/_riverpod/app_initializer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  group('AuthNotifier', () {
    test('starts from initial state', () {
      final harness = _Harness();
      addTearDown(harness.dispose);

      expect(harness.container.read(authProvider), isA<AuthStateInitial>());
    });

    test('checkAuthStatus authenticates when stored tokens exist', () async {
      final harness = _Harness(
        storedTokens: AuthEntity(
          accessToken: 'stored-access',
          refreshToken: 'stored-refresh',
        ),
      );
      addTearDown(harness.dispose);

      final state = await harness.container
          .read(authProvider.notifier)
          .checkAuthStatus();

      expect(state.isAuthenticated, true);
      expect(state.accessToken, 'stored-access');
      expect(state.refreshToken, 'stored-refresh');
      expect(harness.container.read(authProvider).isAuthenticated, true);
    });

    test('login stores tokens and moves to authenticated state', () async {
      final harness = _Harness();
      addTearDown(harness.dispose);

      harness.authRepository.loginResult = Right(
        AuthEntity(accessToken: 'access-1', refreshToken: 'refresh-1'),
      );

      await harness.container
          .read(authProvider.notifier)
          .login(
            email: 'user@example.com',
            password: 'password123',
            deviceId: 'test-device',
          );

      final state = harness.container.read(authProvider);
      expect(state.isAuthenticated, true);
      expect(state.accessToken, 'access-1');
      expect(state.refreshToken, 'refresh-1');
      expect(harness.tokenStorage.storedTokens?.accessToken, 'access-1');
      expect(harness.authRepository.lastLoginParams?.deviceId, 'test-device');
    });

    test(
      'login failure keeps unauthenticated state and exposes failure',
      () async {
        final harness = _Harness();
        addTearDown(harness.dispose);

        harness.authRepository.loginResult = const Left(
          ServerFailure('Bad credentials'),
        );

        await harness.container
            .read(authProvider.notifier)
            .login(
              email: 'user@example.com',
              password: 'password123',
              deviceId: 'test-device',
            );

        final state = harness.container.read(authProvider);
        expect(state, isA<AuthStateUnauthenticated>());
        expect(state.isAuthenticated, false);
        expect(state.errorMessage, 'Bad credentials');
        expect(harness.tokenStorage.storeCalls, 0);
      },
    );

    test(
      'refreshToken stores new tokens and returns the access token',
      () async {
        final harness = _Harness();
        addTearDown(harness.dispose);

        harness.authRepository.loginResult = Right(
          AuthEntity(accessToken: 'old-access', refreshToken: 'old-refresh'),
        );
        harness.authRepository.refreshResult = Right(
          AuthEntity(accessToken: 'new-access', refreshToken: 'new-refresh'),
        );

        final notifier = harness.container.read(authProvider.notifier);
        await notifier.login(
          email: 'user@example.com',
          password: 'password123',
          deviceId: 'test-device',
        );

        final refreshedAccessToken = await notifier.refreshToken();

        final state = harness.container.read(authProvider);
        expect(refreshedAccessToken, 'new-access');
        expect(state.accessToken, 'new-access');
        expect(state.refreshToken, 'new-refresh');
        expect(harness.authRepository.lastRefreshToken, 'old-refresh');
        expect(harness.tokenStorage.storedTokens?.accessToken, 'new-access');
      },
    );

    test('logout runs cleanup, clears tokens and unauthenticates', () async {
      final harness = _Harness(
        storedTokens: AuthEntity(
          accessToken: 'stored-access',
          refreshToken: 'stored-refresh',
        ),
      );
      addTearDown(harness.dispose);

      final notifier = harness.container.read(authProvider.notifier);
      await notifier.checkAuthStatus();

      await notifier.logout();

      final state = harness.container.read(authProvider);
      expect(state, isA<AuthStateUnauthenticated>());
      expect(harness.appInitializer.cleanupCalls, 1);
      expect(harness.tokenStorage.clearCalls, 1);
      expect(harness.tokenStorage.storedTokens, isNull);
    });
  });
}

class _Harness {
  _Harness({AuthEntity? storedTokens})
    : authRepository = _FakeAuthRepository(),
      tokenStorage = _FakeTokenStorageRepository(storedTokens),
      appInitializer = _FakeAppInitializerService() {
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
        tokenStorageRepositoryProvider.overrideWithValue(tokenStorage),
        appInitializerServiceProvider.overrideWithValue(appInitializer),
      ],
    );
  }

  final _FakeAuthRepository authRepository;
  final _FakeTokenStorageRepository tokenStorage;
  final _FakeAppInitializerService appInitializer;
  late final ProviderContainer container;

  void dispose() => container.dispose();
}

class _FakeAuthRepository implements AuthRepository {
  Either<Failure, AuthEntity> loginResult = Right(
    AuthEntity(accessToken: 'access', refreshToken: 'refresh'),
  );
  Either<Failure, bool> registerResult = const Right(true);
  Either<Failure, AuthEntity> refreshResult = Right(
    AuthEntity(accessToken: 'new-access', refreshToken: 'new-refresh'),
  );
  Either<Failure, AuthEntity> socialLoginResult = Right(
    AuthEntity(accessToken: 'social-access', refreshToken: 'social-refresh'),
  );

  LoginParams? lastLoginParams;
  SocialLoginParams? lastSocialLoginParams;
  String? lastRegisterEmail;
  String? lastRegisterPassword;
  String? lastRefreshToken;

  @override
  Future<Either<Failure, AuthEntity>> login(LoginParams params) async {
    lastLoginParams = params;
    return loginResult;
  }

  @override
  Future<Either<Failure, bool>> register(String email, String password) async {
    lastRegisterEmail = email;
    lastRegisterPassword = password;
    return registerResult;
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    lastRefreshToken = refreshToken;
    return refreshResult;
  }

  @override
  Future<Either<Failure, AuthEntity>> socialLogin(
    SocialLoginParams params,
  ) async {
    lastSocialLoginParams = params;
    return socialLoginResult;
  }
}

class _FakeTokenStorageRepository implements TokenStorageRepository {
  _FakeTokenStorageRepository(this.storedTokens);

  AuthEntity? storedTokens;
  int storeCalls = 0;
  int clearCalls = 0;
  int updateAccessTokenCalls = 0;

  @override
  Future<Either<Failure, void>> clearTokens() async {
    clearCalls += 1;
    storedTokens = null;
    return const Right(null);
  }

  @override
  Future<Either<Failure, AuthEntity?>> getTokens() async {
    return Right(storedTokens);
  }

  @override
  Future<Either<Failure, bool>> hasTokens() async {
    return Right(storedTokens != null);
  }

  @override
  Future<Either<Failure, void>> storeTokens(AuthEntity tokens) async {
    storeCalls += 1;
    storedTokens = tokens;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateAccessToken(String accessToken) async {
    updateAccessTokenCalls += 1;
    if (storedTokens == null) {
      return const Left(CacheFailure('No stored tokens'));
    }
    storedTokens = AuthEntity(
      accessToken: accessToken,
      refreshToken: storedTokens!.refreshToken,
    );
    return const Right(null);
  }
}

class _FakeAppInitializerService implements IAppInitializerService {
  int initializeCalls = 0;
  int cleanupCalls = 0;

  @override
  Future<bool> initialize() async {
    initializeCalls += 1;
    return true;
  }

  @override
  Future<void> cleanup() async {
    cleanupCalls += 1;
  }
}
