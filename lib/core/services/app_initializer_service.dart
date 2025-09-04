import 'package:delivery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:delivery_app/features/main/presentation/providers/navigation_provider.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInitializerService {
  final Ref ref;
  AppInitializerService(this.ref);

  void initialize() {
    final authProvider = ref.read(authStateProvider.notifier);
    final profileProvider = ref.read(profileStateProvider.notifier);
    if (!authProvider.isAuthenticated) {
      return;
    }
    profileProvider.getUserProfile();
  }

  void clearDataAfterLogout() {
    final tabProvider = ref.read(navigationControllerProvider);

    tabProvider.goToHome();
  }
}


final appInitializerServiceProvider = Provider<AppInitializerService>((ref) {
  return AppInitializerService(ref);
});