import 'package:flutter/material.dart';

import '../../application/password_recovery/password_reset_state.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({
    super.key,
    required this.state,
    required this.onNewPasswordChanged,
    required this.onConfirmPasswordChanged,
    required this.onSubmit,
  });

  final PasswordResetState state;
  final ValueChanged<String> onNewPasswordChanged;
  final ValueChanged<String> onConfirmPasswordChanged;
  final VoidCallback onSubmit;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController(
      text: widget.state.newPassword,
    );
    _confirmPasswordController = TextEditingController(
      text: widget.state.confirmPassword,
    );
  }

  @override
  void didUpdateWidget(covariant ResetPasswordView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncController(_newPasswordController, widget.state.newPassword);
    _syncController(_confirmPasswordController, widget.state.confirmPassword);
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    return Scaffold(
      appBar: AppBar(title: const Text('Đặt lại mật khẩu')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.lock_reset, size: 72),
                const SizedBox(height: 20),
                const Text(
                  'Tạo mật khẩu mới',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 28),
                TextField(
                  key: const Key('reset_password_new_password'),
                  controller: _newPasswordController,
                  obscureText: true,
                  enabled: !state.isSubmitting,
                  onChanged: widget.onNewPasswordChanged,
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu mới',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('reset_password_confirm_password'),
                  controller: _confirmPasswordController,
                  obscureText: true,
                  enabled: !state.isSubmitting,
                  onChanged: widget.onConfirmPasswordChanged,
                  decoration: const InputDecoration(
                    labelText: 'Xác nhận mật khẩu',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    state.errorMessage!,
                    key: const Key('reset_password_error'),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  key: const Key('reset_password_submit'),
                  onPressed: state.isSubmitting ? null : widget.onSubmit,
                  child:
                      state.isSubmitting
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text('Lưu mật khẩu mới'),
                ),
                if (state.isSubmitted)
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Mật khẩu đã được cập nhật. Bạn có thể đăng nhập lại.',
                      key: Key('reset_password_success'),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _syncController(TextEditingController controller, String value) {
    if (controller.text == value) return;
    controller.value = controller.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
      composing: TextRange.empty,
    );
  }
}
