import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:delivery_app/features/payments/domain/entities/payment_order.dart';
import 'package:dio/dio.dart';

/// The customer boundary currently returns `BaseResponse<Void>` with an
/// unsupported-operation error. Keep the existing refreshFailed UI outcome
/// until the backend publishes an owned payment status projection.
class ApiCustomerPaymentGateway implements PaymentStatusRefresher {
  ApiCustomerPaymentGateway(this._dio);

  final Dio _dio;

  @override
  Future<PaymentOrder> refresh(String paymentRef) async {
    await _dio.get<Object>(ApiConstants.customerPaymentByReference(paymentRef));
    throw UnsupportedError('Customer payment status is unavailable');
  }
}
