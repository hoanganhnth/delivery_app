import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import '../dtos/auth_response_dto.dart';
import '../dtos/login_request_dto.dart';
import '../dtos/register_request_dto.dart';
import '../dtos/refresh_token_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseDto> login(LoginRequestDto request);
  Future<BaseResponseDto<bool>> register(RegisterRequestDto request);
  Future<RefreshTokenResponseDto> refreshToken(String refreshToken);
}
