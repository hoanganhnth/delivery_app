import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/core/contracts/session_port_provider.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/profile/application/profile_notifier.dart';

import '../application/support_coordinator.dart';
import '../data/firebase_support_repository.dart';
import '../domain/repositories/support_repository.dart';

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  if (!RuntimeConfig.supportChatEnabled) {
    return const UnavailableSupportRepository();
  }
  // Firebase is initialized before the production ProviderScope is mounted.
  // Keep tests and startup failures fail-closed instead of throwing while the
  // repository is being constructed.
  if (Firebase.apps.isEmpty) {
    return const UnavailableSupportRepository();
  }
  final profile = ref.watch(profileProvider).user;
  return FirebaseSupportRepository(
    dio: ref.watch(authenticatedDioProvider),
    session: ref.watch(sessionPortProvider),
    userEmail: profile?.email,
    userName: profile?.displayName,
  );
});

final supportCoordinatorProvider = Provider<SupportCoordinator>(
  (ref) => SupportCoordinator(ref.watch(supportRepositoryProvider)),
);

final supportChatEnabledProvider = Provider<bool>(
  (ref) => RuntimeConfig.supportChatEnabled,
);
