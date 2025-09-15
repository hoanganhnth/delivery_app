import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/delivery_tracking_entity.dart';
import '../entities/shipper_location_entity.dart';
import '../repositories/delivery_tracking_repository.dart';
import '../repositories/shipper_location_repository.dart';

// ======================================================================
// TRACKING USE CASES - Gộp tất cả delivery & shipper tracking vào 1 file
// ======================================================================

/// UseCase để kết nối đến delivery tracking service
class ConnectDeliveryTrackingUseCase extends UseCase<void, NoParams> {
  final DeliveryTrackingRepository repository;

  ConnectDeliveryTrackingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.connect();
  }
}

/// UseCase để ngắt kết nối delivery tracking service
class DisconnectDeliveryTrackingUseCase extends UseCase<void, NoParams> {
  final DeliveryTrackingRepository repository;

  DisconnectDeliveryTrackingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.disconnect();
  }
}

/// UseCase để bắt đầu theo dõi delivery cho order
// class StartDeliveryTrackingUseCase extends UseCase<void, StartDeliveryTrackingParams> {
//   final DeliveryTrackingRepository repository;

//   StartDeliveryTrackingUseCase(this.repository);

//   @override
//   Future<Either<Failure, void>> call(StartDeliveryTrackingParams params) async {
//     return await repository.startTracking(params.orderId);
//   }
// }

/// UseCase để dừng theo dõi delivery
class StopDeliveryTrackingUseCase extends UseCase<void, NoParams> {
  final DeliveryTrackingRepository repository;

  StopDeliveryTrackingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.stopTracking();
  }
}

/// UseCase để làm mới kết nối delivery tracking
class RefreshDeliveryTrackingUseCase extends UseCase<void, NoParams> {
  final DeliveryTrackingRepository repository;

  RefreshDeliveryTrackingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.refresh();
  }
}

/// UseCase để theo dõi delivery và trả về stream
class TrackDeliveryUseCase extends UseCase<Stream<DeliveryTrackingEntity>, TrackDeliveryParams> {
  final DeliveryTrackingRepository repository;

  TrackDeliveryUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<DeliveryTrackingEntity>>> call(TrackDeliveryParams params) async {
    final result = await repository.startTracking(params.orderId);
    
    return result.fold(
      (failure) => left(failure),
      (_) => right(repository.deliveryStream),
    );
  }
}

// ======================================================================
// PARAMETERS CLASSES
// ======================================================================

/// Parameters cho StartDeliveryTrackingUseCase
class StartDeliveryTrackingParams {
  final int orderId;

  StartDeliveryTrackingParams({required this.orderId});
}

/// Parameters cho TrackDeliveryUseCase
class TrackDeliveryParams {
  final int orderId;

  TrackDeliveryParams({required this.orderId});
}

// ======================================================================
// SHIPPER LOCATION USE CASES
// ======================================================================

/// UseCase để bắt đầu theo dõi vị trí shipper
// class StartShipperTrackingUseCase extends UseCase<void, StartShipperTrackingParams> {
//   final ShipperLocationRepository repository;

//   StartShipperTrackingUseCase(this.repository);

//   @override
//   Future<Either<Failure, void>> call(StartShipperTrackingParams params) async {
//     return await repository.startTrackingShipper(params.shipperId);
//   }
// }

/// UseCase để dừng theo dõi vị trí shipper
class StopShipperTrackingUseCase extends UseCase<void, NoParams> {
  final ShipperLocationRepository repository;

  StopShipperTrackingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.stopTrackingShipper();
  }
}

/// UseCase để theo dõi vị trí shipper và trả về stream
class TrackShipperLocationUseCase extends UseCase<Stream<ShipperLocationEntity>, TrackShipperParams> {
  final ShipperLocationRepository repository;

  TrackShipperLocationUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<ShipperLocationEntity>>> call(TrackShipperParams params) async {
    final result = await repository.startTrackingShipper(params.shipperId);
    
    return result.fold(
      (failure) => left(failure),
      (_) => right(repository.locationStream),
    );
  }
}

// ======================================================================
// SHIPPER LOCATION PARAMETERS
// ======================================================================

/// Parameters cho StartShipperTrackingUseCase
class StartShipperTrackingParams {
  final int shipperId;

  StartShipperTrackingParams({required this.shipperId});
}

/// Parameters cho TrackShipperLocationUseCase
class TrackShipperParams {
  final int shipperId;

  TrackShipperParams({required this.shipperId});
}
