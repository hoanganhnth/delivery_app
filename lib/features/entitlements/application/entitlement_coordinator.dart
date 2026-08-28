import '../domain/entities/entitlement.dart';
import '../domain/repositories/entitlement_repository.dart';

final class EntitlementCoordinator {
  const EntitlementCoordinator(this._repository);

  final EntitlementRepository _repository;

  Future<EntitlementSnapshot> refresh() async {
    try {
      return await _repository.refresh();
    } on EntitlementBackendUnavailableException {
      return const EntitlementSnapshot.unavailable();
    }
  }

  Future<EntitlementSnapshot> submitReceipt(StoreReceipt receipt) async {
    if (receipt.productId.trim().isEmpty ||
        receipt.transactionId.trim().isEmpty ||
        receipt.signedPayload.trim().isEmpty) {
      return const EntitlementSnapshot.unavailable();
    }
    try {
      return await _repository.submit(receipt);
    } on EntitlementBackendUnavailableException {
      return const EntitlementSnapshot.pending();
    }
  }
}
