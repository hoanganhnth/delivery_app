import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/error_mapper.dart';
import '../../domain/entities/shipper_entity.dart';
import '../../domain/repositories/shipper_repository.dart';
import '../datasources/shipper_remote_datasource.dart';
import '../dtos/shipper_dto.dart';

class ShipperRepositoryImpl implements ShipperRepository {
  final ShipperRemoteDataSource _remoteDataSource;

  ShipperRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ShipperEntity>> getShipperById(int shipperId) async {
    try {
      final response = await _remoteDataSource.getShipperById(shipperId);

      if (response.isSuccess && response.data != null) {
        return right(response.data!.toEntity());
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<ShipperEntity>>> getShippersInArea({
    required double latitude,
    required double longitude,
    double radius = 10.0,
  }) async {
    try {
      final request = GetShippersInAreaRequestDto(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );

      final response = await _remoteDataSource.getShippersInArea(request);

      if (response.isSuccess && response.data != null) {
        final entities = response.data!.map((dto) => dto.toEntity()).toList();
        return right(entities);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
