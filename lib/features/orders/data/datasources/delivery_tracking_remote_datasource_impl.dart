import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/error/dio_exception_handler.dart';
import '../dtos/current_delivery_dto.dart';
import 'delivery_tracking_remote_datasource.dart';

part 'delivery_tracking_remote_datasource_impl.g.dart';

/// Retrofit API service cho delivery tracking
@RestApi()
abstract class DeliveryTrackingApiService {
  factory DeliveryTrackingApiService(Dio dio) = _DeliveryTrackingApiService;

  /// API để lấy delivery tracking hiện tại
  @GET('${ApiConstants.delivery}/order/{orderId}')
  Future<BaseResponseDto<CurrentDeliveryDto>> getCurrentDelivery(
    @Path() int orderId,
  );
}

/// Implementation của DeliveryTrackingRemoteDataSource
class DeliveryTrackingRemoteDataSourceImpl
    implements DeliveryTrackingRemoteDataSource {
  final DeliveryTrackingApiService _apiService;

  DeliveryTrackingRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<CurrentDeliveryDto>> getCurrentDelivery(
    int orderId,
  ) async {
    try {
      AppLogger.d('Getting current delivery for order: $orderId');
      final response = await _apiService.getCurrentDelivery(orderId);
      AppLogger.i(
        'Successfully retrieved current delivery for order: $orderId',
      );
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get current delivery for order: $orderId', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting current delivery', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
