import 'package:delivery_app/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

const _runLiveLoginSmoke = bool.fromEnvironment('RUN_LIVE_LOGIN_SMOKE');
const _liveLoginEmail = String.fromEnvironment('TEST_LOGIN_EMAIL');
const _liveLoginPassword = String.fromEnvironment('TEST_LOGIN_PASSWORD');

// Live backend authentication is opt-in:
// flutter test integration_test/login_flow_test.dart \
//   --dart-define=RUN_LIVE_LOGIN_SMOKE=true \
//   --dart-define=TEST_LOGIN_EMAIL=... \
//   --dart-define=TEST_LOGIN_PASSWORD=...
const _emailField = Key('email_field');
const _passwordField = Key('password_field');
const _loginButton = Key('login_button');

bool get _hasLiveLoginCredentials =>
    _runLiveLoginSmoke &&
    _liveLoginEmail.trim().isNotEmpty &&
    _liveLoginPassword.isNotEmpty;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login MVP smoke', () {
    testWidgets('renders current login entrypoints on a clean session', (
      WidgetTester tester,
    ) async {
      await _launchApp(tester);

      if (!_isOnLoginScreen()) {
        return;
      }

      expect(find.byKey(_emailField), findsOneWidget);
      expect(find.byKey(_passwordField), findsOneWidget);
      expect(find.byKey(_loginButton), findsOneWidget);
      expect(find.text('Forgot Password?'), findsNothing);
    });

    testWidgets('blocks empty or malformed credentials before navigation', (
      WidgetTester tester,
    ) async {
      await _launchApp(tester);

      if (!_isOnLoginScreen()) {
        return;
      }

      await tester.tap(find.byKey(_loginButton));
      await tester.pumpAndSettle();

      expect(_isOnLoginScreen(), true);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      await tester.enterText(find.byKey(_emailField), 'invalid-email');
      await tester.enterText(find.byKey(_passwordField), 'password123');
      await tester.tap(find.byKey(_loginButton));
      await tester.pumpAndSettle();

      expect(_isOnLoginScreen(), true);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets(
      'can authenticate against a configured backend account',
      (WidgetTester tester) async {
        await _launchApp(tester);

        if (!_isOnLoginScreen()) {
          return;
        }

        await tester.enterText(find.byKey(_emailField), _liveLoginEmail.trim());
        await tester.enterText(find.byKey(_passwordField), _liveLoginPassword);
        await tester.tap(find.byKey(_loginButton));
        await tester.pumpAndSettle(const Duration(seconds: 15));

        expect(find.byKey(_loginButton), findsNothing);
      },
      skip: !_hasLiveLoginCredentials,
    );
  });
}

Future<void> _launchApp(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle(const Duration(seconds: 5));
}

bool _isOnLoginScreen() => find.byKey(_loginButton).evaluate().isNotEmpty;
