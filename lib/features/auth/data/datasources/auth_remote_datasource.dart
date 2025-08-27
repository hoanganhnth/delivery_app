import 'package:fpdart/fpdart.dart';
import '../dtos/auth_response_dto.dart';
import '../dtos/login_request_dto.dart';
import '../dtos/register_request_dto.dart';
import '../dtos/refresh_token_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Exception, AuthResponseDto>> login(LoginRequestDto request);
  Future<Either<Exception, AuthResponseDto>> register(RegisterRequestDto request);
  Future<Either<Exception, RefreshTokenResponseDto>> refreshToken(String refreshToken);
}
