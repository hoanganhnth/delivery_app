import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/core/data/dtos/response_handler.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/logger/app_logger.dart';
import '../dtos/auth_response_dto.dart';
import '../dtos/login_request_dto.dart';
import '../dtos/register_request_dto.dart';
import '../dtos/refresh_token_response_dto.dart';
import 'auth_remote_datasource.dart';

part 'auth_remote_datasource_impl.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<BaseResponseDto<AuthDataDto>> login(@Body() LoginRequestDto request);

  @POST(ApiConstants.register)
  Future<BaseResponseDto<bool>> register(@Body() RegisterRequestDto request);

  @POST(ApiConstants.refreshToken)
  Future<BaseResponseDto<RefreshTokenDataDto>> refreshToken(@Body() Map<String, String> body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    try {
      AppLogger.d('Attempting login for email: ${request.email}');
      final response = await _apiService.login(request);
      AppLogger.i('Login successful for email: ${request.email}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to login for email: ${request.email}', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error during login', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<bool>> register(RegisterRequestDto request) async {
    try {
      AppLogger.d('Attempting registration for email: ${request.email}');
      final response = await _apiService.register(request);
      AppLogger.i('Registration successful for email: ${request.email}');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to register for email: ${request.email}', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error during registration', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<RefreshTokenResponseDto> refreshToken(String refreshToken) async {
    try {
      AppLogger.d('Attempting token refresh');
      final response = await _apiService.refreshToken({'refreshToken': refreshToken});
      AppLogger.i('Token refresh successful');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to refresh token', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error during token refresh', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
