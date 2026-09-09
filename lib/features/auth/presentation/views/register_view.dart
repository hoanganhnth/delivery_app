import 'package:flutter/material.dart';
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
        leading: IconButton(
          tooltip: 'Quay lại',
          onPressed: widget.state.isSubmitting
              ? null
              : () => widget.onIntent(const RegisterBackRequested()),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEE4D2D)),
        ),
        title: Text(
          shopeeFoodPreviewTitle(strings.register),
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
              key: const Key('register_name_field'),
              controller: _nameController,
              hintText: isVietnamese ? 'Họ và tên' : 'Full name',
              semanticLabel: strings.fullName,
              textInputAction: TextInputAction.next,
              enabled: !widget.state.isSubmitting,
              onChanged: (value) => widget.onIntent(RegisterNameChanged(value)),
            ),
            const SizedBox(height: 12),
            ShopeeFoodPreviewAuthField(
              key: const Key('register_email_field'),
              controller: _emailController,
              hintText: 'Email',
              semanticLabel: strings.emailAddress,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enabled: !widget.state.isSubmitting,
              errorText: _emailError(strings, widget.state.emailError),
              onChanged: (value) =>
                  widget.onIntent(RegisterEmailChanged(value)),
            ),
            const SizedBox(height: 12),
            ShopeeFoodPreviewAuthField(
              key: const Key('register_password_field'),
              controller: _passwordController,
              hintText: isVietnamese ? 'Mật khẩu' : 'Password',
              semanticLabel: strings.password,
              obscureText: widget.state.obscurePassword,
              enabled: !widget.state.isSubmitting,
              errorText: _passwordError(strings, widget.state.passwordError),
              textInputAction: TextInputAction.next,
              suffixIcon: IconButton(
                tooltip: widget.state.obscurePassword
                    ? strings.showPassword
                    : strings.hidePassword,
                onPressed: widget.state.isSubmitting
                    ? null
                    : () => widget.onIntent(
                        const RegisterPasswordVisibilityToggled(),
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
                  widget.onIntent(RegisterPasswordChanged(value)),
            ),
            const SizedBox(height: 12),
            ShopeeFoodPreviewAuthField(
              key: const Key('register_confirmation_field'),
              controller: _confirmationController,
              hintText: isVietnamese ? 'Xác nhận mật khẩu' : 'Confirm password',
              semanticLabel: strings.confirmPassword,
              obscureText: widget.state.obscureConfirmation,
              enabled: !widget.state.isSubmitting,
              errorText: _confirmationError(
                strings,
                widget.state.confirmationError,
              ),
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                tooltip: widget.state.obscureConfirmation
                    ? strings.showPassword
                    : strings.hidePassword,
                onPressed: widget.state.isSubmitting
                    ? null
                    : () => widget.onIntent(
                        const RegisterConfirmationVisibilityToggled(),
                      ),
                icon: Icon(
                  widget.state.obscureConfirmation
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                  color: const Color(0xFF777777),
                ),
              ),
              onChanged: (value) =>
                  widget.onIntent(RegisterConfirmationChanged(value)),
              onSubmitted: (_) {
                if (!widget.state.isSubmitting) {
                  widget.onIntent(const RegisterSubmitted());
                }
              },
            ),
            const SizedBox(height: 20),
            ShopeeFoodPreviewAuthButton(
              key: const Key('register_button'),
              label: shopeeFoodPreviewTitle(strings.register),
              isLoading: widget.state.isSubmitting,
              onPressed: widget.state.isSubmitting
                  ? null
                  : () => widget.onIntent(const RegisterSubmitted()),
            ),
            const SizedBox(height: 20),
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
                  strings.alreadyHaveAccount,
                  style: const TextStyle(
                    color: Color(0xFF888888),
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  onPressed: widget.state.isSubmitting
                      ? null
                      : () => widget.onIntent(const RegisterBackRequested()),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    strings.backToLogin,
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
