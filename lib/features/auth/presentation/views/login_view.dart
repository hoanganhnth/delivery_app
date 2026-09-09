import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/login/login_intent.dart';
import '../../application/login/login_state.dart';
import '../widgets/auth_components.dart';

/// Pure login view styled with canonical design system primitives.
///
/// Handles soft keyboard clearance, accessible semantics, light/dark themes,
/// and typed user intents.
class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    required this.state,
    required this.onIntent,
    this.onBack,
  });

  final LoginViewState state;
  final ValueChanged<LoginIntent> onIntent;
  final VoidCallback? onBack;

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
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final isVietnamese = Localizations.localeOf(context).languageCode == 'vi';
    final authTitle = isVietnamese
        ? 'Chào mừng đến với ShopeeFood'
        : 'Welcome to ShopeeFood';
    final authSubtitle = isVietnamese
        ? 'Đăng nhập để khám phá món ngon mỗi ngày'
        : 'Sign in to discover delicious food every day';

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
                onPressed: widget.onBack,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back, color: Color(0xFFEE4D2D)),
              ),
        title: Text(
          shopeeFoodPreviewTitle(strings.signIn),
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
        title: authTitle,
        subtitle: authSubtitle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShopeeFoodPreviewAuthField(
              key: const Key('email_field'),
              controller: _emailController,
              hintText: 'Email',
              semanticLabel: strings.emailAddress,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enabled: !widget.state.isSubmitting,
              errorText: _emailError(strings, widget.state.emailError),
              onChanged: (value) => widget.onIntent(LoginEmailChanged(value)),
            ),
            const SizedBox(height: 12),
            ShopeeFoodPreviewAuthField(
              key: const Key('password_field'),
              controller: _passwordController,
              hintText: 'Mật khẩu',
              semanticLabel: strings.password,
              obscureText: widget.state.obscurePassword,
              enabled: !widget.state.isSubmitting,
              errorText: _passwordError(strings, widget.state.passwordError),
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                tooltip: widget.state.obscurePassword
                    ? strings.showPassword
                    : strings.hidePassword,
                onPressed: widget.state.isSubmitting
                    ? null
                    : () => widget.onIntent(
                        const LoginPasswordVisibilityToggled(),
                      ),
                icon: Icon(
                  widget.state.obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                  color: const Color(0xFF777777),
                ),
              ),
              onChanged: (value) =>
                  widget.onIntent(LoginPasswordChanged(value)),
              onSubmitted: (_) {
                if (!widget.state.isSubmitting) {
                  widget.onIntent(const LoginSubmitted());
                }
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                key: const Key('forgot_password_button'),
                onPressed: widget.state.isSubmitting
                    ? null
                    : () =>
                          widget.onIntent(const LoginForgotPasswordRequested()),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  strings.forgotPassword,
                  style: const TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ShopeeFoodPreviewAuthButton(
              key: const Key('login_button'),
              label: shopeeFoodPreviewTitle(strings.signIn),
              isLoading: widget.state.isSubmitting,
              onPressed: widget.state.isSubmitting
                  ? null
                  : () => widget.onIntent(const LoginSubmitted()),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: widget.state.isSubmitting
                  ? null
                  : () => widget.onIntent(const LoginGoogleRequested()),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEE4D2D),
                minimumSize: const Size.fromHeight(40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                strings.signInWithGoogle,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isVietnamese
                  ? 'Tài khoản chỉ được mô phỏng, không lưu thông tin đăng nhập.'
                  : 'This account is simulated; no login information is stored.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF999999), fontSize: 11),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  strings.dontHaveAccount,
                  style: const TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: widget.state.isSubmitting
                      ? null
                      : () => widget.onIntent(const LoginRegisterRequested()),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    strings.register,
                    style: const TextStyle(
                      color: Color(0xFFEE4D2D),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
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
