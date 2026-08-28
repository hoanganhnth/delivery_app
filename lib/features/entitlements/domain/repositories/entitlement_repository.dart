import '../entities/entitlement.dart';

abstract interface class EntitlementRepository {
  Future<EntitlementSnapshot> refresh();
  Future<EntitlementSnapshot> submit(StoreReceipt receipt);
}

final class EntitlementBackendUnavailableException implements Exception {
  const EntitlementBackendUnavailableException();
}
