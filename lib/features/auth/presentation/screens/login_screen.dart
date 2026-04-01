import 'package:delivery_app/core/logger/app_logger.dart';
import 'package:delivery_app/core/presentation/widgets/toast/toast_extensions.dart';
import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/biometric_entity.dart';
import '../providers/auth_notifier.dart';
import '../providers/auth_state.dart';
import '../providers/biometric_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email field
              TextFormField(
                key: const Key('email_field'),
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                enabled: !authState.isLoginLoading,
              ),

              SizedBox(height: 16.w),

              // Password field
              TextFormField(
                key: const Key('password_field'),
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                enabled: !authState.isLoginLoading,
              ),

              SizedBox(height: 24.w),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 48.w,
                child: ElevatedButton(
                  key: const Key('login_button'),
                  onPressed: authState.isLoginLoading ? null : _handleLogin,
                  child:
                      authState.isLoginLoading
                          ? SizedBox(
                            height: 20.w,
                            width: 20.w,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Text('Login'),
                ),
              ),

              SizedBox(height: 16.w),

              // Register link
              TextButton(
                onPressed:
                    authState.isLoginLoading
                        ? null
                        : () {
                          context.pushRegister();
                        },
                child: const Text('Don\'t have an account? Register'),
              ),

              SizedBox(height: 16.w),

              // Biometric login button
              _BiometricLoginButton(),
            ],
          ),
        ),
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

/// Widget for biometric login button
class _BiometricLoginButton extends ConsumerStatefulWidget {
  const _BiometricLoginButton();

  @override
  ConsumerState<_BiometricLoginButton> createState() =>
      _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends ConsumerState<_BiometricLoginButton> {
  @override
  Widget build(BuildContext context) {
    final biometricState = ref.watch(biometricProvider);

    if (!biometricState.isAvailable || !biometricState.isEnabled) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(
        biometricState.availableTypes.contains(BiometricType.face) 
            ? Icons.face
            : Icons.fingerprint,
        size: 32,
      ),
      onPressed: () async {
        final biometricNotifier = ref.read(biometricProvider.notifier);
        
        // Show reasoning dialog to user
        final authenticated = await biometricNotifier.authenticateWithBiometric(
          'Đăng nhập bằng sinh trắc học',
        );

        if (authenticated) {
          // TODO: Implement biometric login with stored credentials
          // final authNotifier = ref.read(authProvider.notifier);
          // Get stored credentials and login
          // await authNotifier.login(...);
        }
      },
    );
  }
}
