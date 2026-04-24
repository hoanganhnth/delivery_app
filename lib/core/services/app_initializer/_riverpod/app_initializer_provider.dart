import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import 'package:delivery_app/core/services/app_initializer/i_app_initializer_service.dart';
import 'package:delivery_app/core/services/app_initializer/app_initializer_service.dart';

part 'app_initializer_provider.g.dart';

@Riverpod(keepAlive: true)
IAppInitializerService appInitializerService(Ref ref) {
  final authNotifier = ref.read(authProvider.notifier);
  final profileNotifier = ref.read(profileProvider.notifier);

  return AppInitializerService(auth: authNotifier, profile: profileNotifier);
}
