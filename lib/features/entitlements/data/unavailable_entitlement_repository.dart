import '../domain/entities/entitlement.dart';
import '../domain/repositories/entitlement_repository.dart';

/// Temporary client-first boundary. It keeps all access closed until the
/// backend receipt verifier and entitlement projection are available.
final class UnavailableEntitlementRepository implements EntitlementRepository {
  const UnavailableEntitlementRepository();

  @override
  Future<EntitlementSnapshot> refresh() =>
      Future.error(const EntitlementBackendUnavailableException());

  @override
  Future<EntitlementSnapshot> submit(StoreReceipt receipt) =>
      Future.error(const EntitlementBackendUnavailableException());
}
