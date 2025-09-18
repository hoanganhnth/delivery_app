import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_address_entity.dart';
import '../../data/dtos/user_address_request_dto.dart';

/// Repository interface for user address management
abstract class UserAddressRepository {
  /// Lấy danh sách địa chỉ của người dùng
  Future<Either<Failure, List<UserAddressEntity>>> getUserAddresses(int userId);

  /// Lấy chi tiết địa chỉ theo ID
  Future<Either<Failure, UserAddressEntity>> getAddressById(int addressId);

  /// Tạo địa chỉ mới
  Future<Either<Failure, UserAddressEntity>> createAddress(
    int userId,
    UserAddressRequestDto request,
  );

  /// Cập nhật địa chỉ
  Future<Either<Failure, UserAddressEntity>> updateAddress(
    int addressId,
    UserAddressRequestDto request,
  );

  /// Xóa địa chỉ
  Future<Either<Failure, bool>> deleteAddress(int addressId);

  /// Đặt làm địa chỉ mặc định
  Future<Either<Failure, UserAddressEntity>> setDefaultAddress(int addressId);
}
