import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/routing/navigation_helper.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';

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
        _showErrorSnackBar(context, next.failure!);
      } else if (next.isAuthenticated) {
        _showSuccessSnackBar(context, 'Login successful!');
        // Navigate to main screen
        // Navigator.of(context).pushReplacementNamed('/main');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email field
              TextFormField(
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
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                enabled: !authState.isLoginLoading,
              ),
              
              const SizedBox(height: 16),
              
              // Password field
              TextFormField(
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
              
              const SizedBox(height: 24),
              
              // Login button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: authState.isLoginLoading ? null : _handleLogin,
                  child: authState.isLoginLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Login'),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Register link
              TextButton(
                onPressed: authState.isLoginLoading ? null : () {
                  context.goToRegister();
                },
                child: const Text('Don\'t have an account? Register'),
              ),
              
              // Debug info (remove in production)
              if (authState.hasUser) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Debug Info:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Email: ${authState.user!.email}'),
                      Text('ID: ${authState.user!.id}'),
                      Text('Name: ${authState.user!.name ?? 'N/A'}'),
                      Text('Token: ${authState.user!.accessToken.substring(0, 20)}...'),
                    ],
                  ),
                ),
              ],
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
    );
  }

  void _showErrorSnackBar(BuildContext context, Failure failure) {
    String message;
    Color backgroundColor;
    
    if (failure is ValidationFailure) {
      message = failure.message;
      backgroundColor = Colors.orange;
    } else if (failure is UnauthorizedFailure) {
      message = 'Invalid email or password';
      backgroundColor = Colors.red;
    } else if (failure is ServerFailure) {
      message = 'Server error. Please try again later.';
      backgroundColor = Colors.red;
    } else {
      message = 'An unexpected error occurred';
      backgroundColor = Colors.red;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ref.read(authStateProvider.notifier).clearError();
          },
        ),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
