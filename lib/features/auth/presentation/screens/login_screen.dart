import 'package:delivery_app/core/logger/app_logger.dart';
import 'package:delivery_app/core/presentation/widgets/toast/toast_extensions.dart';
import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../providers/auth_notifier.dart';
import '../providers/auth_state.dart';
import '../providers/biometric_notifier.dart';
import '../widgets/asymmetric_clipper.dart';
import '../widgets/biometric_login_button.dart';
import '../widgets/stitch_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Check biometric availability when entering login screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biometricProvider.notifier).checkBiometricAvailability();
      ref.read(biometricProvider.notifier).checkBiometricEnabled();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.hasError) {
        context.showErrorToast(next.failure!.message);
      } else if (next.isAuthenticated && !next.isLoginLoading) {
        context.showSuccessToast('Login successful!');
        // Force refresh profile after login - don't use cache
        ref
            .read(profileProvider.notifier)
            .getUserProfile(forceRefresh: true, useCache: false);
        context.goToMain();
      }
    });

    return Scaffold(
      backgroundColor: ref.colors.background,
      body: Stack(
        children: [
          // Ambient blur effects
          Positioned(
            bottom: -64,
            left: -64,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: ref.colors.primary.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            right: -80,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: const Color(0xFFFFB866).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Main content
          Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 448),
              decoration: BoxDecoration(
                color: ref.colors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Hero section with asymmetric shape
                  ClipPath(
                    clipper: AsymmetricClipper(),
                    child: Container(
                      height: 309,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            ref.colors.primary,
                            ref.colors.primary.withValues(alpha: 0.9),
                            const Color(0xFFFF9800),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ref.colors.primary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Background image overlay (optional - would need asset)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.1),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          // Content
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.restaurant,
                                  size: 64,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Amber Hearth',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: -1.5,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'THE URBAN HEARTH EXPERIENCE',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Form section
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(32, 40, 32, 48),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF1C160D),
                                letterSpacing: -0.5,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Savor the moment. Sign in to your kitchen.',
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
                              label: 'EMAIL ADDRESS',
                              hint: 'chef@amberhearth.com',
                              icon: Icons.mail_outline,
                              keyboardType: TextInputType.emailAddress,
                              enabled: !authState.isLoginLoading,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            
                            // Password field
                            StitchTextField(
                              key: const Key('password_field'),
                              controller: _passwordController,
                              label: 'PASSWORD',
                              hint: '••••••••',
                              icon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              enabled: !authState.isLoginLoading,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
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
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
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
                                  'Forgot Password?',
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
                                      onPressed: authState.isLoginLoading
                                          ? null
                                          : _handleLogin,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ref.colors.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 8,
                                        shadowColor: ref.colors.primary
                                            .withValues(alpha: 0.3),
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
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text('SIGN IN'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const BiometricLoginButton(),
                              ],
                            ),
                            const SizedBox(height: 32),
                            
                            // Register link
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Don't have an account? ",
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
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Register',
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

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);

    AppLogger.d('LoginScreen: Attempting login');

    await authNotifier.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      deviceId: '1234567890',
      deviceName: 'Test Device',
      deviceType: 'WEB',
      ipAddress: '127.0.0.1',
    );
  }
}
