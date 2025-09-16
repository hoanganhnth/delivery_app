import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/delivery_tracking_entity.dart';
import '../repositories/delivery_tracking_repository.dart';

/// UseCase để lấy delivery tracking hiện tại theo orderId
class GetCurrentDeliveryUseCase extends UseCase<DeliveryTrackingEntity, GetCurrentDeliveryParams> {
  final DeliveryTrackingRepository repository;

  GetCurrentDeliveryUseCase(this.repository);

  @override
  Future<Either<Failure, DeliveryTrackingEntity>> call(GetCurrentDeliveryParams params) async {
    // Validate input
    if (params.orderId <= 0) {
      return left(const ValidationFailure('Order ID không hợp lệ'));
    }

    return await repository.getCurrentDelivery(params.orderId);
  }
}

/// Parameters cho GetCurrentDeliveryUseCase
class GetCurrentDeliveryParams {
  final int orderId;

  GetCurrentDeliveryParams({required this.orderId});

  @override
  String toString() => 'GetCurrentDeliveryParams(orderId: $orderId)';
}
