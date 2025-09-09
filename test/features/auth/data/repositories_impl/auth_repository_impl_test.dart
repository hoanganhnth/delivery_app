import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/refresh_token_response_dto.dart';
import 'package:delivery_app/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'auth_repository_impl_test.mocks.dart';

// Generate mocks
@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;



  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('AuthRepositoryImpl', () {
    group('login', () {
      const tEmail = 'test@example.com';
      const tPassword = 'password123';
      const tDeviceId = 'device123';
      const tDeviceName = 'iPhone 15';
      const tDeviceType = 'iOS';
      const tIpAddress = '192.168.1.1';

      final tLoginParams = LoginParams(
        email: tEmail,
        password: tPassword,
        deviceId: tDeviceId,
        deviceName: tDeviceName,
        deviceType: tDeviceType,
        ipAddress: tIpAddress,
      );



      const tAccessToken = 'access_token_123';
      const tRefreshToken = 'refresh_token_123';

      final tUserDto = UserDto(
        id: 1,
        email: tEmail,
        name: 'Test User',
        createdAt: DateTime.now(),
      );

      final tAuthDataDto = AuthDataDto(
        accessToken: tAccessToken,
        refreshToken: tRefreshToken,
        user: tUserDto,
      );

      final tAuthResponseDto = BaseResponseDto<AuthDataDto>(
        status: 1,
        message: 'Login successful',
        data: tAuthDataDto,
      );

      final tAuthEntity = AuthEntity(
        accessToken: tAccessToken,
        refreshToken: tRefreshToken,
      );

      test('should return AuthEntity when login is successful', () async {
        // arrange
        when(mockRemoteDataSource.login(any))
            .thenAnswer((_) async => tAuthResponseDto);

        // act
        final result = await repository.login(tLoginParams);

        // assert
        expect(result, equals(right(tAuthEntity)));
        verify(mockRemoteDataSource.login(argThat(isA<LoginRequestDto>()
            .having((r) => r.email, 'email', tEmail)
            .having((r) => r.password, 'password', tPassword))));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('should return ServerFailure when response status is not success', () async {
        // arrange
        final tFailureResponse = BaseResponseDto<AuthDataDto>(
          status: 0,
          message: 'Invalid credentials',
          data: null,
        );

        when(mockRemoteDataSource.login(any))
            .thenAnswer((_) async => tFailureResponse);

        // act
        final result = await repository.login(tLoginParams);

        // assert
        expect(result, equals(left(const ServerFailure('Invalid credentials'))));
        verify(mockRemoteDataSource.login(any));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('should return ServerFailure when response data is null', () async {
        // arrange
        final tNullDataResponse = BaseResponseDto<AuthDataDto>(
          status: 1,
          message: 'Success',
          data: null,
        );

        when(mockRemoteDataSource.login(any))
            .thenAnswer((_) async => tNullDataResponse);

        // act
        final result = await repository.login(tLoginParams);

        // assert
        expect(result, equals(left(const ServerFailure('Success'))));
        verify(mockRemoteDataSource.login(any));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('should return NetworkFailure when DioException occurs', () async {
        // arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/login'),
          type: DioExceptionType.connectionTimeout,
        );

        when(mockRemoteDataSource.login(any))
            .thenThrow(dioException);

        // act
        final result = await repository.login(tLoginParams);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure, isA<NetworkFailure>()),
          (success) => fail('Should return failure'),
        );
        verify(mockRemoteDataSource.login(any));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('should return ServerFailure when unexpected exception occurs', () async {
        // arrange
        when(mockRemoteDataSource.login(any))
            .thenThrow(Exception('Unexpected error'));

        // act
        final result = await repository.login(tLoginParams);

        // assert
        expect(result, equals(left(const ServerFailure('Unexpected error occurred'))));
        verify(mockRemoteDataSource.login(any));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });

    group('register', () {
      const tEmail = 'test@example.com';
      const tPassword = 'password123';



      // final tAuthDataDto = AuthDataDto(
      //   accessToken: 'access_token',
      //   refreshToken: 'refresh_token',
      //   user: UserDto(
      //     id: 1,
      //     email: tEmail,
      //     name: 'Test User',
      //   ),
      // );

      // final tSuccessResponse = BaseResponseDto<AuthDataDto>(
      //   status: 1,
      //   message: 'Registration successful',
      //   data: tAuthDataDto,
      // );
      final tSuccessResponse = BaseResponseDto<bool>(
        status: 1,
        message: 'Registration successful',
        data: true,
      );

      test('should return true when registration is successful', () async {
        // arrange
        when(mockRemoteDataSource.register(any))
            .thenAnswer((_) async => tSuccessResponse);

        // act
        final result = await repository.register(tEmail, tPassword);

        // assert
        expect(result, equals(right(true)));
        verify(mockRemoteDataSource.register(any));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('should return ServerFailure when registration fails', () async {
        // arrange
        // final tFailureResponse = BaseResponseDto<AuthDataDto>(
        //   status: 0,
        //   message: 'Email already exists',
        //   data: null,
        // );
        final tFailureResponse = BaseResponseDto<bool>(
          status: 0,
          message: 'Email already exists',
          data: false,
        );

        when(mockRemoteDataSource.register(any))
            .thenAnswer((_) async => tFailureResponse);

        // act
        final result = await repository.register(tEmail, tPassword);

        // assert
        expect(result, equals(left(const ServerFailure('Email already exists'))));
        verify(mockRemoteDataSource.register(any));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });

    group('refreshToken', () {
      const tRefreshToken = 'refresh_token_123';
      const tNewAccessToken = 'new_access_token_123';

      final tRefreshTokenDataDto = RefreshTokenDataDto(
        accessToken: tNewAccessToken,
      );

      final tSuccessResponse = BaseResponseDto<RefreshTokenDataDto>(
        status: 1,
        message: 'Token refreshed successfully',
        data: tRefreshTokenDataDto,
      );

      test('should return new access token when refresh is successful', () async {
        // arrange
        when(mockRemoteDataSource.refreshToken(any))
            .thenAnswer((_) async => tSuccessResponse);

        // act
        final result = await repository.refreshToken(tRefreshToken);

        // assert
        expect(result, equals(right(tNewAccessToken)));
        verify(mockRemoteDataSource.refreshToken(tRefreshToken));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test('should return ServerFailure when refresh token is invalid', () async {
        // arrange
        final tFailureResponse = BaseResponseDto<RefreshTokenDataDto>(
          status: 0,
          message: 'Invalid refresh token',
          data: null,
        );

        when(mockRemoteDataSource.refreshToken(any))
            .thenAnswer((_) async => tFailureResponse);

        // act
        final result = await repository.refreshToken(tRefreshToken);

        // assert
        expect(result, equals(left(const ServerFailure('Invalid refresh token'))));
        verify(mockRemoteDataSource.refreshToken(tRefreshToken));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });
  });
}
