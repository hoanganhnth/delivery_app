import 'package:delivery_app/core/error/error_mapper.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/address_upsert_command.dart';
import '../../domain/entities/user_address_entity.dart';
import '../../domain/repositories/user_address_repository.dart';
import '../datasources/user_address_remote_datasource.dart';
import '../dtos/user_address_request_dto.dart';
import '../dtos/user_address_response_dto.dart';

/// Implementation của UserAddressRepository
class UserAddressRepositoryImpl implements UserAddressRepository {
  final UserAddressRemoteDataSource _remoteDataSource;

  UserAddressRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<UserAddressEntity>>> getUserAddresses(
    int userId,
  ) async {
    try {
      final dtos = await _remoteDataSource.getUserAddresses(userId);
      return right(dtos.map((dto) => dto.toEntity()).toList());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserAddressEntity>> getAddressById(
    int addressId,
  ) async {
    try {
      final dto = await _remoteDataSource.getAddressById(addressId);
      return right(dto.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserAddressEntity>> createAddress(
    int userId,
    AddressUpsertCommand request,
  ) async {
    try {
      final dto = await _remoteDataSource.createAddress(
        userId,
        _toDto(request),
      );
      return right(dto.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserAddressEntity>> updateAddress(
    int addressId,
    AddressUpsertCommand request,
  ) async {
    try {
      final dto = await _remoteDataSource.updateAddress(
        addressId,
        _toDto(request),
      );
      return right(dto.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAddress(int addressId) async {
    try {
      final success = await _remoteDataSource.deleteAddress(addressId);
      return right(success);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserAddressEntity>> setDefaultAddress(
    int addressId,
  ) async {
    try {
      final dto = await _remoteDataSource.setDefaultAddress(addressId);
      return right(dto.toEntity());
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  UserAddressRequestDto _toDto(AddressUpsertCommand command) =>
      UserAddressRequestDto(
        label: command.label,
        recipientName: command.recipientName,
        phoneNumber: command.phoneNumber,
        addressLine: command.addressLine,
        ward: command.ward,
        district: command.district,
        city: command.city,
        postalCode: command.postalCode,
        latitude: command.latitude,
        longitude: command.longitude,
        isDefault: command.isDefault,
      );
}
