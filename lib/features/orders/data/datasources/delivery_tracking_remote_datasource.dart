import '../../../../core/data/dtos/base_response_dto.dart';
import '../dtos/current_delivery_dto.dart';

/// Interface cho delivery tracking remote data source
abstract class DeliveryTrackingRemoteDataSource {
  /// Lấy delivery tracking hiện tại theo orderId
  Future<BaseResponseDto<CurrentDeliveryDto>> getCurrentDelivery(int orderId);
}
