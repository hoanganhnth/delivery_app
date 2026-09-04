import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/components/app_fields.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/login/login_intent.dart';
import '../../application/login/login_state.dart';
import '../widgets/auth_components.dart';

/// Pure login view styled with canonical design system primitives.
///
/// Handles soft keyboard clearance, accessible semantics, light/dark themes,
/// and typed user intents.
class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.state, required this.onIntent});

  final LoginViewState state;
  final ValueChanged<LoginIntent> onIntent;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.state.email);
    _passwordController = TextEditingController(text: widget.state.password);
  }

  @override
  void didUpdateWidget(covariant LoginView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncController(_emailController, widget.state.email);
    _syncController(_passwordController, widget.state.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AuthHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.page,
                      AppSpacing.lg,
                      AppSpacing.page,
                      AppSpacing.xxl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          strings.welcomeBack,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          strings.loginSubtitle,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppTextField(
                          key: const Key('email_field'),
                          controller: _emailController,
                          label: strings.emailAddress,
                          hintText: strings.emailHint,
                          prefixIcon: const Icon(Icons.mail_outline),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          enabled: !widget.state.isSubmitting,
                          errorText: _emailError(strings, widget.state.emailError),
                          onChanged: (value) =>
                              widget.onIntent(LoginEmailChanged(value)),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AuthPasswordField(
                          key: const Key('password_field'),
                          controller: _passwordController,
                          label: strings.password,
                          hint: strings.passwordHint,
                          obscurePassword: widget.state.obscurePassword,
                          enabled: !widget.state.isSubmitting,
                          errorText:
                              _passwordError(strings, widget.state.passwordError),
                          onChanged: (value) =>
                              widget.onIntent(LoginPasswordChanged(value)),
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            if (!widget.state.isSubmitting) {
                              widget.onIntent(const LoginSubmitted());
                            }
                          },
                          onToggleVisibility: () => widget.onIntent(
                            const LoginPasswordVisibilityToggled(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            key: const Key('forgot_password_button'),
                            onPressed: widget.state.isSubmitting
                                ? null
                                : () => widget.onIntent(
                                      const LoginForgotPasswordRequested(),
                                    ),
                            child: Text(strings.forgotPassword),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppButton(
                          key: const Key('login_button'),
                          label: strings.signIn,
                          expand: true,
                          isLoading: widget.state.isSubmitting,
                          onPressed: widget.state.isSubmitting
                              ? null
                              : () => widget.onIntent(const LoginSubmitted()),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppButton(
                          variant: AppButtonVariant.secondary,
                          label: strings.signInWithGoogle,
                          icon: Icons.g_mobiledata,
                          expand: true,
                          onPressed: widget.state.isSubmitting
                              ? null
                              : () => widget.onIntent(const LoginGoogleRequested()),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              strings.dontHaveAccount,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            TextButton(
                              onPressed: widget.state.isSubmitting
                                  ? null
                                  : () => widget.onIntent(
                                        const LoginRegisterRequested(),
                                      ),
                              child: Text(
                                strings.register,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  String? _emailError(S strings, LoginFieldError? error) {
    return switch (error) {
      LoginFieldError.emailRequired => strings.enterEmail,
      LoginFieldError.emailInvalid => strings.invalidEmail,
      _ => null,
    };
  }

  String? _passwordError(S strings, LoginFieldError? error) {
    return switch (error) {
      LoginFieldError.passwordRequired => strings.enterPassword,
      LoginFieldError.passwordTooShort => strings.passwordMinLength,
      _ => null,
    };
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
