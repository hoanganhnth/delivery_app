import 'package:delivery_app/core/services/app_initializer/_riverpod/app_initializer_provider.dart';
import 'package:delivery_app/core/services/app_initializer/i_app_initializer_service.dart';
import 'package:delivery_app/features/auth/application/session/auth_notifier.dart';
import 'package:delivery_app/features/auth/application/session/auth_state.dart';
import 'package:delivery_app/features/splash/application/splash_delay.dart';
import 'package:delivery_app/features/splash/application/splash_effect.dart';
import 'package:delivery_app/features/splash/application/splash_intent.dart';
import 'package:delivery_app/features/splash/application/splash_state.dart';
import 'package:delivery_app/features/splash/application/splash_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'authenticated startup waits through the port then emits main navigation',
    () async {
      final delay = _FakeSplashDelay();
      final initializer = _FakeAppInitializer();
      final container = _container(
        authState: const AuthState.authenticated(
          accessToken: 'access',
          refreshToken: 'refresh',
        ),
        delay: delay,
        initializer: initializer,
      );
      addTearDown(container.dispose);
      container.listen(splashViewModelProvider, (_, _) {});

      await container
          .read(splashViewModelProvider.notifier)
          .dispatch(const SplashStartRequested());

      expect(delay.durations, [const Duration(seconds: 2)]);
      expect(initializer.initializeCalls, 1);
      expect(
        container.read(splashViewModelProvider).phase,
        SplashPhase.navigating,
      );
      expect(
        container.read(splashViewModelProvider).effects.single.effect,
        isA<SplashNavigateToMain>(),
      );
    },
  );

  test(
    'failed startup retains an observable error and emits login navigation',
    () async {
      final container = _container(
        authState: const AuthState.unauthenticated(),
        delay: _FakeSplashDelay(),
        initializer: _FakeAppInitializer()..failuresRemaining = 1,
      );
      addTearDown(container.dispose);
      container.listen(splashViewModelProvider, (_, _) {});

      await container
          .read(splashViewModelProvider.notifier)
          .dispatch(const SplashStartRequested());

      expect(container.read(splashViewModelProvider).phase, SplashPhase.error);
      expect(
        container.read(splashViewModelProvider).effects.single.effect,
        isA<SplashNavigateToLogin>(),
      );
    },
  );
}

ProviderContainer _container({
  required AuthState authState,
  required SplashDelayPort delay,
  required IAppInitializerService initializer,
}) => ProviderContainer(
  overrides: [
    authProvider.overrideWithValue(authState),
    splashDelayProvider.overrideWithValue(delay),
    appInitializerServiceProvider.overrideWithValue(initializer),
  ],
);

class _FakeSplashDelay implements SplashDelayPort {
  final List<Duration> durations = [];

  @override
  Future<void> wait(Duration duration) async => durations.add(duration);
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
