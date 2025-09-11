import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/shipper_location_entity.dart';

/// Repository interface cho shipper location tracking
abstract class ShipperLocationRepository {
  /// Stream để lắng nghe location updates của shipper
  Stream<ShipperLocationEntity> get locationStream;
  
  /// Bắt đầu theo dõi vị trí shipper
  Future<Either<Failure, void>> startTrackingShipper(int shipperId);
  
  /// Dừng theo dõi vị trí shipper
  Future<Either<Failure, void>> stopTrackingShipper();
  
  /// Kiểm tra trạng thái tracking
  bool get isTracking;
}
