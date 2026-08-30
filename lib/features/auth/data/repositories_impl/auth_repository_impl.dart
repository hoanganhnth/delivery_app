import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/entities/registration_result.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/social_login_usecase.dart';
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
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> socialLogin(
    SocialLoginParams params,
  ) async {
    try {
      final requestJson = {
        'provider': params.provider,
        'token': params.token,
        'role': params.role,
        'deviceId': params.deviceId,
        'deviceName': params.deviceName,
        'deviceType': params.deviceType,
        'ipAddress': params.ipAddress,
      };
      final authResponse = await remoteDataSource.socialLogin(requestJson);

      if (authResponse.isSuccess && authResponse.data != null) {
        return right(authResponse.data!.toEntity());
      } else {
        return left(ServerFailure(authResponse.message));
      }
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RegistrationResult>> register(
    String? name,
    String email,
    String password,
  ) async {
    try {
      final request = RegisterRequestDto(
        email: email,
        password: password,
        role: 'USER',
      );
      final authResponse = await remoteDataSource.register(request);

      if (!authResponse.isSuccess || authResponse.data == null) {
        return left(ServerFailure(authResponse.message));
      }

      final authRegistration = authResponse.data!;
      try {
        final profileResponse = await remoteDataSource.registerUserProfile(
          UserRegistrationRequestDto(
            provisioningToken: authRegistration.provisioningToken,
            fullName: name,
          ),
        );
        if (profileResponse.isSuccess && profileResponse.data != null) {
          return right(
            _registrationResult(authRegistration, profileCreated: true),
          );
        }
        return right(
          await _recoverRegistration(authRegistration, profileResponse.message),
        );
      } on Exception catch (_) {
        return right(
          await _recoverRegistration(
            authRegistration,
            'Could not confirm profile creation. Please submit registration again.',
          ),
        );
      }
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  Future<RegistrationResult> _recoverRegistration(
    AuthRegistrationDataDto registration,
    String fallbackMessage,
  ) async {
    final handle = registration.registrationHandle;
    if (handle == null || handle.isEmpty) {
      return _registrationResult(
        registration,
        profileCreated: false,
        recoveryMessage: fallbackMessage,
      );
    }

    try {
      final statusResponse = await remoteDataSource.registrationStatus(handle);
      final status = statusResponse.data;
      if (statusResponse.isSuccess && status != null) {
        // Lifecycle is Auth-owned and can be BLOCKED before a User profile is
        // created. Only Auth's explicit linkage fact can confirm completion.
        final profileCreated = status.profileLinked == true;
        return RegistrationResult(
          principalId: status.principalId,
          profileCreated: profileCreated,
          registrationHandle: handle,
          expiresAt: status.expiresAt ?? registration.expiresAt,
          lifecycleStatus: status.status,
          recoveryMessage: profileCreated ? null : fallbackMessage,
        );
      }
    } on Exception {
      // The Auth status endpoint is a best-effort recovery probe. The normal
      // retry remains idempotent even when the probe cannot be reached.
    }

    return _registrationResult(
      registration,
      profileCreated: false,
      recoveryMessage: fallbackMessage,
    );
  }

  RegistrationResult _registrationResult(
    AuthRegistrationDataDto registration, {
    required bool profileCreated,
    String? recoveryMessage,
  }) => RegistrationResult(
    principalId: registration.principalId ?? registration.authId,
    profileCreated: profileCreated,
    registrationHandle: registration.registrationHandle,
    expiresAt: registration.expiresAt,
    lifecycleStatus: registration.lifecycleStatus,
    recoveryMessage: recoveryMessage,
  );

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    try {
      final refreshResponse = await remoteDataSource.refreshToken(refreshToken);

      if (refreshResponse.isSuccess && refreshResponse.data != null) {
        return right(refreshResponse.data!.toEntity());
      } else {
        return left(ServerFailure(refreshResponse.message));
      }
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout(String refreshToken) async {
    try {
      await remoteDataSource.logout(refreshToken);
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset(String email) async {
    try {
      await remoteDataSource.requestPasswordReset(email);
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
    String token,
    String newPassword,
  ) async {
    try {
      await remoteDataSource.resetPassword(token, newPassword);
      return right(null);
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
