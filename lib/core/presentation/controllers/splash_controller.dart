import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/core/routing/app_routes.dart';
import 'package:delivery_app/core/services/app_initializer/_riverpod/app_initializer_provider.dart';

part 'splash_controller.g.dart';

/// Splash state
enum SplashState {
  initializing,
  checkingAuth,
  navigating,
  error,
}

/// Splash controller to handle app initialization
@riverpod
class SplashController extends _$SplashController {
  @override
  SplashState build() => SplashState.initializing;

  /// Initialize the app and navigate to appropriate screen
  Future<void> initializeApp(GoRouter router) async {
    try {
      AppLogger.i('SplashController: Starting app initialization');
      
      // Set state to initializing
      state = SplashState.initializing;
      
      // Minimum splash duration for better UX
      await Future.delayed(const Duration(seconds: 2));
      
      // Check authentication status
      state = SplashState.checkingAuth;
      AppLogger.i('SplashController: Checking authentication status');
      
      // Use app initializer service for proper initialization
      final appInitializer = ref.read(appInitializerServiceProvider);
      await appInitializer.initialize();
      
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.isAuthenticated;
      
      AppLogger.i('SplashController: Authentication status - $isAuthenticated');
      
      // Navigate based on authentication status
      state = SplashState.navigating;
      
      if (isAuthenticated) {
        AppLogger.i('SplashController: User authenticated, navigating to main');
        router.go(AppRoutes.main);
      } else {
        AppLogger.i('SplashController: User not authenticated, navigating to login');
        router.go(AppRoutes.login);
      }
      
      AppLogger.i('SplashController: App initialization completed');
      
    } catch (error, stackTrace) {
      AppLogger.e('SplashController: Error during initialization - $error');
      AppLogger.e('Stack trace: $stackTrace');
      
      state = SplashState.error;
      
      // Navigate to login on error
      router.go(AppRoutes.login);
    }
  }

  /// Get loading message based on current state
  String get loadingMessage {
    switch (state) {
      case SplashState.initializing:
        return 'Initializing app...';
      case SplashState.checkingAuth:
        return 'Checking authentication...';
      case SplashState.navigating:
        return 'Navigating...';
      case SplashState.error:
        return 'Something went wrong...';
    }
  }

  /// Check if currently in error state
  bool get hasError => state == SplashState.error;
}
