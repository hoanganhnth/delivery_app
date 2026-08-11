import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/register/register_intent.dart';
import '../../application/register/register_state.dart';
import '../widgets/auth_footer.dart';
import '../widgets/register_header.dart';
import '../widgets/stitch_register_field.dart';

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
      body: Column(
        children: [
          RegisterHeader(
            onBack: widget.state.isSubmitting
                ? null
                : () => widget.onIntent(const RegisterBackRequested()),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 448),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      strings.registerSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.secondary,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    StitchRegisterField(
                      controller: _nameController,
                      label: strings.fullName,
                      hint: strings.fullNameHint,
                      icon: Icons.person_outline,
                      enabled: !widget.state.isSubmitting,
                      onChanged: (value) =>
                          widget.onIntent(RegisterNameChanged(value)),
                    ),
                    const SizedBox(height: 24),
                    StitchRegisterField(
                      controller: _emailController,
                      label: strings.emailAddress,
                      hint: strings.emailHint,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      enabled: !widget.state.isSubmitting,
                      errorText: _emailError(strings, widget.state.emailError),
                      onChanged: (value) =>
                          widget.onIntent(RegisterEmailChanged(value)),
                    ),
                    const SizedBox(height: 24),
                    StitchRegisterField(
                      controller: _passwordController,
                      label: strings.password,
                      hint: strings.passwordHint,
                      icon: Icons.lock_outline,
                      obscureText: widget.state.obscurePassword,
                      enabled: !widget.state.isSubmitting,
                      helperText: strings.passwordHelper,
                      errorText: _passwordError(
                        strings,
                        widget.state.passwordError,
                      ),
                      onChanged: (value) =>
                          widget.onIntent(RegisterPasswordChanged(value)),
                      suffixIcon: IconButton(
                        tooltip: widget.state.obscurePassword
                            ? 'Show password'
                            : 'Hide password',
                        icon: Icon(
                          widget.state.obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: scheme.secondary,
                        ),
                        onPressed: widget.state.isSubmitting
                            ? null
                            : () => widget.onIntent(
                                const RegisterPasswordVisibilityToggled(),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    StitchRegisterField(
                      controller: _confirmationController,
                      label: strings.confirmPassword,
                      hint: strings.passwordHint,
                      icon: Icons.lock_outline,
                      obscureText: widget.state.obscureConfirmation,
                      enabled: !widget.state.isSubmitting,
                      errorText: _confirmationError(
                        strings,
                        widget.state.confirmationError,
                      ),
                      onChanged: (value) =>
                          widget.onIntent(RegisterConfirmationChanged(value)),
                      suffixIcon: IconButton(
                        tooltip: widget.state.obscureConfirmation
                            ? 'Show password'
                            : 'Hide password',
                        icon: Icon(
                          widget.state.obscureConfirmation
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: scheme.secondary,
                        ),
                        onPressed: widget.state.isSubmitting
                            ? null
                            : () => widget.onIntent(
                                const RegisterConfirmationVisibilityToggled(),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        key: const Key('register_button'),
                        onPressed: widget.state.isSubmitting
                            ? null
                            : () => widget.onIntent(const RegisterSubmitted()),
                        child: widget.state.isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(strings.createAccountBtn),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward, size: 20),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            strings.alreadyHaveAccount,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.secondary,
                            ),
                          ),
                          TextButton(
                            onPressed: widget.state.isSubmitting
                                ? null
                                : () => widget.onIntent(
                                    const RegisterBackRequested(),
                                  ),
                            child: Text(strings.backToLogin),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const AuthFooter(),
        ],
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
