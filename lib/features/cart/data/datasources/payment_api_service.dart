import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/features/cart/data/dtos/payment_order_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_api_service.g.dart';

@RestApi()
abstract class PaymentApiService {
  factory PaymentApiService(Dio dio) = _PaymentApiService;

  /// Tạo giao dịch thanh toán
  @POST('/settlement/payments/create')
  Future<BaseResponseDto<PaymentOrderDto>> createPayment(
    @Body() CreatePaymentDto request,
  );

  /// Query trạng thái thanh toán theo ref
  @GET('/settlement/payments/ref/{ref}')
  Future<BaseResponseDto<PaymentOrderDto>> getPaymentByRef(
    @Path('ref') String paymentRef,
  );

  /// Fake confirm (dev/test)
  @GET('/settlement/payments/fake-confirm/{ref}')
  Future<BaseResponseDto<PaymentOrderDto>> confirmFakePayment(
    @Path('ref') String paymentRef,
  );

  /// Danh sách provider khả dụng
  @GET('/settlement/payments/providers')
  Future<BaseResponseDto<List<String>>> getAvailableProviders();
}
