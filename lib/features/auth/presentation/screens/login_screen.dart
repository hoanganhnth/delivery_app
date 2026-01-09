import 'package:delivery_app/core/presentation/widgets/toast/toast_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/routing/navigation_helper.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/biometric_entity.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';
import '../providers/biometric_providers.dart';

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    // Listen to auth state changes
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.hasError) {
        context.showErrorToast(next.failure!.message);
      } else if (next.isAuthenticated && !next.isLoginLoading) {
        context.showSuccessToast('Login successful!');
        // Force refresh profile after login - don't use cache
        ref
            .read(profileStateProvider.notifier)
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

    final authNotifier = ref.read(authStateProvider.notifier);

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
  void initState() {
    super.initState();
    // Check biometric availability on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biometricNotifierProvider.notifier).checkBiometricAvailability();
      ref.read(biometricNotifierProvider.notifier).checkBiometricEnabled();
    });
  }

  @override
  Widget build(BuildContext context) {
    final biometricState = ref.watch(biometricNotifierProvider);
    final authState = ref.watch(authStateProvider);

    // Don't show if biometric is not available or not enabled
    if (!biometricState.isAvailable || !biometricState.isEnabled) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        const Divider(),
        SizedBox(height: 8.h),
        Text(
          'Or login with',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        SizedBox(height: 16.h),
        IconButton(
          key: const Key('biometric_login_button'),
          onPressed:
              authState.isLoginLoading || biometricState.isLoading
                  ? null
                  : _handleBiometricLogin,
          icon: Icon(
            _getBiometricIcon(biometricState.availableTypes),
            size: 48.w,
          ),
          tooltip: 'Login with biometric',
        ),
      ],
    );
  }

  IconData _getBiometricIcon(List<BiometricType> types) {
    if (types.contains(BiometricType.face)) {
      return Icons.face;
    } else if (types.contains(BiometricType.fingerprint)) {
      return Icons.fingerprint;
    }
    return Icons.security;
  }

  Future<void> _handleBiometricLogin() async {
    AppLogger.d('LoginScreen: Attempting biometric login');

    // Authenticate with biometric
    final authenticated = await ref
        .read(biometricNotifierProvider.notifier)
        .authenticateWithBiometric('Login to your account');

    if (!authenticated) {
      if (mounted) {
        context.showErrorToast('Biometric authentication failed');
      }
      return;
    }

    // Get saved auth session (tokens)
    final sessionResult = await ref
        .read(getAuthSessionUseCaseProvider)
        .call(NoParams());

    await sessionResult.fold(
      (failure) async {
        if (mounted) {
          context.showErrorToast('Failed to get saved session');
        }
      },
      (tokenModel) async {
        if (tokenModel == null) {
          if (mounted) {
            context.showErrorToast(
              'No saved session found. Please login first.',
            );
          }
          return;
        }

        // Login with saved tokens
        await ref
            .read(authStateProvider.notifier)
            .loginWithTokens(
              accessToken: tokenModel.accessToken,
              refreshToken: tokenModel.refreshToken,
            );

        if (mounted) {
          context.showSuccessToast('Logged in successfully with biometric');
        }
      },
    );
  }
}
