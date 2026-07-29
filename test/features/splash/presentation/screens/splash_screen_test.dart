import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:delivery_app/features/splash/presentation/controllers/splash_controller.dart';

// Mock SplashController for testing
class _MockSplashController extends SplashController {
  final SplashState _mockState;

  _MockSplashController(this._mockState);

  @override
  SplashState build() => _mockState;

  @override
  Future<void> initializeApp(GoRouter router) async {}
}

Widget _testApp({List<Override> overrides = const []}) {
  final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, __) => const SizedBox()),
      GoRoute(path: '/main', builder: (_, __) => const SizedBox()),
    ],
  );

  return ProviderScope(
    overrides: overrides,
    child: ScreenUtilInit(
      designSize: const Size(390, 812),
      builder: (_, __) => MaterialApp.router(routerConfig: router),
    ),
  );
}

void _setPhoneViewport(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 812);
  addTearDown(tester.view.reset);
}

void main() {
  group('SplashScreen', () {
    testWidgets('should display app logo and name', (
      WidgetTester tester,
    ) async {
      _setPhoneViewport(tester);
      await tester.pumpWidget(
        _testApp(
          overrides: [
            splashControllerProvider.overrideWith(
              () => _MockSplashController(SplashState.initializing),
            ),
          ],
        ),
      );

      // Verify the logo is displayed
      expect(find.byIcon(Icons.local_fire_department_rounded), findsOneWidget);

      // Verify the app name is displayed
      expect(find.text('Delivery'), findsOneWidget);

      // Verify the tagline is displayed
      expect(find.text('Fast • Fresh • Delivered'), findsOneWidget);
    });

    testWidgets('should display loading indicator by default', (
      WidgetTester tester,
    ) async {
      _setPhoneViewport(tester);
      await tester.pumpWidget(
        _testApp(
          overrides: [
            splashControllerProvider.overrideWith(
              () => _MockSplashController(SplashState.initializing),
            ),
          ],
        ),
      );

      // Verify loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error state when controller has error', (
      WidgetTester tester,
    ) async {
      _setPhoneViewport(tester);
      await tester.pumpWidget(
        _testApp(
          overrides: [
            // Override with a mock that always returns error state
            splashControllerProvider.overrideWith(
              () => _MockSplashController(SplashState.error),
            ),
          ],
        ),
      );

      await tester.pump();

      // Verify error icon is displayed
      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);

      // Verify retry button is displayed
      expect(find.text('Retry'), findsOneWidget);
    });
  });

  group('SplashController', () {
    testWidgets('should have correct loading messages for each state', (
      WidgetTester tester,
    ) async {
      late SplashController controller;

      await tester.pumpWidget(
        ProviderScope(
          child: Consumer(
            builder: (context, ref, child) {
              controller = ref.read(splashControllerProvider.notifier);
              return Container();
            },
          ),
        ),
      );

      // Test initializing state
      controller.state = SplashState.initializing;
      expect(controller.loadingMessage, 'Initializing app...');

      // Test checkingAuth state
      controller.state = SplashState.checkingAuth;
      expect(controller.loadingMessage, 'Checking authentication...');

      // Test navigating state
      controller.state = SplashState.navigating;
      expect(controller.loadingMessage, 'Navigating...');

      // Test error state
      controller.state = SplashState.error;
      expect(controller.loadingMessage, 'Something went wrong...');
      expect(controller.hasError, true);
    });
  });
}
