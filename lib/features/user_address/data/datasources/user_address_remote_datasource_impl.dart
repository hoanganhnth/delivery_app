import 'package:dio/dio.dart';
import '../dtos/user_address_request_dto.dart';
import '../dtos/user_address_response_dto.dart';
import 'user_address_api_service.dart';
import 'user_address_remote_datasource.dart';
import '../../../../core/data/dtos/response_handler.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/logger/app_logger.dart';

class UserAddressRemoteDataSourceImpl implements UserAddressRemoteDataSource {
  final UserAddressApiService _apiService;

  UserAddressRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<UserAddressResponseDto>> getUserAddresses(int userId) async {
    try {
      AppLogger.d('Getting user addresses for user: $userId');
      final response = await _apiService.getUserAddresses(userId);
      AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} addresses');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get user addresses for user: $userId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting user addresses', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserAddressResponseDto> getAddressById(int addressId) async {
    try {
      AppLogger.d('Getting address with id: $addressId');
      final response = await _apiService.getAddressById(addressId);
      AppLogger.i('Successfully retrieved address: ${response.data?.label}');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to get address with id: $addressId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting address', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserAddressResponseDto> createAddress(
    int userId,
    UserAddressRequestDto request,
  ) async {
    try {
      AppLogger.d('Creating address for user: $userId');
      final response = await _apiService.createAddress(userId, request);
      AppLogger.i('Successfully created address');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to create address for user: $userId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error creating address', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserAddressResponseDto> updateAddress(
    int addressId,
    UserAddressRequestDto request,
  ) async {
    try {
      AppLogger.d('Updating address with id: $addressId');
      final response = await _apiService.updateAddress(addressId, request);
      AppLogger.i('Successfully updated address');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to update address with id: $addressId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error updating address', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<bool> deleteAddress(int addressId) async {
    try {
      AppLogger.d('Deleting address with id: $addressId');
      final response = await _apiService.deleteAddress(addressId);
      AppLogger.i('Successfully deleted address');
      
      return response.isSuccess;
    } on DioException catch (e) {
      AppLogger.e('Failed to delete address with id: $addressId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error deleting address', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserAddressResponseDto> setDefaultAddress(int addressId) async {
    try {
      AppLogger.d('Setting default address with id: $addressId');
      final response = await _apiService.setDefaultAddress(addressId);
      AppLogger.i('Successfully set default address');
      
      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to set default address with id: $addressId', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error setting default address', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
