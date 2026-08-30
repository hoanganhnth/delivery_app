import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/password_recovery/password_reset_view_model.dart';
import '../views/reset_password_view.dart';

class ResetPasswordPage extends ConsumerWidget {
  const ResetPasswordPage({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = passwordResetViewModelProvider(token);
    final state = ref.watch(provider);
    final viewModel = ref.read(provider.notifier);
    return ResetPasswordView(
      state: state,
      onNewPasswordChanged: viewModel.setNewPassword,
      onConfirmPasswordChanged: viewModel.setConfirmPassword,
      onSubmit: viewModel.submit,
    );
  }
}
