enum StorePlatform { ios, android }

enum EntitlementStatus { unavailable, pending, active, revoked }

final class StoreReceipt {
  const StoreReceipt({
    required this.platform,
    required this.productId,
    required this.transactionId,
    required this.signedPayload,
  });

  final StorePlatform platform;
  final String productId;
  final String transactionId;
  final String signedPayload;
}

final class EntitlementSnapshot {
  const EntitlementSnapshot._(this.status, this.confirmedProductIds);

  const EntitlementSnapshot.unavailable()
    : this._(EntitlementStatus.unavailable, const {});

  const EntitlementSnapshot.pending()
    : this._(EntitlementStatus.pending, const {});

  const EntitlementSnapshot.active(Set<String> productIds)
    : this._(EntitlementStatus.active, productIds);

  const EntitlementSnapshot.revoked()
    : this._(EntitlementStatus.revoked, const {});

  final EntitlementStatus status;
  final Set<String> confirmedProductIds;
}
