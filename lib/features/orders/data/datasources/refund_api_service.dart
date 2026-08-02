import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/refund_case_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'refund_api_service.g.dart';

@RestApi()
abstract class RefundApiService {
  factory RefundApiService(Dio dio) = _RefundApiService;

  /// Customer-owned, read-only refund case status. This endpoint has no
  /// request, approval or provider-processing mutation counterpart.
  @GET(ApiConstants.customerRefundCases)
  Future<BaseResponseDto<List<RefundCaseDto>>> getMyRefundCases(
    @Query('limit') int limit,
  );
}
