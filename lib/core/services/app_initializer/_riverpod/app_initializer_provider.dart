import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:delivery_app/core/logger/app_logger.dart';
import 'package:delivery_app/core/services/app_initializer/i_app_initializer_service.dart';
import 'package:delivery_app/core/services/app_initializer/app_initializer_service.dart';

part 'app_initializer_provider.g.dart';

/// The provider is the "wiring point" where Feature-layer dependencies
/// are injected into the domain-agnostic Core service.
@Riverpod(keepAlive: true)
IAppInitializerService appInitializerService(Ref ref) {
  final authNotifier = ref.read(authProvider.notifier);
  final profileNotifier = ref.read(profileProvider.notifier);

  return AppInitializerService(
    initTasks: [
      () async {
        final authState = await authNotifier.checkAuthStatus();
        if (authState.isAuthenticated) {
          try {
            await profileNotifier.getUserProfile(useCache: true);
          } catch (e) {
            AppLogger.w('Profile load failed but skipping...');
          }
        }
      },
    ],
    cleanupTasks: [
      () async => profileNotifier.clearProfileCache(),
    ],
  );
}
