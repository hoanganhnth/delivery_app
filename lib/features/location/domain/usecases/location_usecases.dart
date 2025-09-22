import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

/// UseCase để lấy vị trí hiện tại
class GetCurrentLocationUseCase extends UseCase<LocationEntity, NoParams> {
  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(NoParams params) async {
    // Kiểm tra quyền trước
    final permissionResult = await repository.requestLocationPermission();
    
    return permissionResult.fold(
      (failure) => left(failure),
      (hasPermission) async {
        if (!hasPermission) {
          return left(const LocationFailure('Location permission denied'));
        }
        
        return await repository.getCurrentPosition();
      },
    );
  }
}

/// UseCase để lấy địa chỉ từ tọa độ
class GetAddressFromCoordinatesUseCase extends UseCase<AddressEntity, GetAddressFromCoordinatesParams> {
  final LocationRepository repository;

  GetAddressFromCoordinatesUseCase(this.repository);

  @override
  Future<Either<Failure, AddressEntity>> call(GetAddressFromCoordinatesParams params) async {
    return await repository.getAddressFromCoordinates(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

/// Parameters cho GetAddressFromCoordinatesUseCase
class GetAddressFromCoordinatesParams {
  final double latitude;
  final double longitude;

  GetAddressFromCoordinatesParams({
    required this.latitude,
    required this.longitude,
  });
}

/// UseCase để lấy tọa độ từ địa chỉ
class GetCoordinatesFromAddressUseCase extends UseCase<LocationEntity, GetCoordinatesFromAddressParams> {
  final LocationRepository repository;

  GetCoordinatesFromAddressUseCase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(GetCoordinatesFromAddressParams params) async {
    return await repository.getCoordinatesFromAddress(address: params.address);
  }
}

/// Parameters cho GetCoordinatesFromAddressUseCase
class GetCoordinatesFromAddressParams {
  final String address;

  GetCoordinatesFromAddressParams({required this.address});
}

/// UseCase để tính khoảng cách
class CalculateDistanceUseCase extends UseCase<double, CalculateDistanceParams> {
  final LocationRepository repository;

  CalculateDistanceUseCase(this.repository);

  @override
  Future<Either<Failure, double>> call(CalculateDistanceParams params) async {
    return repository.calculateDistance(
      startLatitude: params.startLatitude,
      startLongitude: params.startLongitude,
      endLatitude: params.endLatitude,
      endLongitude: params.endLongitude,
    );
  }
}

/// Parameters cho CalculateDistanceUseCase
class CalculateDistanceParams {
  final double startLatitude;
  final double startLongitude;
  final double endLatitude;
  final double endLongitude;

  CalculateDistanceParams({
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
  });
}
