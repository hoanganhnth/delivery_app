import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/error/exceptions.dart';
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
  Future<Either<Exception, AuthResponseDto>> login(LoginRequestDto request) async {
    try {
      // AppLogger.d('Attempting login for email: ${request.email}');
      final response = await _apiService.login(request);
      // AppLogger.i('Login successful for email: ${request.email}');
      return right(response);
    } on DioException catch (e) {
      // AppLogger.e('Login failed for email: ${request.email}', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error during login', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<bool>>> register(RegisterRequestDto request) async {
    try {
      // AppLogger.d('Attempting registration for email: ${request.email}');
      final response = await _apiService.register(request);
      AppLogger.i('Registration successful for email: ${request.email}');
      return right(response);
    } on DioException catch (e) {
      // AppLogger.e('Registration failed for email: ${request.email}', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error during registration', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, RefreshTokenResponseDto>> refreshToken(String refreshToken) async {
    try {
      // AppLogger.d('Attempting token refresh');
      final response = await _apiService.refreshToken({'refresh_token': refreshToken});
      // AppLogger.i('Token refresh successful');
      return right(response);
    } on DioException catch (e) {
      // AppLogger.e('Token refresh failed', e);
      return left(_handleDioException(e));
    } catch (e) {
      AppLogger.e('Unexpected error during token refresh', e);
      return left(ServerException('Unexpected error: ${e.toString()}'));
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return ServerException('Bad request: ${e.response?.data?['message'] ?? 'Invalid request'}');
      case 401:
        return UnauthorizedException('Unauthorized: ${e.response?.data?['message'] ?? 'Invalid credentials'}');
      case 403:
        return UnauthorizedException('Forbidden: ${e.response?.data?['message'] ?? 'Access denied'}');
      case 404:
        return ServerException('Not found: ${e.response?.data?['message'] ?? 'Resource not found'}');
      case 422:
        return ServerException('Validation error: ${e.response?.data?['message'] ?? 'Invalid data'}');
      case 500:
        return ServerException('Internal server error: ${e.response?.data?['message'] ?? 'Server error'}');
      default:
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          return ServerException('Connection timeout: Please check your internet connection');
        }
        if (e.type == DioExceptionType.connectionError) {
          return ServerException('Connection error: Unable to connect to server');
        }
        return ServerException('Network error: ${e.message ?? 'Unknown error'}');
    }
  }
}
