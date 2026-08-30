import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/login/login_intent.dart';
import '../../application/login/login_state.dart';
import '../widgets/login_header.dart';
import '../widgets/stitch_text_field.dart';

/// Pure login view. Controllers/focus are local rendering mechanics; every
/// meaningful value change and action is emitted as a typed intent.
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
      body: Stack(
        children: [
          Positioned(
            bottom: -64,
            left: -64,
            child: _AmbientCircle(
              color: scheme.primary.withValues(alpha: 0.05),
              size: 192,
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2,
            right: -80,
            child: _AmbientCircle(
              color: scheme.primaryContainer.withValues(alpha: 0.35),
              size: 256,
            ),
          ),
          Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 448),
              color: theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  const LoginHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(32, 40, 32, 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            strings.welcomeBack,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            strings.loginSubtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 40),
                          StitchTextField(
                            key: const Key('email_field'),
                            controller: _emailController,
                            label: strings.emailAddress,
                            hint: strings.emailHint,
                            icon: Icons.mail_outline,
                            keyboardType: TextInputType.emailAddress,
                            enabled: !widget.state.isSubmitting,
                            errorText: _emailError(
                              strings,
                              widget.state.emailError,
                            ),
                            onChanged:
                                (value) =>
                                    widget.onIntent(LoginEmailChanged(value)),
                          ),
                          const SizedBox(height: 24),
                          StitchTextField(
                            key: const Key('password_field'),
                            controller: _passwordController,
                            label: strings.password,
                            hint: strings.passwordHint,
                            icon: Icons.lock_outline,
                            obscureText: widget.state.obscurePassword,
                            enabled: !widget.state.isSubmitting,
                            errorText: _passwordError(
                              strings,
                              widget.state.passwordError,
                            ),
                            onChanged:
                                (value) => widget.onIntent(
                                  LoginPasswordChanged(value),
                                ),
                            suffixIcon: IconButton(
                              tooltip:
                                  widget.state.obscurePassword
                                      ? 'Show password'
                                      : 'Hide password',
                              icon: Icon(
                                widget.state.obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: scheme.secondary,
                              ),
                              onPressed:
                                  widget.state.isSubmitting
                                      ? null
                                      : () => widget.onIntent(
                                        const LoginPasswordVisibilityToggled(),
                                      ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              key: const Key('forgot_password_button'),
                              onPressed:
                                  widget.state.isSubmitting
                                      ? null
                                      : () => widget.onIntent(
                                        const LoginForgotPasswordRequested(),
                                      ),
                              child: Text(strings.forgotPassword),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              key: const Key('login_button'),
                              onPressed:
                                  widget.state.isSubmitting
                                      ? null
                                      : () => widget.onIntent(
                                        const LoginSubmitted(),
                                      ),
                              child:
                                  widget.state.isSubmitting
                                      ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : Text(strings.signIn),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            height: 56,
                            child: OutlinedButton.icon(
                              onPressed:
                                  widget.state.isSubmitting
                                      ? null
                                      : () => widget.onIntent(
                                        const LoginGoogleRequested(),
                                      ),
                              icon: const Icon(
                                Icons.g_mobiledata,
                                size: 32,
                                color: Colors.blue,
                              ),
                              label: Text(strings.signInWithGoogle),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  strings.dontHaveAccount,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: scheme.secondary,
                                  ),
                                ),
                                TextButton(
                                  onPressed:
                                      widget.state.isSubmitting
                                          ? null
                                          : () => widget.onIntent(
                                            const LoginRegisterRequested(),
                                          ),
                                  child: Text(strings.register),
                                ),
                              ],
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
        ],
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

class _AmbientCircle extends StatelessWidget {
  const _AmbientCircle({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SizedBox.square(dimension: size),
    );
  }
}
