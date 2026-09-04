import 'package:delivery_app/features/auth/application/password_recovery/password_recovery_state.dart';
import 'package:delivery_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('renders password recovery form and submits the email', (
    tester,
  ) async {
    String? submittedEmail;
    await pumpTestApp(
      tester,
      child: ForgotPasswordView(
        state: const PasswordRecoveryState(email: 'user@example.com'),
        onEmailChanged: (value) => submittedEmail = value,
        onSubmit: () => submittedEmail = 'submitted',
      ),
    );

    expect(find.byKey(const Key('forgot_password_email')), findsOneWidget);
    await tester.tap(find.byKey(const Key('forgot_password_submit')));
    expect(submittedEmail, 'submitted');
  });
}
