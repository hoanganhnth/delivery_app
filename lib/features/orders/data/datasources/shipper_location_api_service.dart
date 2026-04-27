import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/features/orders/data/dtos/shipper_location_response_dto.dart';
import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'shipper_location_api_service.g.dart';

@RestApi()
abstract class ShipperLocationApiService {
  factory ShipperLocationApiService(Dio dio) = _ShipperLocationApiService;

  @GET('${ApiConstants.shipperLocations}/{id}')
  Future<BaseResponseDto<ShipperLocationResponseDto>> getShipperLocation(
    @Path('id') int shipperId,
  );
}
