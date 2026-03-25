import 'package:delivery_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../logger/app_logger.dart';

part 'app_initializer_service.g.dart';

class AppInitializerService {
  final Ref ref;
  AppInitializerService(this.ref);

  /// Initialize the app - called from splash screen
  Future<void> initialize() async {
    try {
      AppLogger.i('AppInitializerService: Starting initialization');

      // Check authentication status first
      final authNotifier = ref.read(authProvider.notifier);
      await authNotifier.checkAuthStatus();

      final authState = ref.read(authProvider);

      if (authState.isAuthenticated) {
        AppLogger.i(
          'AppInitializerService: User is authenticated, loading profile',
        );

        // Load user profile if authenticated - use cache first on app startup
        final profileNotifier = ref.read(profileProvider.notifier);
        await profileNotifier.getUserProfile(
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
    final profileNotifier = ref.read(profileProvider.notifier);
    await profileNotifier.clearProfileCache();

    AppLogger.i('AppInitializerService: Data cleared successfully');
  }
}

@riverpod
AppInitializerService appInitializerService(Ref ref) {
  return AppInitializerService(ref);
}
