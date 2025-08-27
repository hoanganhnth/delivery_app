import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../auth_example.dart';
import '../providers/auth_providers.dart';

class AuthDemoWidget extends ConsumerWidget {
  const AuthDemoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Demo with Riverpod'),
        actions: [
          if (authState.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => authNotifier.logout(),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Auth State Display
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Auth State',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('Authenticated: ${authState.isAuthenticated}'),
                    Text('Loading: ${authState.isLoading}'),
                    Text('Has Error: ${authState.hasError}'),
                    if (authState.hasError)
                      Text(
                        'Error: ${authState.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    if (authState.hasUser) ...[
                      const SizedBox(height: 8),
                      Text('User Email: ${authState.user!.email}'),
                      Text('User ID: ${authState.user!.id}'),
                      Text('User Name: ${authState.user!.name ?? 'N/A'}'),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Demo Buttons
            ElevatedButton(
              onPressed: authState.isLoading ? null : () => _runDemo(ref),
              child: authState.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Run Auth Demo'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: authState.isLoading ? null : () => _testLogin(ref),
              child: const Text('Test Login'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: authState.isLoading ? null : () => _testRegister(ref),
              child: const Text('Test Register'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: authState.isLoading || !authState.isAuthenticated 
                  ? null 
                  : () => _testRefreshToken(ref),
              child: const Text('Test Refresh Token'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: authState.isLoading ? null : () => authNotifier.clearError(),
              child: const Text('Clear Error'),
            ),
            
            const SizedBox(height: 16),
            
            // Navigation Buttons
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed('/login'),
              icon: const Icon(Icons.login),
              label: const Text('Go to Login Screen'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed('/register'),
              icon: const Icon(Icons.person_add),
              label: const Text('Go to Register Screen'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _runDemo(WidgetRef ref) async {
    try {
      AppLogger.i('Running full auth demo...');
      // Create a temporary container for demo
      final container = ProviderContainer();
      await AuthExample.demonstrateAuthFlow(container);
      container.dispose();
    } catch (e) {
      AppLogger.e('Demo failed: $e');
    }
  }

  Future<void> _testLogin(WidgetRef ref) async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    AppLogger.i('Testing login...');
    await authNotifier.login(
      email: 'test@example.com',
      password: 'password123',
    );
  }

  Future<void> _testRegister(WidgetRef ref) async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    AppLogger.i('Testing register...');
    await authNotifier.register(
      email: 'newuser@example.com',
      password: 'password123',
      confirmPassword: 'password123',
      name: 'Test User',
    );
  }

  Future<void> _testRefreshToken(WidgetRef ref) async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    AppLogger.i('Testing refresh token...');
    final newToken = await authNotifier.refreshToken();
    
    if (newToken != null) {
      AppLogger.i('Token refreshed successfully');
    } else {
      AppLogger.w('Token refresh failed');
    }
  }
}
