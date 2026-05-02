import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/core/network/_riverpod/network_providers.dart';
import 'package:delivery_app/features/cart/data/datasources/payment_api_service.dart';
import 'package:delivery_app/features/cart/data/dtos/payment_order_dto.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';

part 'payment_provider.g.dart';

@Riverpod(keepAlive: true)
PaymentApiService paymentApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PaymentApiService(dio);
}

@riverpod
class PaymentNotifier extends _$PaymentNotifier {
  @override
  FutureOr<PaymentOrderDto?> build() {
    return null;
  }

  Future<PaymentOrderDto?> createPayment(CreatePaymentDto request) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(paymentApiServiceProvider);
      final response = await service.createPayment(request);
      if (response.isSuccess && response.data != null) {
        state = AsyncValue.data(response.data);
        return response.data;
      } else {
        throw Exception(response.message);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<PaymentOrderDto?> checkPaymentStatus(String paymentRef) async {
    try {
      final service = ref.read(paymentApiServiceProvider);
      final response = await service.getPaymentByRef(paymentRef);
      if (response.isSuccess && response.data != null) {
        state = AsyncValue.data(response.data);
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<PaymentOrderDto?> confirmFakePayment(String paymentRef) async {
    try {
      final service = ref.read(paymentApiServiceProvider);
      final response = await service.confirmFakePayment(paymentRef);
      if (response.isSuccess && response.data != null) {
        state = AsyncValue.data(response.data);
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
