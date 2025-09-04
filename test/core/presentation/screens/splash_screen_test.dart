import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:delivery_app/core/presentation/screens/splash_screen.dart';
import 'package:delivery_app/core/presentation/controllers/splash_controller.dart';

void main() {
  group('SplashScreen', () {
    testWidgets('should display app logo and name', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SplashScreen(),
          ),
        ),
      );

      // Verify the logo is displayed
      expect(find.byIcon(Icons.delivery_dining), findsOneWidget);
      
      // Verify the app name is displayed
      expect(find.text('Delivery App'), findsOneWidget);
      
      // Verify the tagline is displayed
      expect(find.text('Fast • Fresh • Delivered'), findsOneWidget);
    });

    testWidgets('should display loading indicator by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SplashScreen(),
          ),
        ),
      );

      // Verify loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error state when controller has error', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            splashControllerProvider.overrideWith((ref) {
              final controller = SplashController(ref);
              // Mock error state
              controller.state = SplashState.error;
              return controller;
            }),
          ],
          child: MaterialApp(
            home: SplashScreen(),
          ),
        ),
      );

      await tester.pump();

      // Verify error icon is displayed
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      
      // Verify retry button is displayed
      expect(find.text('Retry'), findsOneWidget);
    });
  });

  group('SplashController', () {
    testWidgets('should have correct loading messages for each state', (WidgetTester tester) async {
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
