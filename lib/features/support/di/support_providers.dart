import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/config/runtime_config.dart';

import '../application/support_coordinator.dart';
import '../domain/repositories/support_repository.dart';

final supportRepositoryProvider = Provider<SupportRepository>(
  (ref) => const UnavailableSupportRepository(),
);

final supportCoordinatorProvider = Provider<SupportCoordinator>(
  (ref) => SupportCoordinator(ref.watch(supportRepositoryProvider)),
);

final supportChatEnabledProvider = Provider<bool>(
  (ref) => RuntimeConfig.supportChatEnabled,
);
