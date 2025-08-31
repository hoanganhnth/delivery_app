import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/register_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/refresh_token_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

// Simple Mock DataSource Implementation
class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  bool shouldReturnSuccess = true;
  bool shouldThrowException = false;
  String? errorMessage;

  @override
  Future<Either<Exception, AuthResponseDto>> login(LoginRequestDto request) async {
    if (shouldThrowException) {
      return left(Exception('Network error'));
    }

    if (shouldReturnSuccess) {
      final authData = AuthDataDto(
        accessToken: 'test_access_token',
        refreshToken: 'test_refresh_token',
        user: UserDto(
          id: 1,
          email: request.email,
          name: 'Test User',
        ),
      );

      final response = AuthResponseDto(
        status: 1,
        message: 'Login successful',
        data: authData,
      );

      return right(response);
    } else {
      final response = AuthResponseDto(
        status: 0,
        message: errorMessage ?? 'Login failed',
        data: null,
      );

      return right(response);
    }
  }

  @override
  Future<Either<Exception, BaseResponseDto<bool>>> register(RegisterRequestDto request) async {
    if (shouldThrowException) {
      return left(Exception('Network error'));
    }

    if (shouldReturnSuccess) {
      // final authData = AuthDataDto(
      //   accessToken: 'test_access_token',
      //   refreshToken: 'test_refresh_token',
      //   user: UserDto(
      //     id: 1,
      //     email: request.email,
      //     name: request.name ?? 'Test User',
      //   ),
      // );

      // final response = AuthResponseDto(
      //   status: 1,
      //   message: 'Registration successful',
      //   data: authData,
      // );
      final response = BaseResponseDto<bool>(
        status: 1,
        message: 'Registration successful',
        data: true,
      );

      return right(response);
    } else {
      // final response = AuthResponseDto(
      //   status: 0,
      //   message: errorMessage ?? 'Registration failed',
      //   data: false,
      // );
      final response = BaseResponseDto<bool>(
        status: 0,
        message: errorMessage ?? 'Registration failed',
        data: false,
      );
      return right(response);
    }
  }

  @override
  Future<Either<Exception, RefreshTokenResponseDto>> refreshToken(String refreshToken) async {
    if (shouldThrowException) {
      return left(Exception('Network error'));
    }

    if (shouldReturnSuccess) {
      final refreshData = RefreshTokenDataDto(
        accessToken: 'new_access_token',
      );

      final response = RefreshTokenResponseDto(
        status: 1,
        message: 'Token refreshed successfully',
        data: refreshData,
      );

      return right(response);
    } else {
      final response = RefreshTokenResponseDto(
        status: 0,
        message: errorMessage ?? 'Token refresh failed',
        data: null,
      );

      return right(response);
    }
  }
}

void main() {
  late MockAuthRemoteDataSource dataSource;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
  });

  group('AuthRemoteDataSource Login Tests', () {
    final tLoginRequest = LoginRequestDto(
      email: 'test@example.com',
      password: 'password123',
      deviceId: 'device123',
      deviceName: 'iPhone 15',
      deviceType: 'iOS',
      ipAddress: '192.168.1.1',
    );

    test('should return success response when login is successful', () async {
      // arrange
      dataSource.shouldReturnSuccess = true;

      // act
      final result = await dataSource.login(tLoginRequest);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (exception) => fail('Should return success'),
        (response) {
          expect(response.status, 1);
          expect(response.message, 'Login successful');
          expect(response.data, isNotNull);
          expect(response.data!.accessToken, 'test_access_token');
          expect(response.data!.refreshToken, 'test_refresh_token');
          expect(response.data!.user!.email, 'test@example.com');
        },
      );
    });

    test('should return failure response when login returns error', () async {
      // arrange
      dataSource.shouldReturnSuccess = false;
      dataSource.errorMessage = 'Invalid credentials';

      // act
      final result = await dataSource.login(tLoginRequest);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (exception) => fail('Should return response'),
        (response) {
          expect(response.status, 0);
          expect(response.message, 'Invalid credentials');
          expect(response.data, isNull);
        },
      );
    });

    test('should return Exception when network error occurs', () async {
      // arrange
      dataSource.shouldThrowException = true;

      // act
      final result = await dataSource.login(tLoginRequest);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (exception) {
          expect(exception, isA<Exception>());
          expect(exception.toString(), contains('Network error'));
        },
        (response) => fail('Should return exception'),
      );
    });
  });

  group('AuthRemoteDataSource Register Tests', () {
    final tRegisterRequest = RegisterRequestDto(
      email: 'test@example.com',
      password: 'password123',
      name: 'Test User',
    );

    test('should return success response when register is successful', () async {
      // arrange
      dataSource.shouldReturnSuccess = true;

      // act
      final result = await dataSource.register(tRegisterRequest);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (exception) => fail('Should return success'),
        (response) {
          expect(response.status, 1);
          expect(response.message, 'Registration successful');
          expect(response.data, isNotNull);
          // expect(response.data!.user!.email, 'test@example.com');
          // expect(response.data!.user!.name, 'Test User');
        },
      );
    });

    test('should return failure response when register returns error', () async {
      // arrange
      dataSource.shouldReturnSuccess = false;
      dataSource.errorMessage = 'Email already exists';

      // act
      final result = await dataSource.register(tRegisterRequest);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (exception) => fail('Should return response'),
        (response) {
          expect(response.status, 0);
          expect(response.message, 'Email already exists');
          expect(response.data, isNull);
        },
      );
    });
  });

  group('AuthRemoteDataSource RefreshToken Tests', () {
    const tRefreshToken = 'test_refresh_token_123';

    test('should return new access token when refresh is successful', () async {
      // arrange
      dataSource.shouldReturnSuccess = true;

      // act
      final result = await dataSource.refreshToken(tRefreshToken);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (exception) => fail('Should return success'),
        (response) {
          expect(response.status, 1);
          expect(response.message, 'Token refreshed successfully');
          expect(response.data, isNotNull);
          expect(response.data!.accessToken, 'new_access_token');
        },
      );
    });

    test('should return failure when refresh token is invalid', () async {
      // arrange
      dataSource.shouldReturnSuccess = false;
      dataSource.errorMessage = 'Invalid refresh token';

      // act
      final result = await dataSource.refreshToken(tRefreshToken);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (exception) => fail('Should return response'),
        (response) {
          expect(response.status, 0);
          expect(response.message, 'Invalid refresh token');
          expect(response.data, isNull);
        },
      );
    });

    test('should handle network error during token refresh', () async {
      // arrange
      dataSource.shouldThrowException = true;

      // act
      final result = await dataSource.refreshToken(tRefreshToken);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (exception) {
          expect(exception, isA<Exception>());
          expect(exception.toString(), contains('Network error'));
        },
        (response) => fail('Should return exception'),
      );
    });
  });

  group('DataSource Interface Tests', () {
    test('should implement AuthRemoteDataSource interface', () {
      // assert
      expect(dataSource, isA<AuthRemoteDataSource>());
    });

    test('should handle all required methods', () async {
      // Test that all interface methods are implemented
      final loginRequest = LoginRequestDto(email: 'test@test.com', password: 'password');
      final registerRequest = RegisterRequestDto(email: 'test@test.com', password: 'password');

      // These should not throw compilation errors
      expect(() => dataSource.login(loginRequest), returnsNormally);
      expect(() => dataSource.register(registerRequest), returnsNormally);
      expect(() => dataSource.refreshToken('token'), returnsNormally);
    });
  });
}
