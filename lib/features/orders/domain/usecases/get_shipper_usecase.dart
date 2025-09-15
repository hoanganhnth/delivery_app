import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/shipper_entity.dart';
import '../repositories/shipper_repository.dart';

/// UseCase để lấy thông tin shipper theo ID
class GetShipperByIdUseCase extends UseCase<ShipperEntity, int> {
  final ShipperRepository _repository;

  GetShipperByIdUseCase(this._repository);

  @override
  Future<Either<Failure, ShipperEntity>> call(int shipperId) async {
    if (shipperId <= 0) {
      return left(const ValidationFailure('Shipper ID phải lớn hơn 0'));
    }
    
    return await _repository.getShipperById(shipperId);
  }
}

/// Params cho GetShippersInAreaUseCase
class GetShippersInAreaParams {
  final double latitude;
  final double longitude;
  final double radius;

  const GetShippersInAreaParams({
    required this.latitude,
    required this.longitude,
    this.radius = 10.0,
  });
}

/// UseCase để lấy danh sách shipper trong khu vực
class GetShippersInAreaUseCase extends UseCase<List<ShipperEntity>, GetShippersInAreaParams> {
  final ShipperRepository _repository;

  GetShippersInAreaUseCase(this._repository);

  @override
  Future<Either<Failure, List<ShipperEntity>>> call(GetShippersInAreaParams params) async {
    if (params.latitude < -90 || params.latitude > 90) {
      return left(const ValidationFailure('Latitude không hợp lệ'));
    }
    
    if (params.longitude < -180 || params.longitude > 180) {
      return left(const ValidationFailure('Longitude không hợp lệ'));
    }
    
    if (params.radius <= 0) {
      return left(const ValidationFailure('Radius phải lớn hơn 0'));
    }
    
    return await _repository.getShippersInArea(
      latitude: params.latitude,
      longitude: params.longitude,
      radius: params.radius,
    );
  }
}
