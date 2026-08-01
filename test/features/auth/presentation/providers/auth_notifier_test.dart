import 'dart:async';

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
import 'package:delivery_app/features/auth/services/auth_platform_ports.dart';
import 'package:delivery_app/features/auth/presentation/widgets/login_form.dart';
import 'package:delivery_app/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/app_harness.dart';

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

    test('login resolves device identity through the injected port', () async {
      final harness = _Harness();
      addTearDown(harness.dispose);

      await harness.container
          .read(authProvider.notifier)
          .login(email: 'user@example.com', password: 'password123');

      expect(harness.deviceIdentity.calls, 1);
      expect(
        harness.authRepository.lastLoginParams?.deviceId,
        'device-test-id',
      );
      expect(harness.authRepository.lastLoginParams?.deviceName, 'Test Device');
      expect(harness.authRepository.lastLoginParams?.deviceType, 'MOBILE');
    });

    test(
      'Google login uses injected social identity and stores tokens',
      () async {
        final harness = _Harness();
        addTearDown(harness.dispose);

        await harness.container.read(authProvider.notifier).loginWithGoogle();

        expect(harness.socialIdentity.calls, 1);
        expect(
          harness.authRepository.lastSocialLoginParams?.token,
          'google-id-token',
        );
        expect(harness.authRepository.lastSocialLoginParams?.role, 'USER');
        expect(harness.container.read(authProvider).isAuthenticated, true);
        expect(harness.tokenStorage.storedTokens?.accessToken, 'social-access');
      },
    );

    test(
      'cancelled Google login returns to unauthenticated without API call',
      () async {
        final harness = _Harness(googleIdToken: null);
        addTearDown(harness.dispose);

        await harness.container.read(authProvider.notifier).loginWithGoogle();

        expect(
          harness.container.read(authProvider),
          isA<AuthStateUnauthenticated>(),
        );
        expect(harness.authRepository.lastSocialLoginParams, isNull);
        expect(harness.tokenStorage.storeCalls, 0);
      },
    );

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
      expect(harness.authRepository.logoutCalls, 1);
      expect(harness.authRepository.lastLogoutToken, 'stored-refresh');
      expect(harness.tokenStorage.clearCalls, 1);
      expect(harness.tokenStorage.storedTokens, isNull);
    });

    test(
      'register completes both backend steps without automatic login',
      () async {
        final harness = _Harness();
        addTearDown(harness.dispose);
        final notifier = harness.container.read(authProvider.notifier);

        harness.authRepository.registerResult = const Left(
          ServerFailure('Email đã tồn tại'),
        );
        final failed = await notifier.register(
          name: 'Customer Test',
          email: 'customer@test.dev',
          password: 'secret123',
          confirmPassword: 'secret123',
        );
        expect(
          harness.container.read(authProvider).errorMessage,
          'Email đã tồn tại',
        );
        expect(harness.authRepository.loginCalls, 0);
        expect(failed, isFalse);

        harness.authRepository.registerResult = const Right(true);
        final succeeded = await notifier.register(
          name: 'Customer Test',
          email: 'customer@test.dev',
          password: 'secret123',
          confirmPassword: 'secret123',
        );

        expect(harness.authRepository.registerCalls, 2);
        expect(harness.authRepository.lastRegisterEmail, 'customer@test.dev');
        expect(succeeded, isTrue);
        expect(harness.authRepository.loginCalls, 0);
        expect(harness.container.read(authProvider).isAuthenticated, isFalse);
      },
    );

    testWidgets(
      'login form validates, stays single-submit and invokes Google through ports',
      (tester) async {
        final harness = _Harness();
        addTearDown(harness.dispose);
        final loginCompleter = Completer<Either<Failure, AuthEntity>>();
        harness.authRepository.loginCompleter = loginCompleter;

        await pumpTestApp(
          tester,
          overrides: harness.overrides,
          child: const LoginForm(),
        );

        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();
        expect(harness.authRepository.loginCalls, 0);

        await tester.enterText(
          find.byType(TextFormField).at(0),
          'customer@test.dev',
        );
        await tester.enterText(find.byType(TextFormField).at(1), 'secret123');
        await tester.tap(find.byKey(const Key('login_button')));
        await tester.pump();

        expect(harness.authRepository.loginCalls, 1);
        expect(
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
          isNull,
        );
        await tester.tap(find.byKey(const Key('login_button')));
        expect(harness.authRepository.loginCalls, 1);

        loginCompleter.complete(
          Right(
            AuthEntity(
              accessToken: 'form-access',
              refreshToken: 'form-refresh',
            ),
          ),
        );
        await tester.pumpAndSettle();

        final container = ProviderScope.containerOf(
          tester.element(find.byType(LoginForm)),
        );
        expect(container.read(authProvider).isAuthenticated, isTrue);

        await tester.tap(find.byIcon(Icons.g_mobiledata));
        await tester.pumpAndSettle();
        expect(harness.socialIdentity.calls, 1);
        expect(
          harness.authRepository.lastSocialLoginParams?.token,
          'google-id-token',
        );
      },
    );

    testWidgets(
      'register form validates, disables duplicate submit and returns to login',
      (tester) async {
        final harness = _Harness();
        addTearDown(harness.dispose);
        final registerCompleter = Completer<Either<Failure, bool>>();
        harness.authRepository.registerCompleter = registerCompleter;

        await pumpTestApp(
          tester,
          overrides: harness.overrides,
          child: const RegisterForm(),
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
        expect(harness.authRepository.registerCalls, 0);

        final fields = find.byType(TextFormField);
        await tester.enterText(fields.at(0), ' Customer Test ');
        await tester.enterText(fields.at(1), ' customer@test.dev ');
        await tester.enterText(fields.at(2), 'secret123');
        await tester.enterText(fields.at(3), 'secret123');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(harness.authRepository.registerCalls, 1);
        expect(
          tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
          isNull,
        );
        await tester.tap(find.byType(ElevatedButton));
        expect(harness.authRepository.registerCalls, 1);

        registerCompleter.complete(const Right(true));
        await tester.pumpAndSettle();

        final container = ProviderScope.containerOf(
          tester.element(find.byType(RegisterForm)),
        );
        expect(harness.authRepository.lastRegisterEmail, 'customer@test.dev');
        expect(harness.authRepository.loginCalls, 0);
        expect(container.read(authProvider).isAuthenticated, isFalse);
      },
    );
  });
}

