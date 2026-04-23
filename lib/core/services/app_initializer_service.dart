import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../logger/app_logger.dart';

part 'app_initializer_service.g.dart';

class AppInitializerService {
  // Liệt kê rõ ràng các "đồ chơi" cần thiết
  final AuthNotifier auth;
  final ProfileNotifier profile;
  // Giả sử sau này bạn thêm 5-7 thằng nữa ở đây...
  // final SettingsNotifier settings;
  // final AnalyticsService analytics;

  AppInitializerService({required this.auth, required this.profile});

  Future<void> initialize() async {
    try {
      AppLogger.i('AppInitializerService: Khởi chạy...');

      // 1. Auth check
      final authState = await auth.checkAuthStatus();

      if (authState.isAuthenticated) {
        // 2. Chạy song song tất cả các dịch vụ cần thiết
        await Future.wait([
          _initProfile(),
          // _initSettings(),
          // _initAnalytics(),
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

  Future<void> clearDataAfterLogout() async {
    // Dọn dẹp tất cả các notifier đã inject vào
    await Future.wait([
      profile.clearProfileCache(),
      // settings.reset(),
    ]);
  }
}

@Riverpod(keepAlive: true)
AppInitializerService appInitializerService(Ref ref) {
  // "Nhặt" các món đồ cần thiết từ Store
  final authNotifier = ref.read(authProvider.notifier);
  final profileNotifier = ref.read(profileProvider.notifier);

  // Sau này có thêm 10 thằng thì bạn cứ nhặt thêm ở đây rồi truyền vào Constructor
  // final settings = ref.read(settingsProvider.notifier);

  return AppInitializerService(auth: authNotifier, profile: profileNotifier);
}
