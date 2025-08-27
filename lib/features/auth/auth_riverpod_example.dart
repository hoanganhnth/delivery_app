import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/logger/app_logger.dart';
import 'presentation/providers/auth_providers.dart';
import 'presentation/providers/auth_network_providers.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/widgets/auth_demo_widget.dart';

/// Example app demonstrating Auth Module with Riverpod
class AuthRiverpodExampleApp extends StatelessWidget {
  const AuthRiverpodExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: getAppProviderOverrides(),
      child: MaterialApp(
        title: 'Auth Module with Riverpod Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthDemoWidget(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}

/// Simple home screen to demonstrate successful authentication
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authNotifier.logout();
              if (context.mounted) {
                Navigator.of(context).pushReplacementNamed('/');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    if (authState.hasUser) ...[
                      Text('Email: ${authState.user!.email}'),
                      Text('ID: ${authState.user!.id}'),
                      Text('Name: ${authState.user!.name ?? 'N/A'}'),
                      const SizedBox(height: 8),
                      Text(
                        'Access Token: ${authState.user!.accessToken.substring(0, 20)}...',
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Auth State',
                      style: Theme.of(context).textTheme.titleMedium,
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
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: authState.isRefreshLoading ? null : () async {
                AppLogger.i('Testing token refresh...');
                final newToken = await authNotifier.refreshToken();
                if (context.mounted) {
                  if (newToken != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Token refreshed successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Token refresh failed!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              icon: authState.isRefreshLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              label: const Text('Refresh Token'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example of using auth providers in a service class
class AuthService {
  static Future<bool> loginWithCredentials(
    WidgetRef ref,
    String email,
    String password,
  ) async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    AppLogger.d('AuthService: Attempting login for $email');
    
    await authNotifier.login(email: email, password: password);
    
    final authState = ref.read(authStateProvider);
    return authState.isAuthenticated;
  }

  static Future<bool> registerUser(
    WidgetRef ref, {
    required String email,
    required String password,
    required String confirmPassword,
    String? name,
  }) async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    AppLogger.d('AuthService: Attempting registration for $email');
    
    await authNotifier.register(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      name: name,
    );
    
    final authState = ref.read(authStateProvider);
    return authState.isAuthenticated;
  }

  static Future<void> logoutUser(WidgetRef ref) async {
    final authNotifier = ref.read(authStateProvider.notifier);
    
    AppLogger.d('AuthService: Logging out user');
    
    await authNotifier.logout();
  }

  static bool isUserAuthenticated(WidgetRef ref) {
    final authState = ref.read(authStateProvider);
    return authState.isAuthenticated;
  }

  static String? getCurrentUserEmail(WidgetRef ref) {
    final authState = ref.read(authStateProvider);
    return authState.user?.email;
  }
}

/// Example of a custom hook-like provider for auth status
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isAuthenticated;
});

/// Example of a provider that depends on auth state
final userEmailProvider = Provider<String?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user?.email;
});

/// Example of using auth state in a guard
class AuthGuard extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;

  const AuthGuard({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    
    if (isAuthenticated) {
      return child;
    } else {
      return fallback ?? const LoginScreen();
    }
  }
}

/// Example usage in main.dart:
/// 
/// ```dart
/// void main() {
///   runApp(const AuthRiverpodExampleApp());
/// }
/// ```
/// 
/// Example of protecting a route:
/// 
/// ```dart
/// class ProtectedScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AuthGuard(
///       child: HomeScreen(),
///       fallback: LoginScreen(),
///     );
///   }
/// }
/// ```
