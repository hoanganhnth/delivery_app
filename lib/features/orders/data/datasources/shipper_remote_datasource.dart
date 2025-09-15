import '../../../../core/data/dtos/base_response_dto.dart';
import '../dtos/shipper_dto.dart';

/// Interface cho shipper remote data source
abstract class ShipperRemoteDataSource {
  /// Lấy thông tin shipper theo ID
  Future<BaseResponseDto<ShipperDto>> getShipperById(int shipperId);

  /// Lấy danh sách shipper trong khu vực
  Future<BaseResponseDto<List<ShipperDto>>> getShippersInArea(
    GetShippersInAreaRequestDto request,
  );


}
