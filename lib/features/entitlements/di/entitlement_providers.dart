import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/config/runtime_config.dart';

import '../application/entitlement_coordinator.dart';
import '../data/iap_platform_adapter.dart';
import '../data/unavailable_entitlement_repository.dart';
import '../domain/repositories/entitlement_repository.dart';
import '../domain/entities/entitlement.dart';

final entitlementRepositoryProvider = Provider<EntitlementRepository>(
  (ref) => const UnavailableEntitlementRepository(),
);

final iapPlatformAdapterProvider = Provider<IapPlatformAdapter>((ref) {
  if (!RuntimeConfig.iapEntitlementsEnabled) {
    return const _DisabledIapPlatformAdapter();
  }
  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS => IosIapAdapter(),
    TargetPlatform.android => AndroidIapAdapter(),
    _ => const _DisabledIapPlatformAdapter(),
  };
});

final entitlementCoordinatorProvider = Provider<EntitlementCoordinator>(
  (ref) => EntitlementCoordinator(ref.watch(entitlementRepositoryProvider)),
);

final class _DisabledIapPlatformAdapter implements IapPlatformAdapter {
  const _DisabledIapPlatformAdapter();

  @override
  Future<List<StoreReceipt>> restore() =>
      Future.error(const IapPlatformUnavailableException());

  @override
  Future<StoreReceipt> purchase(String productId) =>
      Future.error(const IapPlatformUnavailableException());
}
