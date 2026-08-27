import 'package:equatable/equatable.dart';

enum PaymentStatus { pending, succeeded, failed, expired, unknown }

/// Canonical, customer-safe payment status returned by the Gateway.
class PaymentOrder extends Equatable {
  const PaymentOrder({required this.paymentRef, required this.status});

  final String paymentRef;
  final PaymentStatus status;

  @override
  List<Object?> get props => [paymentRef, status];
}
