import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:delivery_app/core/logger/app_logger.dart';
import 'i_app_initializer_service.dart';

/// Implementation of IAppInitializerService
class AppInitializerService implements IAppInitializerService {
  final AuthNotifier auth;
  final ProfileNotifier profile;

  AppInitializerService({required this.auth, required this.profile});

  @override
  Future<void> initialize() async {
    try {
      AppLogger.i('AppInitializerService: Khởi chạy...');

      // 1. Auth check
      final authState = await auth.checkAuthStatus();

      if (authState.isAuthenticated) {
        // 2. Chạy song song tất cả các dịch vụ cần thiết
        await Future.wait([
          _initProfile(),
        ]);
      }

      AppLogger.i('AppInitializerService: Hoàn tất.');
    } catch (e) {
      AppLogger.e('AppInitializerService: Init Failed: $e');
      rethrow;
    }
  }

  Future<void> _initProfile() async {
    try {
      await profile.getUserProfile(useCache: true);
    } catch (e) {
      AppLogger.w('Profile load failed but skipping...');
    }
  }

  @override
  Future<void> clearDataAfterLogout() async {
    await Future.wait([
      profile.clearProfileCache(),
    ]);
  }
}
