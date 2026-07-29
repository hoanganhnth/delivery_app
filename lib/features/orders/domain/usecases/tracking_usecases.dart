import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/shipper_location_entity.dart';
import '../repositories/shipper_location_repository.dart';

// ======================================================================
// SHIPPER LOCATION USE CASES
// ======================================================================

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
class TrackShipperLocationUseCase
    extends UseCase<Stream<ShipperLocationEntity>, TrackShipperParams> {
  final ShipperLocationRepository repository;

  TrackShipperLocationUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<ShipperLocationEntity>>> call(
    TrackShipperParams params,
  ) async {
    final result = await repository.startTrackingShipper(
      params.shipperId,
      params.deliveryId,
    );

    return result.fold(
      (failure) => left(failure),
      (_) => right(repository.locationStream),
    );
  }
}

// ======================================================================
// SHIPPER LOCATION PARAMETERS
// ======================================================================

/// Parameters cho TrackShipperLocationUseCase
class TrackShipperParams {
  final int shipperId;
  final int deliveryId;

  TrackShipperParams({required this.shipperId, required this.deliveryId});
}
