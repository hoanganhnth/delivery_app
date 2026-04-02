/// Entity representing a purchase transaction
class PurchaseEntity {
  final String purchaseId;
  final String productId;
  final String transactionDate;
  final PurchaseStatus status;
  final String? verificationData;
  final bool pendingCompletePurchase;

  const PurchaseEntity({
    required this.purchaseId,
    required this.productId,
    required this.transactionDate,
    required this.status,
    this.verificationData,
    this.pendingCompletePurchase = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseEntity &&
          runtimeType == other.runtimeType &&
          purchaseId == other.purchaseId;

  @override
  int get hashCode => purchaseId.hashCode;
}

/// Status of a purchase
enum PurchaseStatus {
  /// Purchase is pending
  pending,

  /// Purchase is completed successfully
  purchased,

  /// Purchase is restored
  restored,

  /// Purchase encountered an error
  error,

  /// Purchase was canceled
  canceled,
}
