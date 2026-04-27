import '../../../../core/network/resources/base_response_dto.dart';
import '../dtos/shipper_location_response_dto.dart';

/// Interface cho shipper location remote data source (REST API)
abstract class ShipperLocationRemoteDataSource {
  /// Lấy vị trí hiện tại của shipper theo ID
  Future<BaseResponseDto<ShipperLocationResponseDto>> getShipperLocation(int shipperId);
}
