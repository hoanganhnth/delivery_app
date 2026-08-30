import 'package:delivery_app/features/auth/application/password_recovery/password_reset_state.dart';
import 'package:delivery_app/features/auth/presentation/views/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('submits the new password form through callbacks', (
    tester,
  ) async {
    var submitted = false;
    await pumpTestApp(
      tester,
      child: ResetPasswordView(
        state: PasswordResetState(token: List.filled(32, 't').join()),
        onNewPasswordChanged: (_) {},
        onConfirmPasswordChanged: (_) {},
        onSubmit: () => submitted = true,
      ),
    );

    expect(
      find.byKey(const Key('reset_password_new_password')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('reset_password_confirm_password')),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const Key('reset_password_submit')));

    expect(submitted, isTrue);
  });

  testWidgets('shows a reset error without hiding the form', (tester) async {
    await pumpTestApp(
      tester,
      child: ResetPasswordView(
        state: PasswordResetState(
          token: List.filled(32, 't').join(),
          errorMessage: 'Invalid reset token',
        ),
        onNewPasswordChanged: _ignore,
        onConfirmPasswordChanged: _ignore,
        onSubmit: _ignoreSubmit,
      ),
    );

    expect(find.byKey(const Key('reset_password_error')), findsOneWidget);
    expect(find.text('Invalid reset token'), findsOneWidget);
    expect(find.byKey(const Key('reset_password_submit')), findsOneWidget);
  });
}

void _ignore(String value) {}

void _ignoreSubmit() {}
