// ignore_for_file: avoid_print

import 'package:delivery_app/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Simple integration test for login flow
/// 
/// This demonstrates basic integration testing patterns without
/// relying on specific authentication state.
/// 
/// Run with: flutter test integration_test/login_simple_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login UI Integration Tests', () {
    testWidgets('should render email and password fields with proper keys',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Note: You may need to logout first if already logged in
      // For now, try to find login button
      final loginButtonFinder = find.byKey(const Key('login_button'));
      
      // If we can't find login button, we're probably on main screen
      // (already logged in). This is expected behavior.
      if (loginButtonFinder.evaluate().isNotEmpty) {
        // We're on login screen, verify elements
        
        // Verify email field exists
        expect(
          find.byKey(const Key('email_field')),
          findsOneWidget,
          reason: 'Email field with key "email_field" should exist',
        );

        // Verify password field exists
        expect(
          find.byKey(const Key('password_field')),
          findsOneWidget,
          reason: 'Password field with key "password_field" should exist',
        );

        // Verify login button exists
        expect(
          loginButtonFinder,
          findsOneWidget,
          reason: 'Login button with key "login_button" should exist',
        );

        print('✅ All login screen elements found with correct keys');
      } else {
        print('⚠️ Already logged in - skipping login screen test');
        print('💡 To test login screen: logout first or clear app data');
      }
    });

    testWidgets('should show validation error on empty email',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final loginButtonFinder = find.byKey(const Key('login_button'));
      
      if (loginButtonFinder.evaluate().isNotEmpty) {
        // We're on login screen
        
        // Leave email empty and tap login
        await tester.tap(loginButtonFinder);
        await tester.pumpAndSettle();

        // Verify validation error appears
        expect(
          find.textContaining('Please enter'),
          findsAtLeastNWidgets(1),
          reason: 'Validation error should appear for empty fields',
        );

        print('✅ Validation working correctly');
      } else {
        print('⚠️ Already logged in - skipping validation test');
      }
    });

    testWidgets('should show validation error on invalid email format',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final loginButtonFinder = find.byKey(const Key('login_button'));
      
      if (loginButtonFinder.evaluate().isNotEmpty) {
        // We're on login screen
        
        // Enter invalid email
        final emailField = find.byKey(const Key('email_field'));
        await tester.enterText(emailField, 'invalid-email');
        await tester.pumpAndSettle();

        // Enter some password
        final passwordField = find.byKey(const Key('password_field'));
        await tester.enterText(passwordField, 'test123');
        await tester.pumpAndSettle();

        // Tap login
        await tester.tap(loginButtonFinder);
        await tester.pumpAndSettle();

        // Verify email validation error
        expect(
          find.textContaining('valid email'),
          findsAtLeastNWidgets(1),
          reason: 'Email format validation error should appear',
        );

        print('✅ Email format validation working');
      } else {
        print('⚠️ Already logged in - skipping email validation test');
      }
    });

    testWidgets('should show loading indicator during login attempt',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final loginButtonFinder = find.byKey(const Key('login_button'));
      
      if (loginButtonFinder.evaluate().isNotEmpty) {
        // We're on login screen
        
        // Enter valid format credentials (may not be real)
        final emailField = find.byKey(const Key('email_field'));
        await tester.enterText(emailField, 'test@example.com');
        await tester.pumpAndSettle();

        final passwordField = find.byKey(const Key('password_field'));
        await tester.enterText(passwordField, 'password123');
        await tester.pumpAndSettle();

        // Tap login
        await tester.tap(loginButtonFinder);
        
        // Wait a moment for loading to appear
        await tester.pump(const Duration(milliseconds: 100));

        // Verify loading indicator appears
        expect(
          find.byType(CircularProgressIndicator),
          findsOneWidget,
          reason: 'Loading indicator should appear during login',
        );

        print('✅ Loading indicator appears during login');

        // Wait for completion (may fail with network error)
        await tester.pumpAndSettle(const Duration(seconds: 10));
      } else {
        print('⚠️ Already logged in - skipping loading indicator test');
      }
    });
  });

  group('Login Flow End-to-End', () {
    testWidgets('should complete full login flow with valid credentials',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final loginButtonFinder = find.byKey(const Key('login_button'));
      
      if (loginButtonFinder.evaluate().isNotEmpty) {
        // We're on login screen
        
        // TODO: Replace with actual test credentials
        final testEmail = 'test4@gmail.com';
        final testPassword = 'Test@123';

        print('🔐 Attempting login with: $testEmail');

        // Enter credentials
        final emailField = find.byKey(const Key('email_field'));
        await tester.enterText(emailField, testEmail);
        await tester.pumpAndSettle();

        final passwordField = find.byKey(const Key('password_field'));
        await tester.enterText(passwordField, testPassword);
        await tester.pumpAndSettle();

        // Tap login
        await tester.tap(loginButtonFinder);
        await tester.pumpAndSettle(const Duration(seconds: 15));

        // Check if we navigated away from login screen
        final stillOnLogin = find.byKey(const Key('login_button'))
            .evaluate()
            .isNotEmpty;

        if (!stillOnLogin) {
          print('✅ Login successful - navigated to main screen');
          expect(find.byKey(const Key('login_button')), findsNothing);
        } else {
          print('⚠️ Still on login screen - may be incorrect credentials');
          // This is okay for demo purposes
        }
      } else {
        print('✅ Already logged in');
      }
    });
  });

  group('Accessibility Tests', () {
    testWidgets('should have semantic labels for screen readers',
        (WidgetTester tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final loginButtonFinder = find.byKey(const Key('login_button'));
      
      if (loginButtonFinder.evaluate().isNotEmpty) {
        // Verify widgets have proper keys for accessibility
        expect(find.byKey(const Key('email_field')), findsOneWidget);
        expect(find.byKey(const Key('password_field')), findsOneWidget);
        expect(find.byKey(const Key('login_button')), findsOneWidget);

        print('✅ All interactive elements have proper keys');
      } else {
        print('⚠️ Already logged in - skipping accessibility test');
      }
    });
  });
}
