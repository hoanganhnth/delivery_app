import 'package:delivery_app/features/auth/application/login/login_state.dart';
import 'package:delivery_app/features/auth/application/login/login_intent.dart';
import 'package:delivery_app/features/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('shows a password recovery entry point', (tester) async {
    await pumpTestApp(
      tester,
      child: LoginView(state: const LoginViewState(), onIntent: (_) {}),
    );

    expect(find.byKey(const Key('forgot_password_button')), findsOneWidget);
  });

  testWidgets('emits a typed password recovery intent when tapped', (
    tester,
  ) async {
    final intents = <LoginIntent>[];
    await pumpTestApp(
      tester,
      child: LoginView(state: const LoginViewState(), onIntent: intents.add),
    );

    await tester.tap(find.byKey(const Key('forgot_password_button')));

    expect(intents, hasLength(1));
    expect(
      intents.single.runtimeType.toString(),
      'LoginForgotPasswordRequested',
    );
  });
}
