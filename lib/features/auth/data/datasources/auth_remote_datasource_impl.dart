import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/core/error/dio_exception_handler.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../dtos/auth_response_dto.dart';
import '../dtos/login_request_dto.dart';
import '../dtos/register_request_dto.dart';
import '../dtos/refresh_token_response_dto.dart';
import '../dtos/social_login_request_dto.dart';
import 'auth_remote_datasource.dart';

part 'auth_remote_datasource_impl.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<BaseResponseDto<AuthDataDto>> login(@Body() LoginRequestDto request);

  @POST(ApiConstants.socialLogin)
  Future<BaseResponseDto<AuthDataDto>> socialLogin(
    @Body() SocialLoginRequestDto request,
  );

  @POST(ApiConstants.register)
  Future<BaseResponseDto<AuthRegistrationDataDto>> register(
    @Body() RegisterRequestDto request,
  );

  @POST(ApiConstants.userRegistration)
  Future<BaseResponseDto<UserRegistrationDataDto>> registerUserProfile(
    @Body() UserRegistrationRequestDto request,
  );

  @POST(ApiConstants.refreshToken)
  Future<BaseResponseDto<RefreshTokenDataDto>> refreshToken(
    @Body() Map<String, String> body,
  );

  @POST(ApiConstants.logout)
  Future<BaseResponseDto<void>> logout(@Body() Map<String, String> body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    try {
      AppLogger.d('Attempting login');
      final response = await _apiService.login(request);
      AppLogger.i('Login successful');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Login failed');
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error during login', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponseDto> socialLogin(Map<String, dynamic> requestJson) async {
    try {
      AppLogger.d('Attempting social login via: ${requestJson["provider"]}');
      final request = SocialLoginRequestDto.fromJson(requestJson);
      final response = await _apiService.socialLogin(request);
      AppLogger.i(
        'Social login successful for provider: ${requestJson["provider"]}',
      );
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to social login', e);
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error during social login', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<AuthRegistrationDataDto>> register(
    RegisterRequestDto request,
  ) async {
    try {
      AppLogger.d('Attempting registration');
      final response = await _apiService.register(request);
      AppLogger.i('Registration successful');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Registration failed');
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error during registration', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<UserRegistrationDataDto>> registerUserProfile(
    UserRegistrationRequestDto request,
  ) async {
    try {
      AppLogger.d('Creating user profile from auth registration handoff');
      final response = await _apiService.registerUserProfile(request);
      AppLogger.i('User profile registration successful');
      return response;
    } on DioException catch (e) {
      AppLogger.e('User profile registration failed');
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected user profile registration error', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<RefreshTokenResponseDto> refreshToken(String refreshToken) async {
    try {
      AppLogger.d('Attempting token refresh');
      final response = await _apiService.refreshToken({
        'refreshToken': refreshToken,
      });
      AppLogger.i('Token refresh successful');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to refresh token');
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (_) {
      AppLogger.e('Unexpected error during token refresh');
      throw Exception('Unexpected token refresh error');
    }
  }

  @override
  Future<void> logout(String refreshToken) async {
    try {
      final response = await _apiService.logout({'refreshToken': refreshToken});
      if (!response.isSuccess) {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      AppLogger.e('Failed to revoke auth session');
      throw DioExceptionHandler.mapDioExceptionToException(e);
    } catch (_) {
      AppLogger.e('Unexpected auth session revocation error');
      throw Exception('Unexpected auth session revocation error');
    }
  }
}
