import 'package:delivery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logger/app_logger.dart';

class AppInitializerService {
  final Ref ref;
  AppInitializerService(this.ref);

  /// Initialize the app - called from splash screen
  Future<void> initialize() async {
    try {
      AppLogger.i('AppInitializerService: Starting initialization');

      // Check authentication status first
      final authNotifier = ref.read(authStateProvider.notifier);
      await authNotifier.checkAuthStatus();

      final authState = ref.read(authStateProvider);

      if (authState.isAuthenticated) {
        AppLogger.i(
          'AppInitializerService: User is authenticated, loading profile',
        );

        // Load user profile if authenticated - use cache first on app startup
        final profileProvider = ref.read(profileStateProvider.notifier);
        await profileProvider.getUserProfile(
          useCache: true,
          forceRefresh: false,
        );

        AppLogger.i('AppInitializerService: Profile loaded successfully');
      } else {
        AppLogger.i('AppInitializerService: User not authenticated');
      }

      AppLogger.i('AppInitializerService: Initialization completed');
    } catch (error, stackTrace) {
      AppLogger.e(
        'AppInitializerService: Error during initialization - $error',
      );
      AppLogger.e('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Clear data after logout
  void clearDataAfterLogout() async {
    AppLogger.i('AppInitializerService: Clearing data after logout');

    // final tabProvider = ref.read(navigationControllerProvider);
    // tabProvider.goToHome();
    final profileProvider = ref.read(profileStateProvider.notifier);
    await profileProvider.clearProfileCache();

    AppLogger.i('AppInitializerService: Data cleared successfully');
  }
}

final appInitializerServiceProvider = Provider<AppInitializerService>((ref) {
  return AppInitializerService(ref);
});
