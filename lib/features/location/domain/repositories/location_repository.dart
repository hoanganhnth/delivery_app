import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/location_entity.dart';

/// Repository interface cho location operations
abstract class LocationRepository {
  /// Kiểm tra và yêu cầu quyền truy cập vị trí
  Future<Either<Failure, bool>> requestLocationPermission();

  /// Lấy vị trí hiện tại của người dùng
  Future<Either<Failure, LocationEntity>> getCurrentPosition();

  /// Lấy địa chỉ từ tọa độ (reverse geocoding)
  Future<Either<Failure, AddressEntity>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  });

  /// Lấy tọa độ từ địa chỉ (forward geocoding)
  Future<Either<Failure, LocationEntity>> getCoordinatesFromAddress({
    required String address,
  });

  /// Tính khoảng cách giữa 2 điểm (tính bằng meter)
  Either<Failure, double> calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });

  /// Kiểm tra xem location service có sẵn không
  Future<Either<Failure, bool>> isLocationServiceEnabled();

  /// Mở settings để người dùng bật location
  Future<Either<Failure, void>> openLocationSettings();

  /// Mở app settings để người dùng cấp quyền
  Future<Either<Failure, void>> openAppSettings();
}
