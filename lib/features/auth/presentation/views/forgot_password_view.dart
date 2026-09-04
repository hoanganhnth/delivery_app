import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/components/app_fields.dart';
import 'package:delivery_app/core/design_system/components/app_navigation.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/password_recovery/password_recovery_state.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    super.key,
    required this.state,
    required this.onEmailChanged,
    required this.onSubmit,
    this.onBack,
  });

  final PasswordRecoveryState state;
  final ValueChanged<String> onEmailChanged;
  final VoidCallback onSubmit;
  final VoidCallback? onBack;

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
    final scheme = theme.colorScheme;
    final strings = S.of(context);
    final state = widget.state;

    return Scaffold(
      appBar: AppTopBar(
        title: strings.forgotPasswordTitle,
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
                    strings.forgotPasswordPrompt,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    strings.forgotPasswordInstruction,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    key: const Key('forgot_password_email'),
                    controller: _emailController,
                    label: strings.emailAddress,
                    hintText: strings.emailHint,
                    prefixIcon: const Icon(Icons.mail_outline),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    enabled: !state.isSubmitting,
                    onChanged: widget.onEmailChanged,
                    onSubmitted: (_) {
                      if (!state.isSubmitting) widget.onSubmit();
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    key: const Key('forgot_password_submit'),
                    label: strings.forgotPasswordSubmit,
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
                                strings.forgotPasswordSent,
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
}
