import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import '../../../../generated/l10n.dart';
import '../providers/providers.dart';
import 'stitch_register_field.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);
    
    AppLogger.d('RegisterForm: Attempting registration');
    
    await authNotifier.register(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final s = S.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 448),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              s.registerSubtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ref.colors.secondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Full Name field
                  StitchRegisterField(
                    controller: _nameController,
                    label: s.fullName,
                    hint: s.fullNameHint,
                    icon: Icons.person_outline,
                    enabled: !authState.isRegisterLoading,
                  ),
                  const SizedBox(height: 24),
                  
                  // Email field
                  StitchRegisterField(
                    controller: _emailController,
                    label: s.emailAddress,
                    hint: s.emailHint,
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !authState.isRegisterLoading,
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
                  StitchRegisterField(
                    controller: _passwordController,
                    label: s.password,
                    hint: s.passwordHint,
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    enabled: !authState.isRegisterLoading,
                    helperText: s.passwordHelper,
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
                  const SizedBox(height: 24),
                  
                  // Confirm Password field
                  StitchRegisterField(
                    controller: _confirmPasswordController,
                    label: s.confirmPassword,
                    hint: s.passwordHint,
                    icon: Icons.lock_outline,
                    obscureText: _obscureConfirmPassword,
                    enabled: !authState.isRegisterLoading,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: ref.colors.secondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return s.confirmYourPassword;
                      }
                      if (value != _passwordController.text) {
                        return s.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  
                  // Create Account button
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: authState.isRegisterLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ref.colors.primary,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: ref.colors.primary.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: authState.isRegisterLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  s.createAccountBtn,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Back to Login
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          s.alreadyHaveAccount,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ref.colors.secondary,
                          ),
                        ),
                        TextButton(
                          onPressed: authState.isRegisterLoading
                              ? null
                              : () {
                                  context.goBack();
                                },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            s.backToLogin,
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
          ],
        ),
      ),
    );
  }
}
