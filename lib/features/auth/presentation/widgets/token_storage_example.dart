import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';

/// Example widget showing how to use token storage
class TokenStorageExample extends ConsumerWidget {
  const TokenStorageExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Storage Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Authentication Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Authenticated: ${authState.isAuthenticated}'),
                    if (authState.accessToken != null)
                      Text(
                        'Access Token: ${authState.accessToken!.substring(0, 20)}...',
                      ),
                    if (authState.refreshToken != null)
                      Text(
                        'Refresh Token: ${authState.refreshToken!.substring(0, 20)}...',
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: authState.isLoginLoading
                  ? null
                  : () async {
                      // Example login
                      await authNotifier.login(
                        email: 'test@example.com',
                        password: 'password123',
                      );
                    },
              child: authState.isLoginLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Login (Demo)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                // Check stored tokens
                await authNotifier.checkAuthStatus();
              },
              child: const Text('Check Stored Tokens'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: authState.isAuthenticated
                  ? () async {
                      // Logout and clear tokens
                      await authNotifier.logout();
                    }
                  : null,
              child: const Text('Logout & Clear Tokens'),
            ),
            const SizedBox(height: 16),
            if (authState.failure != null)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error: ${authState.failure!.message}',
                    style: TextStyle(color: Colors.red.shade700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
