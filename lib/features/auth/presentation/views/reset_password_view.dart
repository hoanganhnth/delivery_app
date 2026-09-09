import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/password_recovery/password_reset_state.dart';
import '../widgets/auth_components.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({
    super.key,
    required this.state,
    required this.onNewPasswordChanged,
    required this.onConfirmPasswordChanged,
    required this.onSubmit,
    this.onBack,
  });

  final PasswordResetState state;
  final ValueChanged<String> onNewPasswordChanged;
  final ValueChanged<String> onConfirmPasswordChanged;
  final VoidCallback onSubmit;
  final VoidCallback? onBack;

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
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final state = widget.state;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        leadingWidth: 44,
        leading: widget.onBack == null
            ? null
            : IconButton(
                tooltip: 'Quay lại',
                onPressed: state.isSubmitting ? null : widget.onBack,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back, color: Color(0xFFEE4D2D)),
              ),
        title: Text(
          shopeeFoodPreviewTitle(strings.resetPasswordTitle),
          style: const TextStyle(
            color: Color(0xFF222222),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: const [SizedBox(width: 44)],
      ),
      body: ShopeeFoodPreviewAuthShell(
        title: strings.resetPasswordPrompt,
        subtitle: strings.resetPasswordTitle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShopeeFoodPreviewAuthField(
              key: const Key('reset_password_new_password'),
              controller: _newPasswordController,
              hintText: strings.resetPasswordNewPassword,
              semanticLabel: strings.resetPasswordNewPassword,
              obscureText: true,
              enabled: !state.isSubmitting,
              textInputAction: TextInputAction.next,
              onChanged: widget.onNewPasswordChanged,
            ),
            const SizedBox(height: 12),
            ShopeeFoodPreviewAuthField(
              key: const Key('reset_password_confirm_password'),
              controller: _confirmPasswordController,
              hintText: strings.resetPasswordConfirm,
              semanticLabel: strings.resetPasswordConfirm,
              obscureText: true,
              enabled: !state.isSubmitting,
              textInputAction: TextInputAction.done,
              onChanged: widget.onConfirmPasswordChanged,
              onSubmitted: (_) {
                if (!state.isSubmitting) widget.onSubmit();
              },
            ),
            if (state.errorMessage != null) ...[
              const SizedBox(height: 12),
              Container(
                key: const Key('reset_password_error'),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Color(0xFFFFF2F0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Color(0xFFB3261E),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(
                          color: Color(0xFFB3261E),
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            ShopeeFoodPreviewAuthButton(
              key: const Key('reset_password_submit'),
              label: shopeeFoodPreviewTitle(strings.resetPasswordSubmit),
              isLoading: state.isSubmitting,
              onPressed: state.isSubmitting ? null : widget.onSubmit,
            ),
            if (state.isSubmitted) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Color(0xFFFFF8F2)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFFEE4D2D),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        strings.resetPasswordSuccess,
                        style: const TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
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
