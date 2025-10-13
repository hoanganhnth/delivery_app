import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/refresh_token_response_dto.dart';
import 'package:delivery_app/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'auth_repository_impl_test.mocks.dart';

// Generate mocks for repository layer tests
@GenerateMocks([AuthRemoteDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('AuthRepositoryImpl - Repository Layer Tests', () {
    group('Login Operation', () {
      final testLoginParams = LoginParams(
        email: 'test@example.com',
        password: 'password123',
        deviceId: 'device-123',
        deviceName: 'Test Device',
        deviceType: 'iOS',
        ipAddress: '192.168.1.100',
      );

      final testLoginRequest = LoginRequestDto(
        email: testLoginParams.email,
        password: testLoginParams.password,
        deviceId: testLoginParams.deviceId,
        deviceName: testLoginParams.deviceName,
        deviceType: testLoginParams.deviceType,
        ipAddress: testLoginParams.ipAddress,
      );

      test('should return AuthEntity when login is successful', () async {
        // Arrange
        final successResponse = AuthResponseDto(
          status: 1,
          message: 'Login successful',
          data: const AuthDataDto(
            accessToken: 'access_token_123',
            refreshToken: 'refresh_token_123',
            user: UserDto(
              id: 1,
              email: 'test@example.com',
              name: 'Test User',
            ),
          ),
        );

        when(mockRemoteDataSource.login(any))
            .thenAnswer((_) async => successResponse);

        // Act
        final result = await repository.login(testLoginParams);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (authEntity) {
            expect(authEntity.accessToken, 'access_token_123');
            expect(authEntity.refreshToken, 'refresh_token_123');
          },
        );

        verify(mockRemoteDataSource.login(testLoginRequest)).called(1);
      });

      test('should return ServerFailure when login response is unsuccessful', () async {
        // Arrange
        final errorResponse = AuthResponseDto(
          status: 0,
          message: 'Invalid credentials',
          data: null,
        );

        when(mockRemoteDataSource.login(any))
            .thenAnswer((_) async => errorResponse);

        // Act
        final result = await repository.login(testLoginParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Invalid credentials');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRemoteDataSource.login(testLoginRequest)).called(1);
      });

      test('should return ServerFailure when datasource throws DioException', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/login'),
          response: Response(
            requestOptions: RequestOptions(path: '/login'),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
        );

        when(mockRemoteDataSource.login(any))
            .thenThrow(dioException);

        // Act
        final result = await repository.login(testLoginParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRemoteDataSource.login(testLoginRequest)).called(1);
      });

      test('should return ServerFailure when datasource throws generic exception', () async {
        // Arrange
        when(mockRemoteDataSource.login(any))
            .thenThrow(Exception('Unexpected error'));

        // Act
        final result = await repository.login(testLoginParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRemoteDataSource.login(testLoginRequest)).called(1);
      });
    });

    group('Register Operation', () {
      const testEmail = 'newuser@example.com';
      const testPassword = 'securePassword123';

      // final testRegisterRequest = RegisterRequestDto(
      //   email: testEmail,
      //   password: testPassword,
      //   name: 'New User',
      // );

      test('should return true when registration is successful', () async {
        // Arrange
        final successResponse = BaseResponseDto<bool>(
          status: 1,
          message: 'Registration successful',
          data: true,
        );

        when(mockRemoteDataSource.register(any))
            .thenAnswer((_) async => successResponse);

        // Act
        final result = await repository.register(testEmail, testPassword);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) => expect(success, true),
        );

        verify(mockRemoteDataSource.register(any)).called(1);
      });

      test('should return ServerFailure when registration fails', () async {
        // Arrange
        final errorResponse = BaseResponseDto<bool>(
          status: 0,
          message: 'Email already exists',
          data: false,
        );

        when(mockRemoteDataSource.register(any))
            .thenAnswer((_) async => errorResponse);

        // Act
        final result = await repository.register(testEmail, testPassword);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Email already exists');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRemoteDataSource.register(any)).called(1);
      });
    });

    group('Refresh Token Operation', () {
      const testRefreshToken = 'valid_refresh_token_123';

      test('should return AuthEntity when refresh is successful', () async {
        // Arrange
        final successResponse = RefreshTokenResponseDto(
          status: 1,
          message: 'Token refreshed successfully',
          data: const RefreshTokenDataDto(
            accessToken: 'new_access_token_456',
          ),
        );

        when(mockRemoteDataSource.refreshToken(any))
            .thenAnswer((_) async => successResponse);

        // Act
        final result = await repository.refreshToken(testRefreshToken);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (authEntity) {
            expect(authEntity.accessToken, 'new_access_token_456');
            // refreshToken should remain the same or be empty
          },
        );

        verify(mockRemoteDataSource.refreshToken(testRefreshToken)).called(1);
      });

      test('should return ServerFailure when refresh token is invalid', () async {
        // Arrange
        final errorResponse = RefreshTokenResponseDto(
          status: 0,
          message: 'Invalid refresh token',
          data: null,
        );

        when(mockRemoteDataSource.refreshToken(any))
            .thenAnswer((_) async => errorResponse);

        // Act
        final result = await repository.refreshToken(testRefreshToken);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Invalid refresh token');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRemoteDataSource.refreshToken(testRefreshToken)).called(1);
      });
    });
  });
}