class _Harness {
  _Harness({
    AuthEntity? storedTokens,
    String? googleIdToken = 'google-id-token',
  }) : authRepository = _FakeAuthRepository(),
       tokenStorage = _FakeTokenStorageRepository(storedTokens),
       appInitializer = _FakeAppInitializerService(),
       deviceIdentity = _FakeDeviceIdentityPort(),
       socialIdentity = _FakeSocialIdentityPort(googleIdToken) {
    overrides = [
      authRepositoryProvider.overrideWithValue(authRepository),
      tokenStorageRepositoryProvider.overrideWithValue(tokenStorage),
      appInitializerServiceProvider.overrideWithValue(appInitializer),
      deviceIdentityPortProvider.overrideWithValue(deviceIdentity),
      socialIdentityPortProvider.overrideWithValue(socialIdentity),
    ];
    container = ProviderContainer(overrides: overrides);
  }

  final _FakeAuthRepository authRepository;
  final _FakeTokenStorageRepository tokenStorage;
  final _FakeAppInitializerService appInitializer;
  final _FakeDeviceIdentityPort deviceIdentity;
  final _FakeSocialIdentityPort socialIdentity;
  late final List<Override> overrides;
  late final ProviderContainer container;

  void dispose() => container.dispose();
}

class _FakeDeviceIdentityPort implements DeviceIdentityPort {
  int calls = 0;

  @override
  String get deviceName => 'Test Device';

  @override
  String get deviceType => 'MOBILE';

  @override
  Future<String> getDeviceId() async {
    calls += 1;
    return 'device-test-id';
  }
}

class _FakeSocialIdentityPort implements SocialIdentityPort {
  _FakeSocialIdentityPort(this.idToken);

  final String? idToken;
  int calls = 0;

  @override
  Future<String?> getGoogleIdToken() async {
    calls += 1;
    return idToken;
  }
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
  int loginCalls = 0;
  int registerCalls = 0;
  int logoutCalls = 0;
  String? lastLogoutToken;
  Completer<Either<Failure, AuthEntity>>? loginCompleter;
  Completer<Either<Failure, bool>>? registerCompleter;

  @override
  Future<Either<Failure, AuthEntity>> login(LoginParams params) async {
    loginCalls += 1;
    lastLoginParams = params;
    if (loginCompleter != null) return loginCompleter!.future;
    return loginResult;
  }

  @override
  Future<Either<Failure, bool>> register(
    String? name,
    String email,
    String password,
  ) async {
    registerCalls += 1;
    lastRegisterEmail = email;
    lastRegisterPassword = password;
    if (registerCompleter != null) return registerCompleter!.future;
    return registerResult;
  }

  @override
  Future<Either<Failure, void>> logout(String refreshToken) async {
    logoutCalls += 1;
    lastLogoutToken = refreshToken;
    return const Right(null);
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
