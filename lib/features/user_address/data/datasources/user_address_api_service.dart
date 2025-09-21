import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/user_address_request_dto.dart';
import '../dtos/user_address_response_dto.dart';

part 'user_address_api_service.g.dart';

@RestApi()
abstract class UserAddressApiService {
  factory UserAddressApiService(Dio dio) = _UserAddressApiService;

  /// Lấy danh sách địa chỉ của người dùng
  @GET('/addresses/users/{userId}/addresses')
  Future<BaseResponseDto<List<UserAddressResponseDto>>> getUserAddresses(
    @Path('userId') int userId,
  );

  /// Lấy chi tiết địa chỉ theo ID
  @GET('/addresses/{id}')
  Future<BaseResponseDto<UserAddressResponseDto>> getAddressById(
    @Path('id') int addressId,
  );

  /// Tạo địa chỉ mới
  @POST('/addresses/users/{userId}/addresses')
  Future<BaseResponseDto<UserAddressResponseDto>> createAddress(
    @Path('userId') int userId,
    @Body() UserAddressRequestDto request,
  );

  /// Cập nhật địa chỉ
  @PUT('/addresses/{id}')
  Future<BaseResponseDto<UserAddressResponseDto>> updateAddress(
    @Path('id') int addressId,
    @Body() UserAddressRequestDto request,
  );

  /// Xóa địa chỉ
  @DELETE('/addresses/{id}')
  Future<BaseResponseDto<void>> deleteAddress(@Path('id') int addressId);

  /// Đặt làm địa chỉ mặc định
  @PATCH('/addresses/{id}/default')
  Future<BaseResponseDto<UserAddressResponseDto>> setDefaultAddress(
    @Path('id') int addressId,
  );
}
