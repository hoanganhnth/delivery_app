import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
// import '../../../../core/logger/app_logger.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../dtos/login_request_dto.dart';
import '../dtos/register_request_dto.dart';
import '../dtos/refresh_token_response_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> login(LoginParams params) async {
    try {
      final request = LoginRequestDto(
        email: params.email,
        password: params.password,
        deviceId: params.deviceId,
        deviceName: params.deviceName,
        deviceType: params.deviceType,
        ipAddress: params.ipAddress,
      );
      final authResponse = await remoteDataSource.login(request);

      // AppLogger.i('Repository: Login successful');
      if (authResponse.isSuccess && authResponse.data != null) {
        return right(authResponse.data!.toEntity());
      } else {
        return left(ServerFailure(authResponse.message));
      }
    } on Exception catch (e) {
      // AppLogger.e('Repository: Login failed', e);
      return left(mapExceptionToFailure(e));
    } catch (e) {
      // AppLogger.e('Repository: Unexpected error during login', e);
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> register(String email, String password) async {
    try {
      final request = RegisterRequestDto(
        email: email,
        password: password,
        role: 'USER',
      );
      final authResponse = await remoteDataSource.register(request);

      if (authResponse.isSuccess && authResponse.data == true) {
        return right(true);
      } else {
        return left(ServerFailure(authResponse.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    try {
      final refreshResponse = await remoteDataSource.refreshToken(refreshToken);

      if (refreshResponse.isSuccess && refreshResponse.data != null) {
        return right(refreshResponse.data!.toEntity(refreshToken));
      } else {
        return left(ServerFailure(refreshResponse.message));
      }
    } on Exception catch (e) {
      // AppLogger.e('Repository: Token refresh failed', e);
      return left(mapExceptionToFailure(e));
    } catch (e) {
      // AppLogger.e('Repository: Unexpected error during token refresh', e);
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
