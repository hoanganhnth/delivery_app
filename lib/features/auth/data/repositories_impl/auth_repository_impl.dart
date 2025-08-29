import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../dtos/login_request_dto.dart';
import '../dtos/register_request_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final request = LoginRequestDto(email: email, password: password);
      final result = await remoteDataSource.login(request);

      return result.fold(
        (exception) {
          AppLogger.e('Repository: Login failed', exception);
          return left(mapExceptionToFailure(exception));
        },
        (authResponse) {
          AppLogger.i('Repository: Login successful');
          if (authResponse.isSuccess && authResponse.data != null) {
            return right(authResponse.data!.toEntity());
          } else {
            return left(ServerFailure(authResponse.message));
          }
        },
      );
    } catch (e) {
      AppLogger.e('Repository: Unexpected error during login', e);
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password) async {
    try {
      final request = RegisterRequestDto(email: email, password: password);
      final result = await remoteDataSource.register(request);

      return result.fold(
        (exception) {
          AppLogger.e('Repository: Registration failed', exception);
          return left(mapExceptionToFailure(exception));
        },
        (authResponse) {
          AppLogger.i('Repository: Registration successful');
          if (authResponse.isSuccess && authResponse.data != null) {
            return right(authResponse.data!.toEntity());
          } else {
            return left(ServerFailure(authResponse.message));
          }
        },
      );
    } catch (e) {
      AppLogger.e('Repository: Unexpected error during registration', e);
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> refreshToken(String refreshToken) async {
    try {
      final result = await remoteDataSource.refreshToken(refreshToken);

      return result.fold(
        (exception) {
          AppLogger.e('Repository: Token refresh failed', exception);
          return left(mapExceptionToFailure(exception));
        },
        (refreshResponse) {
          AppLogger.i('Repository: Token refresh successful');
          if (refreshResponse.isSuccess && refreshResponse.data != null) {
            return right(refreshResponse.data!.accessToken);
          } else {
            return left(ServerFailure(refreshResponse.message));
          }
        },
      );
    } catch (e) {
      AppLogger.e('Repository: Unexpected error during token refresh', e);
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
