import 'dart:io';
import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/data/dtos/response_handler.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/logger/app_logger.dart';
import '../dtos/user_profile_dto.dart';
import '../dtos/update_profile_request_dto.dart';
import 'profile_remote_datasource.dart';

part 'profile_remote_datasource_impl.g.dart';

@RestApi()
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String baseUrl}) = _ProfileApiService;

  @GET(ApiConstants.getProfile)
  Future<BaseResponseDto<UserProfileDto>> getUserProfile();

  @PUT('/user/profile')
  Future<BaseResponseDto<UserProfileDto>> updateUserProfile(
    @Body() UpdateProfileRequestDto request,
  );

  @MultiPart()
  @POST('/user/avatar')
  Future<BaseResponseDto<String>> uploadAvatar(
    @Part(name: 'avatar') File avatar,
  );

}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiService _apiService;

  ProfileRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<UserProfileDto>> getUserProfile() async {
    try {
      AppLogger.d('Getting user profile');
      final response = await _apiService.getUserProfile();
      AppLogger.i('Successfully retrieved user profile');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to get user profile', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error getting user profile', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<UserProfileDto>> updateUserProfile(
    UpdateProfileRequestDto request,
  ) async {
    try {
      AppLogger.d('Updating user profile');
      final response = await _apiService.updateUserProfile(request);
      AppLogger.i('Successfully updated user profile');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to update user profile', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error updating user profile', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<String>> uploadAvatar(
    String imagePath,
  ) async {
    try {
      AppLogger.d('Uploading avatar from path: $imagePath');
      final file = File(imagePath);
      
      if (!await file.exists()) {
        throw Exception('Image file not found at path: $imagePath');
      }

      final response = await _apiService.uploadAvatar(file);
      AppLogger.i('Successfully uploaded avatar');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to upload avatar', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error uploading avatar', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
