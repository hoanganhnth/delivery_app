import 'package:flutter/material.dart';

import '../../application/password_recovery/password_recovery_state.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    super.key,
    required this.state,
    required this.onEmailChanged,
    required this.onSubmit,
  });

  final PasswordRecoveryState state;
  final ValueChanged<String> onEmailChanged;
  final VoidCallback onSubmit;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.state.email);
  }

  @override
  void didUpdateWidget(covariant ForgotPasswordView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_emailController.text != widget.state.email) {
      _emailController.value = _emailController.value.copyWith(
        text: widget.state.email,
        selection: TextSelection.collapsed(offset: widget.state.email.length),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = widget.state;
    return Scaffold(
      appBar: AppBar(title: const Text('Khôi phục mật khẩu')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.lock_reset, size: 72, color: theme.colorScheme.primary),
                const SizedBox(height: 20),
                Text(
                  'Nhập email tài khoản',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Nếu email tồn tại, hệ thống sẽ gửi hướng dẫn đặt lại mật khẩu.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                TextField(
                  key: const Key('forgot_password_email'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !state.isSubmitting,
                  onChanged: widget.onEmailChanged,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  key: const Key('forgot_password_submit'),
                  onPressed: state.isSubmitting ? null : widget.onSubmit,
                  child: state.isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Gửi hướng dẫn'),
                ),
                if (state.isSubmitted)
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Đã tiếp nhận yêu cầu. Hãy kiểm tra email của bạn.',
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
}
