import 'package:equatable/equatable.dart';

enum RefundCaseStatus {
  requested,
  processing,
  succeeded,
  partial,
  failed,
  manualReview,
  noRefundRequired,
  unknown;

  static RefundCaseStatus fromBackend(String value) {
    return switch (value.trim().toUpperCase()) {
      'REQUESTED' => RefundCaseStatus.requested,
      'PROCESSING' => RefundCaseStatus.processing,
      'SUCCEEDED' => RefundCaseStatus.succeeded,
      'PARTIAL' => RefundCaseStatus.partial,
      'FAILED' => RefundCaseStatus.failed,
      'MANUAL_REVIEW' => RefundCaseStatus.manualReview,
      'NO_REFUND_REQUIRED' => RefundCaseStatus.noRefundRequired,
      _ => RefundCaseStatus.unknown,
    };
  }
}

/// A customer-safe, read-only refund case returned by Settlement.
class RefundCaseEntity extends Equatable {
  const RefundCaseEntity({
    required this.refundId,
    required this.orderId,
    required this.paymentMethod,
    required this.trigger,
    required this.status,
    required this.currency,
    required this.refundAmount,
    this.createdAt,
    this.updatedAt,
    this.processedAt,
  });

  final String refundId;
  final int orderId;
  final String paymentMethod;
  final String trigger;
  final RefundCaseStatus status;
  final String currency;
  final double refundAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? processedAt;

  @override
  List<Object?> get props => [
    refundId,
    orderId,
    paymentMethod,
    trigger,
    status,
    currency,
    refundAmount,
    createdAt,
    updatedAt,
    processedAt,
  ];
}
