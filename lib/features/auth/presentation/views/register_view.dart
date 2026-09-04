import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/components/app_fields.dart';
import 'package:delivery_app/core/design_system/components/app_navigation.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/register/register_intent.dart';
import '../../application/register/register_state.dart';
import '../widgets/auth_components.dart';

/// Pure register view styled with canonical design system primitives.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.state, required this.onIntent});

  final RegisterViewState state;
  final ValueChanged<RegisterIntent> onIntent;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.state.name);
    _emailController = TextEditingController(text: widget.state.email);
    _passwordController = TextEditingController(text: widget.state.password);
    _confirmationController = TextEditingController(
      text: widget.state.confirmation,
    );
  }

  @override
  void didUpdateWidget(covariant RegisterView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync(_nameController, widget.state.name);
    _sync(_emailController, widget.state.email);
    _sync(_passwordController, widget.state.password);
    _sync(_confirmationController, widget.state.confirmation);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppTopBar(
        title: strings.register,
        onBack: widget.state.isSubmitting
            ? null
            : () => widget.onIntent(const RegisterBackRequested()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.page,
            vertical: AppSpacing.lg,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    strings.registerSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    key: const Key('register_name_field'),
                    controller: _nameController,
                    label: strings.fullName,
                    hintText: strings.fullNameHint,
                    prefixIcon: const Icon(Icons.person_outline),
                    textInputAction: TextInputAction.next,
                    enabled: !widget.state.isSubmitting,
                    onChanged: (value) =>
                        widget.onIntent(RegisterNameChanged(value)),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    key: const Key('register_email_field'),
                    controller: _emailController,
                    label: strings.emailAddress,
                    hintText: strings.emailHint,
                    prefixIcon: const Icon(Icons.mail_outline),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    enabled: !widget.state.isSubmitting,
                    errorText: _emailError(strings, widget.state.emailError),
                    onChanged: (value) =>
                        widget.onIntent(RegisterEmailChanged(value)),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthPasswordField(
                    key: const Key('register_password_field'),
                    controller: _passwordController,
                    label: strings.password,
                    hint: strings.passwordHint,
                    obscurePassword: widget.state.obscurePassword,
                    enabled: !widget.state.isSubmitting,
                    errorText:
                        _passwordError(strings, widget.state.passwordError),
                    onChanged: (value) =>
                        widget.onIntent(RegisterPasswordChanged(value)),
                    textInputAction: TextInputAction.next,
                    onToggleVisibility: () => widget.onIntent(
                      const RegisterPasswordVisibilityToggled(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AuthPasswordField(
                    key: const Key('register_confirmation_field'),
                    controller: _confirmationController,
                    label: strings.confirmPassword,
                    hint: strings.passwordHint,
                    obscurePassword: widget.state.obscureConfirmation,
                    enabled: !widget.state.isSubmitting,
                    errorText: _confirmationError(
                      strings,
                      widget.state.confirmationError,
                    ),
                    onChanged: (value) =>
                        widget.onIntent(RegisterConfirmationChanged(value)),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) {
                      if (!widget.state.isSubmitting) {
                        widget.onIntent(const RegisterSubmitted());
                      }
                    },
                    onToggleVisibility: () => widget.onIntent(
                      const RegisterConfirmationVisibilityToggled(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    key: const Key('register_button'),
                    label: strings.createAccountBtn,
                    icon: Icons.arrow_forward,
                    expand: true,
                    isLoading: widget.state.isSubmitting,
                    onPressed: widget.state.isSubmitting
                        ? null
                        : () => widget.onIntent(const RegisterSubmitted()),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        strings.alreadyHaveAccount,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: widget.state.isSubmitting
                            ? null
                            : () => widget.onIntent(
                                  const RegisterBackRequested(),
                                ),
                        child: Text(
                          strings.backToLogin,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _emailError(S strings, RegisterFieldError? error) {
    return switch (error) {
      RegisterFieldError.emailRequired => strings.enterEmail,
      RegisterFieldError.emailInvalid => strings.invalidEmail,
      _ => null,
    };
  }

  String? _passwordError(S strings, RegisterFieldError? error) {
    return switch (error) {
      RegisterFieldError.passwordRequired => strings.enterPassword,
      RegisterFieldError.passwordTooShort => strings.passwordMinLength,
      _ => null,
    };
  }

  String? _confirmationError(S strings, RegisterFieldError? error) {
    return switch (error) {
      RegisterFieldError.confirmationRequired => strings.confirmYourPassword,
      RegisterFieldError.passwordsDoNotMatch => strings.passwordsDoNotMatch,
      _ => null,
    };
  }

  void _sync(TextEditingController controller, String value) {
    if (controller.text == value) return;
    controller.value = controller.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
      composing: TextRange.empty,
    );
  }
}
