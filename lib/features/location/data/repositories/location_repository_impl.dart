import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_datasource.dart';

/// Implementation của LocationRepository
class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> requestLocationPermission() async {
    try {
      final result = await dataSource.requestLocationPermission();
      return right(result);
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getCurrentPosition() async {
    try {
      final locationModel = await dataSource.getCurrentPosition();
      return right(locationModel.toEntity());
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final addressModel = await dataSource.getAddressFromCoordinates(latitude, longitude);
      return right(addressModel.toEntity());
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> getCoordinatesFromAddress({
    required String address,
  }) async {
    try {
      final locationModel = await dataSource.getCoordinatesFromAddress(address);
      return right(locationModel.toEntity());
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }

  @override
  Either<Failure, double> calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    try {
      final distance = dataSource.calculateDistance(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );
      return right(distance);
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLocationServiceEnabled() async {
    try {
      final result = await dataSource.isLocationServiceEnabled();
      return right(result);
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> openLocationSettings() async {
    try {
      await dataSource.openLocationSettings();
      return right(null);
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> openAppSettings() async {
    try {
      await dataSource.openAppSettings();
      return right(null);
    } catch (e) {
      return left(LocationFailure(e.toString()));
    }
  }
}
