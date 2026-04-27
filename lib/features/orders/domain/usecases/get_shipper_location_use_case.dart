import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/shipper_location_entity.dart';
import '../repositories/shipper_location_repository.dart';

class GetShipperLocationUseCase extends UseCase<ShipperLocationEntity, int> {
  final ShipperLocationRepository repository;

  GetShipperLocationUseCase(this.repository);

  @override
  Future<Either<Failure, ShipperLocationEntity>> call(int shipperId) async {
    return await repository.getShipperLocation(shipperId);
  }
}
