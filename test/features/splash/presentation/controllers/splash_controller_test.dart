import 'package:delivery_app/core/routing/constants/app_routes.dart';
import 'package:delivery_app/core/services/app_initializer/_riverpod/app_initializer_provider.dart';
import 'package:delivery_app/core/services/app_initializer/i_app_initializer_service.dart';
import 'package:delivery_app/features/auth/presentation/providers/session/auth_notifier.dart';
import 'package:delivery_app/features/auth/presentation/providers/session/auth_state.dart';
import 'package:delivery_app/features/splash/presentation/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  test(
    'authenticated initialization waits through the port and navigates main',
    () async {
      final delay = _FakeSplashDelay();
      final initializer = _FakeAppInitializer();
      final harness = _Harness(
        authState: const AuthState.authenticated(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
        delay: delay,
        initializer: initializer,
      );
      addTearDown(harness.dispose);

      await harness.controller.initializeApp(harness.router);

      expect(delay.durations, [const Duration(seconds: 2)]);
      expect(initializer.initializeCalls, 1);
      expect(harness.controller.state, SplashState.navigating);
      expect(harness.location, AppRoutes.main);
    },
  );

  test('unauthenticated initialization navigates login', () async {
    final harness = _Harness(
      authState: const AuthState.unauthenticated(),
      delay: _FakeSplashDelay(),
      initializer: _FakeAppInitializer(),
    );
    addTearDown(harness.dispose);

    await harness.controller.initializeApp(harness.router);

    expect(harness.location, AppRoutes.login);
  });

  test(
    'initialization exception exposes error and retry can converge',
    () async {
      final initializer = _FakeAppInitializer()..failuresRemaining = 1;
      final harness = _Harness(
        authState: const AuthState.unauthenticated(),
        delay: _FakeSplashDelay(),
        initializer: initializer,
      );
      addTearDown(harness.dispose);

      await harness.controller.initializeApp(harness.router);
      expect(harness.controller.state, SplashState.error);
      expect(harness.location, AppRoutes.login);

      await harness.controller.initializeApp(harness.router);
      expect(harness.controller.state, SplashState.navigating);
      expect(initializer.initializeCalls, 2);
    },
  );
}

class _Harness {
  _Harness({
    required AuthState authState,
    required SplashDelayPort delay,
    required IAppInitializerService initializer,
  }) {
    router = GoRouter(
      initialLocation: AppRoutes.splash,
      routes: [
        GoRoute(path: AppRoutes.splash, builder: (_, _) => const SizedBox()),
        GoRoute(path: AppRoutes.login, builder: (_, _) => const SizedBox()),
        GoRoute(path: AppRoutes.main, builder: (_, _) => const SizedBox()),
      ],
    );
    container = ProviderContainer(
      overrides: [
        authProvider.overrideWithValue(authState),
        splashDelayProvider.overrideWithValue(delay),
        appInitializerServiceProvider.overrideWithValue(initializer),
      ],
    );
    subscription = container.listen(splashControllerProvider, (_, _) {});
  }

  late final GoRouter router;
  late final ProviderContainer container;
  late final ProviderSubscription<SplashState> subscription;

  SplashController get controller =>
      container.read(splashControllerProvider.notifier);
  String get location => router.routeInformationProvider.value.uri.path;

  void dispose() {
    subscription.close();
    container.dispose();
    router.dispose();
  }
}

class _FakeSplashDelay implements SplashDelayPort {
  final List<Duration> durations = [];

  @override
  Future<void> wait(Duration duration) async {
    durations.add(duration);
  }
}

class _FakeAppInitializer implements IAppInitializerService {
  int initializeCalls = 0;
  int failuresRemaining = 0;

  @override
  Future<bool> initialize() async {
    initializeCalls += 1;
    if (failuresRemaining > 0) {
      failuresRemaining -= 1;
      throw StateError('initializer failed');
    }
    return true;
  }

  @override
  Future<void> cleanup() async {}
}
