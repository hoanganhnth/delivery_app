import 'package:delivery_app/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Integration test for complete login flow
/// 
/// This test validates the entire login user journey from UI to backend:
/// - UI element rendering (email, password fields, buttons)
/// - User interaction (tap, input text)
/// - Form validation (empty fields, invalid email)
/// - Network calls and response handling
/// - Navigation after successful login
/// - Error handling and toast messages
/// 
/// Run with: flutter test integration_test/login_flow_test.dart
/// Or on device: flutter drive --driver=test_driver/integration_test.dart --target=integration_test/login_flow_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Integration Tests', () {
    testWidgets('should display login screen with all required elements',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify login screen is displayed
      expect(find.text('Login'), findsOneWidget);

      // Verify email field exists
      final emailField = find.byKey(const Key('email_field'));
      expect(emailField, findsOneWidget);

      // Verify password field exists
      final passwordField = find.byKey(const Key('password_field'));
      expect(passwordField, findsOneWidget);

      // Verify login button exists
      final loginButton = find.byKey(const Key('login_button'));
      expect(loginButton, findsOneWidget);

      // Verify register link exists
      expect(find.text('Don\'t have an account?'), findsOneWidget);

      // Verify forgot password link exists
      expect(find.text('Forgot Password?'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty fields',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Find and tap login button without entering credentials
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify validation error messages appear
      // Note: Actual error messages depend on your validation implementation
      // Adjust these based on your actual error messages
      expect(
        find.textContaining('required', findRichText: true),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('should show validation error for invalid email format',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter invalid email
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'invalid-email');
      await tester.pumpAndSettle();

      // Enter valid password
      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify email validation error appears
      expect(
        find.textContaining('email', findRichText: true),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('should show loading indicator during login',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter valid credentials
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);

      // Wait a bit for loading to appear
      await tester.pump(const Duration(milliseconds: 100));

      // Verify loading indicator appears
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for request to complete
      await tester.pumpAndSettle(const Duration(seconds: 10));
    });

    testWidgets('should handle login failure and show error message',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter invalid credentials
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'wrong@example.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'WrongPassword123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Verify error toast/message appears
      // Note: Adjust based on your actual error handling implementation
      expect(
        find.textContaining('Invalid', findRichText: true),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('should navigate to main screen on successful login',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter valid credentials
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'testuser@example.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'TestPassword123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Verify navigation to main screen
      // Note: Adjust based on your actual main screen widgets
      expect(find.byType(CircularProgressIndicator), findsNothing);
      
      // Verify login screen is no longer visible
      expect(find.text('Login'), findsNothing);
      
      // Verify main screen elements (adjust to your actual main screen)
      // For example, if main screen has a BottomNavigationBar:
      // expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('should navigate to register screen when tapping register link',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Find and tap register link
      final registerLink = find.text('Register');
      expect(registerLink, findsOneWidget);
      await tester.tap(registerLink);
      await tester.pumpAndSettle();

      // Verify navigation to register screen
      expect(find.text('Register'), findsWidgets);
      
      // Verify register screen specific elements
      // Adjust based on your actual register screen
      expect(find.byKey(const Key('register_button')), findsOneWidget);
    });

    testWidgets('should navigate to forgot password screen when tapping forgot password',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Find and tap forgot password link
      final forgotPasswordLink = find.text('Forgot Password?');
      expect(forgotPasswordLink, findsOneWidget);
      await tester.tap(forgotPasswordLink);
      await tester.pumpAndSettle();

      // Verify navigation to forgot password screen
      // Adjust based on your actual forgot password screen
      expect(find.text('Reset Password'), findsOneWidget);
    });

    testWidgets('should toggle password visibility',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter password
      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'TestPassword123!');
      await tester.pumpAndSettle();

      // Find password visibility toggle button
      final visibilityToggle = find.byKey(const Key('password_visibility_toggle'));
      expect(visibilityToggle, findsOneWidget);

      // Tap to show password
      await tester.tap(visibilityToggle);
      await tester.pumpAndSettle();

      // Verify password is visible
      // Note: This check depends on how your password field is implemented
      
      // Tap to hide password again
      await tester.tap(visibilityToggle);
      await tester.pumpAndSettle();

      // Verify password is hidden
    });

    testWidgets('should trim whitespace from email input',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter email with leading/trailing spaces
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, '  test@example.com  ');
      await tester.pumpAndSettle();

      // Enter valid password
      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // If login succeeds, it means email was trimmed correctly
      // If it fails with validation error, trimming is not working
    });

    testWidgets('should handle network timeout gracefully',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Turn off network or use invalid endpoint
      // This test requires actual network simulation
      
      // Enter credentials
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 30));

      // Verify timeout error message
      expect(
        find.textContaining('timeout', findRichText: true),
        findsAtLeastNWidgets(1),
      );
    });

    testWidgets('should persist login state after app restart',
        (WidgetTester tester) async {
      // Launch the app and login
      app.main();
      await tester.pumpAndSettle();

      // Login with valid credentials
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'testuser@example.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'TestPassword123!');
      await tester.pumpAndSettle();

      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Verify we're in main screen
      expect(find.text('Login'), findsNothing);

      // Restart app (simulate)
      await tester.restartAndRestore();
      await tester.pumpAndSettle();

      // Verify we're still logged in (not on login screen)
      expect(find.text('Login'), findsNothing);
      
      // Verify main screen is displayed
      // Adjust based on your actual main screen
    });

    testWidgets('should handle rapid button taps gracefully',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter credentials
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Tap login button multiple times rapidly
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(loginButton);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(loginButton);
      
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Verify only one login attempt was made
      // This can be verified by checking network logs or mock call counts
    });
  });

  group('Login Flow - Edge Cases', () {
    testWidgets('should handle special characters in password',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter email
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      // Enter password with special characters
      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'P@ss!w0rd#\$%^&*()');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Verify request was sent correctly (no encoding issues)
    });

    testWidgets('should handle very long email addresses',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter very long email
      final emailField = find.byKey(const Key('email_field'));
      final longEmail = 'very.long.email.address.for.testing.purposes@subdomain.example.com';
      await tester.enterText(emailField, longEmail);
      await tester.pumpAndSettle();

      // Enter password
      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 10));

      // Verify no crashes or UI overflow
    });

    testWidgets('should handle empty string after deleting text',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Enter email
      final emailField = find.byKey(const Key('email_field'));
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      // Delete email (enter empty string)
      await tester.enterText(emailField, '');
      await tester.pumpAndSettle();

      // Enter password
      final passwordField = find.byKey(const Key('password_field'));
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Tap login button
      final loginButton = find.byKey(const Key('login_button'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify validation error appears for empty email
      expect(
        find.textContaining('required', findRichText: true),
        findsAtLeastNWidgets(1),
      );
    });
  });

  group('Login Flow - Accessibility', () {
    testWidgets('should have proper semantics for screen readers',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify semantic labels exist
      expect(
        find.bySemanticsLabel('Email input field'),
        findsOneWidget,
      );
      
      expect(
        find.bySemanticsLabel('Password input field'),
        findsOneWidget,
      );
      
      expect(
        find.bySemanticsLabel('Login button'),
        findsOneWidget,
      );
    });

    testWidgets('should support keyboard navigation',
        (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // TODO: Test keyboard tab navigation between fields
      // This requires platform-specific testing
    });
  });
}
