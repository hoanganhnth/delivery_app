import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/retrofit.dart';
// import '../../../../core/constants/api_constants.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../../../../core/logger/app_logger.dart';
import '../dtos/user_profile_dto.dart';
import '../dtos/update_profile_request_dto.dart';
import 'profile_remote_datasource.dart';

part 'profile_remote_datasource_impl.g.dart';

@RestApi()
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String baseUrl}) = _ProfileApiService;

  @GET('/user/profile')
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
  final ProfileApiService apiService;

  ProfileRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<Exception, BaseResponseDto<UserProfileDto>>> getUserProfile() async {
    try {
      AppLogger.i('ProfileRemoteDataSource: Getting user profile');
      final response = await apiService.getUserProfile();
      AppLogger.i('ProfileRemoteDataSource: Get profile successful');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('ProfileRemoteDataSource: DioException - ${e.message}');
      return left(e);
    } catch (e) {
      AppLogger.e('ProfileRemoteDataSource: Unexpected error - $e');
      return left(Exception('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<UserProfileDto>>> updateUserProfile(
    UpdateProfileRequestDto request,
  ) async {
    try {
      AppLogger.i('ProfileRemoteDataSource: Updating user profile');
      final response = await apiService.updateUserProfile(request);
      AppLogger.i('ProfileRemoteDataSource: Update profile successful');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('ProfileRemoteDataSource: DioException - ${e.message}');
      return left(e);
    } catch (e) {
      AppLogger.e('ProfileRemoteDataSource: Unexpected error - $e');
      return left(Exception('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<String>>> uploadAvatar(
    String imagePath,
  ) async {
    try {
      AppLogger.i('ProfileRemoteDataSource: Uploading avatar');
      final file = File(imagePath);
      
      if (!await file.exists()) {
        return left(Exception('Image file not found'));
      }

      final response = await apiService.uploadAvatar(file);
      AppLogger.i('ProfileRemoteDataSource: Upload avatar successful');
      return right(response);
    } on DioException catch (e) {
      AppLogger.e('ProfileRemoteDataSource: DioException - ${e.message}');
      return left(e);
    } catch (e) {
      AppLogger.e('ProfileRemoteDataSource: Unexpected error - $e');
      return left(Exception('Unexpected error occurred'));
    }
  }
  


}
