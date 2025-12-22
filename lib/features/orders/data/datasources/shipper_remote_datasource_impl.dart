import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/error/dio_exception_handler.dart';
import '../dtos/shipper_dto.dart';
import 'shipper_remote_datasource.dart';

part 'shipper_remote_datasource_impl.g.dart';

/// Retrofit API service cho shipper
@RestApi()
abstract class ShipperApiService {
  factory ShipperApiService(Dio dio) = _ShipperApiService;

  @GET('/shippers/{id}')
  Future<BaseResponseDto<ShipperDto>> getShipperById(@Path('id') int shipperId);

  @POST('/shippers/in-area')
  Future<BaseResponseDto<List<ShipperDto>>> getShippersInArea(
    @Body() GetShippersInAreaRequestDto request,
  );
}

/// Implementation của ShipperRemoteDataSource
class ShipperRemoteDataSourceImpl implements ShipperRemoteDataSource {
  final ShipperApiService _apiService;

  ShipperRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<ShipperDto>> getShipperById(int shipperId) async {
    try {
      final response = await _apiService.getShipperById(shipperId);
      AppLogger.i('Successfully retrieved shipper: ${response.data?.name}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get shipper with id: $shipperId', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting shipper', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<ShipperDto>>> getShippersInArea(
    GetShippersInAreaRequestDto request,
  ) async {
    try {
      final response = await _apiService.getShippersInArea(request);
      AppLogger.i(
        'Successfully retrieved ${response.data?.length ?? 0} shippers in area',
      );
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get shippers in area', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting shippers in area', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
