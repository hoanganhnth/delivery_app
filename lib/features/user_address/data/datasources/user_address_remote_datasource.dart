import '../dtos/user_address_request_dto.dart';
import '../dtos/user_address_response_dto.dart';

/// Remote data source interface for user addresses
abstract class UserAddressRemoteDataSource {
  /// Lấy danh sách địa chỉ của người dùng
  Future<List<UserAddressResponseDto>> getUserAddresses(int userId);

  /// Lấy chi tiết địa chỉ theo ID
  Future<UserAddressResponseDto> getAddressById(int addressId);

  /// Tạo địa chỉ mới
  Future<UserAddressResponseDto> createAddress(
    int userId,
    UserAddressRequestDto request,
  );

  /// Cập nhật địa chỉ
  Future<UserAddressResponseDto> updateAddress(
    int addressId,
    UserAddressRequestDto request,
  );

  /// Xóa địa chỉ
  Future<bool> deleteAddress(int addressId);

  /// Đặt làm địa chỉ mặc định
  Future<UserAddressResponseDto> setDefaultAddress(int addressId);
}
