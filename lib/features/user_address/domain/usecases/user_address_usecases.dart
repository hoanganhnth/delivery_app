import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_address_entity.dart';
import '../repositories/user_address_repository.dart';
import '../../data/dtos/user_address_request_dto.dart';

/// UseCase để lấy danh sách địa chỉ của người dùng
class GetUserAddressesUseCase {
  final UserAddressRepository repository;

  GetUserAddressesUseCase(this.repository);

  Future<Either<Failure, List<UserAddressEntity>>> call(int userId) async {
    if (userId <= 0) {
      return left(const ValidationFailure('User ID không hợp lệ'));
    }
    return await repository.getUserAddresses(userId);
  }
}

/// UseCase để lấy chi tiết địa chỉ theo ID
class GetAddressByIdUseCase {
  final UserAddressRepository repository;

  GetAddressByIdUseCase(this.repository);

  Future<Either<Failure, UserAddressEntity>> call(int addressId) async {
    if (addressId <= 0) {
      return left(const ValidationFailure('Address ID không hợp lệ'));
    }
    return await repository.getAddressById(addressId);
  }
}

/// UseCase để tạo địa chỉ mới
class CreateAddressUseCase {
  final UserAddressRepository repository;

  CreateAddressUseCase(this.repository);

  Future<Either<Failure, UserAddressEntity>> call(
    int userId,
    UserAddressRequestDto request,
  ) async {
    // Validate userId
    if (userId <= 0) {
      return left(const ValidationFailure('User ID không hợp lệ'));
    }

    // Validate request data
    if (request.label.trim().isEmpty) {
      return left(const ValidationFailure('Nhãn địa chỉ không được để trống'));
    }

    if (request.addressLine.trim().isEmpty) {
      return left(const ValidationFailure('Địa chỉ không được để trống'));
    }

    if (request.ward.trim().isEmpty) {
      return left(const ValidationFailure('Phường/Xã không được để trống'));
    }

    if (request.district.trim().isEmpty) {
      return left(const ValidationFailure('Quận/Huyện không được để trống'));
    }

    if (request.city.trim().isEmpty) {
      return left(const ValidationFailure('Tỉnh/Thành phố không được để trống'));
    }

    return await repository.createAddress(userId, request);
  }
}

/// UseCase để cập nhật địa chỉ
class UpdateAddressUseCase {
  final UserAddressRepository repository;

  UpdateAddressUseCase(this.repository);

  Future<Either<Failure, UserAddressEntity>> call(
    int addressId,
    UserAddressRequestDto request,
  ) async {
    // Validate addressId
    if (addressId <= 0) {
      return left(const ValidationFailure('Address ID không hợp lệ'));
    }

    // Validate request data
    if (request.label.trim().isEmpty) {
      return left(const ValidationFailure('Nhãn địa chỉ không được để trống'));
    }

    if (request.addressLine.trim().isEmpty) {
      return left(const ValidationFailure('Địa chỉ không được để trống'));
    }

    if (request.ward.trim().isEmpty) {
      return left(const ValidationFailure('Phường/Xã không được để trống'));
    }

    if (request.district.trim().isEmpty) {
      return left(const ValidationFailure('Quận/Huyện không được để trống'));
    }

    if (request.city.trim().isEmpty) {
      return left(const ValidationFailure('Tỉnh/Thành phố không được để trống'));
    }

    return await repository.updateAddress(addressId, request);
  }
}

/// UseCase để xóa địa chỉ
class DeleteAddressUseCase {
  final UserAddressRepository repository;

  DeleteAddressUseCase(this.repository);

  Future<Either<Failure, bool>> call(int addressId) async {
    if (addressId <= 0) {
      return left(const ValidationFailure('Address ID không hợp lệ'));
    }
    return await repository.deleteAddress(addressId);
  }
}

/// UseCase để đặt làm địa chỉ mặc định
class SetDefaultAddressUseCase {
  final UserAddressRepository repository;

  SetDefaultAddressUseCase(this.repository);

  Future<Either<Failure, UserAddressEntity>> call(int addressId) async {
    if (addressId <= 0) {
      return left(const ValidationFailure('Address ID không hợp lệ'));
    }
    return await repository.setDefaultAddress(addressId);
  }
}
