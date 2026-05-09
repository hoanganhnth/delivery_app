import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import '../../../../generated/l10n.dart';
import '../providers/providers.dart';
import 'stitch_text_field.dart';
import 'biometric_login_button.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);

    AppLogger.d('LoginForm: Attempting login');

    await authNotifier.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      deviceId: '1234567890',
      deviceName: 'Test Device',
      deviceType: 'WEB',
      ipAddress: '127.0.0.1',
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final s = S.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(32, 40, 32, 48),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text(
              s.welcomeBack,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1C160D),
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              s.loginSubtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ref.colors.secondary,
              ),
            ),
            const SizedBox(height: 40),
            
            // Email field
            StitchTextField(
              key: const Key('email_field'),
              controller: _emailController,
              label: s.emailAddress,
              hint: s.emailHint,
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              enabled: !authState.isLoginLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return s.enterEmail;
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return s.invalidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // Password field
            StitchTextField(
              key: const Key('password_field'),
              controller: _passwordController,
              label: s.password,
              hint: s.passwordHint,
              icon: Icons.lock_outline,
              obscureText: _obscurePassword,
              enabled: !authState.isLoginLoading,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: ref.colors.secondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return s.enterPassword;
                }
                if (value.length < 6) {
                  return s.passwordMinLength;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Navigate to forgot password
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  s.forgotPassword,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: ref.colors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Sign in button + Biometric
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      key: const Key('login_button'),
                      onPressed: authState.isLoginLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ref.colors.primary,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: ref.colors.primary.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      child: authState.isLoginLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text(s.signIn),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const BiometricLoginButton(),
              ],
            ),
            const SizedBox(height: 24),
            
            // Google Sign In button
            SizedBox(
              height: 56,
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: authState.isLoginLoading
                    ? null
                    : () {
                        ref.read(authProvider.notifier).loginWithGoogle();
                      },
                style: OutlinedButton.styleFrom(
                  foregroundColor: ref.colors.secondary,
                  side: BorderSide(color: ref.colors.secondary.withValues(alpha: 0.2)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Colors.white,
                ),
                icon: const Icon(Icons.g_mobiledata, size: 32, color: Colors.blue),
                label: Text(
                  s.signInWithGoogle,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Register link
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    s.dontHaveAccount,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ref.colors.secondary,
                    ),
                  ),
                  TextButton(
                    onPressed: authState.isLoginLoading
                        ? null
                        : () {
                            context.pushRegister();
                          },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      s.register,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: ref.colors.primary,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
