import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/password_recovery/password_recovery_view_model.dart';
import '../views/forgot_password_view.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(passwordRecoveryViewModelProvider, (previous, next) {
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });
    final state = ref.watch(passwordRecoveryViewModelProvider);
    final viewModel = ref.read(passwordRecoveryViewModelProvider.notifier);
    return ForgotPasswordView(
      state: state,
      onEmailChanged: viewModel.setEmail,
      onSubmit: viewModel.submit,
    );
  }
}
