import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:delivery_app/features/payments/domain/entities/payment_order.dart';
import 'package:dio/dio.dart';

/// Gateway adapter for the customer-safe payment status projection. The Dio
/// instance is supplied by the authenticated network boundary.
class ApiCustomerPaymentGateway implements PaymentStatusRefresher {
  ApiCustomerPaymentGateway(this._dio);

  final Dio _dio;

  @override
  Future<PaymentOrder> refresh(String paymentRef) async {
    final response = await _dio.get<Object>(
      ApiConstants.customerPaymentByReference(paymentRef),
    );
    final envelope = response.data;
    if (envelope is! Map<String, dynamic> ||
        envelope['status'] != 1 ||
        envelope['data'] is! Map<String, dynamic>) {
      throw const FormatException('Invalid customer payment status response');
    }
    final data = envelope['data']! as Map<String, dynamic>;
    final reference = data['paymentRef'];
    final status = data['status'];
    if (reference is! String || reference != paymentRef || status is! String) {
      throw const FormatException('Invalid customer payment status response');
    }
    return PaymentOrder(paymentRef: reference, status: _parseStatus(status));
  }

  PaymentStatus _parseStatus(String value) =>
      switch (value.trim().toUpperCase()) {
        'PENDING' => PaymentStatus.pending,
        'SUCCESS' => PaymentStatus.succeeded,
        'FAILED' => PaymentStatus.failed,
        'EXPIRED' => PaymentStatus.expired,
        _ => PaymentStatus.unknown,
      };
}
