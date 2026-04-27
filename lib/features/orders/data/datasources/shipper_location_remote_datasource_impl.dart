import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/core/error/dio_exception_handler.dart';
import 'package:delivery_app/features/orders/data/dtos/shipper_location_response_dto.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_api_service.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_remote_datasource.dart';
import 'package:dio/dio.dart';

class ShipperLocationRemoteDataSourceImpl implements ShipperLocationRemoteDataSource {
  final ShipperLocationApiService _apiService;

  ShipperLocationRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<ShipperLocationResponseDto>> getShipperLocation(int shipperId) async {
    try {
      final response = await _apiService.getShipperLocation(shipperId);
      AppLogger.i('Successfully fetched initial location for shipper: $shipperId');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to fetch initial location for shipper: $shipperId', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error fetching initial shipper location', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
