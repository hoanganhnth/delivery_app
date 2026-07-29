import 'package:delivery_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/delivery_tracking_entity.dart';

/// Repository interface cho delivery tracking
abstract class DeliveryTrackingRepository {
  /// Lấy delivery tracking hiện tại theo orderId
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(
    int orderId,
  );
}
