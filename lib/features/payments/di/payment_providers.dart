import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:delivery_app/features/payments/data/customer_payment_gateway.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/config/runtime_config.dart';

/// Payments may only use the authenticated Gateway Dio. Feature code never
/// creates a service-port client or attaches an internal service credential.
final customerPaymentStatusRefresherProvider = Provider<PaymentStatusRefresher>(
  (ref) => ApiCustomerPaymentGateway(ref.watch(authenticatedDioProvider)),
);

final paymentReturnCoordinatorProvider = Provider<PaymentReturnCoordinator>(
  (ref) => PaymentReturnCoordinator(
    expectedReturnUrl: RuntimeConfig.vnpayReturnUri,
    statusRefresher: ref.watch(customerPaymentStatusRefresherProvider),
  ),
);
