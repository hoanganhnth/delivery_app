import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Authentication Status',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.w),
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
            SizedBox(height: 16.w),
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
                  ? SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Login (Demo)'),
            ),
            SizedBox(height: 8.w),
            ElevatedButton(
              onPressed: () async {
                // Check stored tokens
                await authNotifier.checkAuthStatus();
              },
              child: const Text('Check Stored Tokens'),
            ),
            SizedBox(height: 8.w),
            ElevatedButton(
              onPressed: authState.isAuthenticated
                  ? () async {
                      // Logout and clear tokens
                      await authNotifier.logout();
                    }
                  : null,
              child: const Text('Logout & Clear Tokens'),
            ),
            SizedBox(height: 16.w),
            if (authState.failure != null)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
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
