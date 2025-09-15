import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/shipper_entity.dart';

abstract class ShipperRepository {
  /// Lấy thông tin shipper theo ID
  Future<Either<Failure, ShipperEntity>> getShipperById(int shipperId);

  /// Lấy danh sách shipper theo khu vực
  Future<Either<Failure, List<ShipperEntity>>> getShippersInArea({
    required double latitude,
    required double longitude, 
    double radius = 10.0, // km
  });


}
