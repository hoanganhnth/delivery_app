import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/components/app_fields.dart';
import 'package:delivery_app/core/design_system/components/app_navigation.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/password_recovery/password_reset_state.dart';

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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);
    final state = widget.state;

    return Scaffold(
      appBar: AppTopBar(
        title: strings.resetPasswordTitle,
        onBack: state.isSubmitting ? null : widget.onBack,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.page,
              vertical: AppSpacing.lg,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_reset,
                        size: 56,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    strings.resetPasswordPrompt,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    key: const Key('reset_password_new_password'),
                    controller: _newPasswordController,
                    obscureText: true,
                    label: strings.resetPasswordNewPassword,
                    hintText: strings.passwordHint,
                    prefixIcon: const Icon(Icons.lock_outline),
                    enabled: !state.isSubmitting,
                    textInputAction: TextInputAction.next,
                    onChanged: widget.onNewPasswordChanged,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    key: const Key('reset_password_confirm_password'),
                    controller: _confirmPasswordController,
                    obscureText: true,
                    label: strings.resetPasswordConfirm,
                    hintText: strings.authConfirmPasswordHint,
                    prefixIcon: const Icon(Icons.lock_outline),
                    enabled: !state.isSubmitting,
                    textInputAction: TextInputAction.done,
                    onChanged: widget.onConfirmPasswordChanged,
                    onSubmitted: (_) {
                      if (!state.isSubmitting) widget.onSubmit();
                    },
                  ),
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: scheme.errorContainer.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: scheme.error, size: 20),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              state.errorMessage!,
                              key: const Key('reset_password_error'),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    key: const Key('reset_password_submit'),
                    label: strings.resetPasswordSubmit,
                    expand: true,
                    isLoading: state.isSubmitting,
                    onPressed: state.isSubmitting ? null : widget.onSubmit,
                  ),
                  if (state.isSubmitted)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.lg),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: scheme.primary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: scheme.primary),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                strings.resetPasswordSuccess,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
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
