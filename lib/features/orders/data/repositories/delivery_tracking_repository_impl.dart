import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/network/resources/base_response_dto.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../dtos/current_delivery_dto.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/repositories/delivery_tracking_repository.dart';

/// REST-only repository for delivery status in the MVP.
class DeliveryTrackingRepositoryImpl implements DeliveryTrackingRepository {
  final DeliveryTrackingRemoteDataSource _remoteDataSource;
  DeliveryTrackingRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, DeliveryTrackingEntity>> getCurrentDelivery(
    int orderId,
  ) async {
    try {
      AppLogger.d('Getting current delivery for order: $orderId via REST API');

      final response = await _remoteDataSource.getCurrentDelivery(orderId);

      if (response.isSuccess && response.data != null) {
        final entity = response.data!.toEntity();
        AppLogger.i(
          'Successfully retrieved current delivery for order: $orderId',
        );
        return right(entity);
      } else {
        AppLogger.w('Current delivery API returned error: ${response.message}');
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      AppLogger.e('Failed to get current delivery for order: $orderId', e);
      return left(mapExceptionToFailure(e));
    } catch (e) {
      AppLogger.e('Unexpected error getting current delivery', e);
      return left(const ServerFailure('Không thể lấy thông tin delivery'));
    }
  }
}
